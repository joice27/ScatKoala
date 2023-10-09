import Foundation
import UIKit

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
        case verifyOtp
        case uploadPic
        
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
            case .verifyOtp:
                return "verify/otp"
            case .uploadPic:
                return "uploadPic"
            }
        }
    }
    
    enum ApiType: String {
        case POST
        case GET
        case PUT
        case DELETE
        
        var path: String {
            switch self {
                
            case .POST:
                return "POST"
            case .GET:
                return "GET"
            case .PUT:
                return "PUT"
            case .DELETE:
                return "DELETE"
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
        method: ApiType,
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
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if method.rawValue != ApiType.GET.rawValue {
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
                //                if let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                //                    completion(.failure(.serverError(apiError)))
                //                } else {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
                //                }
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        
        task.resume()
    }
    
    static func uploadImage(image: UIImage, onCompletion: @escaping (ImageResponse?) -> ()) {
       guard let url = URL(string: "https://us-central1-koala-ba9f9.cloudfunctions.net/app/api/uploadPic") else {
           print("Invalid URL")
           return
       }
       
       // Generate a unique boundary string
       let boundary = "Boundary-\(UUID().uuidString)"
       
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       
       // Set Content-Type Header to multipart/form-data with the boundary
       request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
       let httpBody = NSMutableData()
       
       // Append image data
       httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
       httpBody.append("Content-Disposition: form-data; name=\"profileImage\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
       httpBody.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
       
       if let imageData = image.pngData() {
           httpBody.append(imageData)
       } else {
           print("Failed to convert image to data")
           return
       }
       
       httpBody.append("\r\n".data(using: .utf8)!)
       
       // Close boundary
       httpBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
       
       request.httpBody = httpBody as Data
       
       let task = URLSession.shared.dataTask(with: request) { data, response, error in
           if let error = error {
               print("Error: \(error)")
               return
           }
           
           if let data = data {
               if let responseString = String(data: data, encoding: .utf8) {
                   print(responseString)
               }
               let decoder = JSONDecoder()
               let uploadResponse = try! decoder.decode(ImageResponse.self, from: data)
               onCompletion(uploadResponse)
           }
       }
       task.resume()
   }
}
