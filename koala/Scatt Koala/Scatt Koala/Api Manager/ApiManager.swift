import Foundation

struct APIError: Codable {
    let status: String?
    let msg: String
}

struct NetworkManager {
    enum Endpoint: String {
        case login
        case create
        case userCreation
        case scatCreate
        
        var path: String {
            switch self {
            case .login:
                return "/login"
            case .create:
                return "/koala/create"
            case .userCreation:
                return "userDetail/create"
            case .scatCreate:
                return "scat/create"
            }
        }
    }
    
    enum NetworkError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidResponse
        case serverError(APIError)
        case decodingFailed(Error)
        
        var serverErrorMessage: String? {
            if case .serverError(let apiError) = self {
                return apiError.msg
            }
            return nil
        }
        
        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "Invalid URL."
            case .requestFailed(let error):
                return "Request failed: \(error.localizedDescription)"
            case .invalidResponse:
                return "Invalid response from the server."
            case .serverError(let apiError):
                return "Server error - Status: \(apiError.status ?? "N/A"), Message: \(apiError.msg)"
            case .decodingFailed(let error):
                return "Failed to decode response: \(error.localizedDescription)"
            }
        }
    }

    static func performRequest<T: Decodable>(
        endpoint: Endpoint,
        method: String,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let baseURLString = "https://us-central1-koala-ba9f9.cloudfunctions.net/app/api"
        guard let baseURL = URL(string: baseURLString) else {
            completion(.failure(.invalidURL))
            return
        }
        let url = baseURL.appendingPathComponent(endpoint.path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if method != "GET" {
            do {
                // Convert the parameters dictionary to JSON data
                if let parameters = parameters {
                    let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                    request.httpBody = jsonData
                }
            } catch {
                completion(.failure(.requestFailed(error)))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                if let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                    completion(.failure(.serverError(apiError)))
                } else {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                }
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        
        task.resume()
    }
}
