//
//  NetworkManager.swift
//  Golyv Task
//
//  Created by Walid Ahmed on 11/09/2023.
//

import Foundation
import UIKit

class NetworkManager {

    static let shared = NetworkManager()
    private init() {}
    
    enum NetworkError: Error {
        case invalidURL
        case requestFailed
        case decodingError
    }
    
    func request<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.requestFailed
        }
    }
    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        Task {
            do {
                let result: T = try await NetworkManager.shared.request(from: urlString)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func loadImage(from urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw NetworkError.decodingError
            }
        } catch {
            throw NetworkError.requestFailed
        }
    }
}
