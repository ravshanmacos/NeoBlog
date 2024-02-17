//
//  MovieEnpoint.swift
//  NetworkingLayerFromNeoBlog
//
//  Created by Ravshan Winter on 13/02/24.
//

import Foundation

enum NetworkEnviroment {
    case qa
    case production
    case staging
}

enum MovieAPI {
    case recommended(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
}

extension MovieAPI: EndpointType {
    
    var eniviromentBaseURL: String {
        switch NetworkManager.enviroment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: eniviromentBaseURL) else { fatalError("Base url couldn't be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
            
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            let parameters: [String: Any] = ["page": page, "api_key": NetworkManager.movieAPIKey]
            return .requestWithParameters(bodyParameters: nil, urlParameters: parameters)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
