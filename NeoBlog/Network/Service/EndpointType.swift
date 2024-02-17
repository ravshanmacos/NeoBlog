//
//  EndpointType.swift
//  NetworkingLayerFromNeoBlog
//
//  Created by Ravshan Winter on 13/02/24.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
