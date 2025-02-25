//
//  APIService.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 18.02.25.
//


import Foundation

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func fetch<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let requestURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}