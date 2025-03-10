//
//  APIHelper.swift
//  ComicVN
//
//  Created by Tuấn on 8/3/25.
//

import Foundation

class APIHelper {
    
    // Hàm gọi API chung cho tất cả các model
    static func fetchData<T: Codable>(urlString: String,
                                      method: String = "GET",
                                      parameters: [String: Any]? = nil,
                                      completion: @escaping (Result<T, Error>) -> Void) {
        
        // Xây dựng URL
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            print("Loi url")
            return
        }
        
        // Tạo yêu cầu API
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Thêm parameters nếu có
        if let parameters = parameters, method == "POST" {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            } catch {
                completion(.failure(error))
                print("Loi param")
                return
            }
        }
        
        // Thực hiện yêu cầu với URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Kiểm tra lỗi kết nối
            if let error = error {
                completion(.failure(error))
                print("Loi ket noi")
                return
            }
            
            // Kiểm tra mã trạng thái HTTP
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                completion(.failure(NetworkError.invalidResponse))
                print("Loi != 200")
                return
            }
            
            // Kiểm tra dữ liệu trả về
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                print("Loi khong data")
                return
            }
            // Giải mã JSON thành model
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Loi decode")
                completion(.failure(NetworkError.decodingError(error)))
            }
        }.resume()
    }
    
    // Các lỗi thường gặp
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case noData
        case decodingError(Error)
    }
}
