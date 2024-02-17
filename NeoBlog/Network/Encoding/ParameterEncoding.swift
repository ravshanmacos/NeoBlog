//
//  ParameterEncoding.swift
//  NetworkingLayerFromNeoBlog
//
//  Created by Ravshan Winter on 13/02/24.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
