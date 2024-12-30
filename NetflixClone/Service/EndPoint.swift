//
//  EndPoint.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

// https://api.themoviedb.org/3/movie/popular?api_key=a2b824df372550b39cb5be766e3ec3a5

import Foundation

protocol EndPointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var apiKey: String { get }
    var method: HTTPMethod { get }
    func mainURL() -> String
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum EndPoint {
    case getPopular
    case getTopRated
    case getUpComing
}

extension EndPoint: EndPointProtocol {
    var baseURL: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    var path: String {
        switch self {
        case .getPopular:
            return "popular"
        case .getTopRated:
            return "top_rated"
        case .getUpComing:
            return "upcoming"
        }
    }
    
    var apiKey: String {
        return "?api_key=a2b824df372550b39cb5be766e3ec3a5"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPopular:
            return .get
        case .getTopRated:
            return .get
        case .getUpComing:
            return .get
        }
    }
    
    func mainURL() -> String {
        return "\(baseURL)\(path)\(apiKey)"
    }
    
    func request() -> URLRequest {
        guard let url = URL(string: mainURL()) else { fatalError("Invalid URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
