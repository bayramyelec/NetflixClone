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
        request(endPoint) { (result:Result<MovieModel, Error>) in
            completion(result)
        }
    }
    
    func getUpcoming(completion: @escaping (Result<MovieModel, Error>) -> Void){
        let endPoint = EndPoint.getUpComing
        request(endPoint, completion: completion)
    }
    
    func fetchTrending(completion: @escaping (Result<MovieModel, Error>) -> Void){
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=a2b824df372550b39cb5be766e3ec3a5") else {return}
        URLSession.shared.dataTask(with: url) { data, response , error in
            if let error = error {
                print("Error fetching trending movies: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("Error fetching trending movies: No data")
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            do {
                let movieModel = try JSONDecoder().decode(MovieModel.self, from: data)
                completion(.success(movieModel))
            } catch {
                print("Error decoding trending movies: \(error)")
            }
        }.resume()
    }
    
}

