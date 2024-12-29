//
//  NetworkManager.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private func request<T: Decodable>(_ endPoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void){
        
        let task = URLSession.shared.dataTask(with: endPoint.request()) { data , response , error in
            if let error = error {
                completion(.failure(error))
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            guard let data = data else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<MovieModel, Error>) -> Void){
        let endPoint = EndPoint.getPopular
        request(endPoint) { (result:Result<MovieModel, Error>) in
            completion(result)
        }
    }
    
    func getTopRated(completion: @escaping (Result<MovieModel, Error>) -> Void){
        let endPoint = EndPoint.getTopRated
        request(endPoint, completion: completion)
    }
    
    func getUpcoming(completion: @escaping (Result<MovieModel, Error>) -> Void){
        let endPoint = EndPoint.getUpComing
        request(endPoint, completion: completion)
    }
    
}

