//
//  ProductAPIService.swift
//  Application
//
//  Created by Ganpat Jangir on 27/12/25.
//

import Foundation

protocol ProductAPIServiceProtocol {
    func fetchProducts(page: Int, completion: @escaping (Result<ProductAPIResponseModel, APIError>) -> Void)
}

class ProductAPIService: ProductAPIServiceProtocol {
    func fetchProducts(
        page: Int,
        completion: @escaping (Result<ProductAPIResponseModel, APIError>) -> Void
    ) {
        
        guard NetworkMonitor.shared.isConnected else {
            completion(.failure(.noInternet))
            return
        }
        
        guard let url = URL(string: "https://fakeapi.net/products?page=\(page)&limit=10&category=electronics") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(ProductAPIResponseModel.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
