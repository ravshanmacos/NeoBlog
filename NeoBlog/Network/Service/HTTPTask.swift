//
//  HTTPTask.swift
//  NetworkingLayerFromNeoBlog
//
//  Created by Ravshan Winter on 13/02/24.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request
    case requestWithParameters(bodyParameters: Parameters?, 
                               urlParameters: Parameters?)
    case requestWithParametersAndHeaders(bodyParameters: Parameters?, 
                                         urlParameters: Parameters?,
                                         additionalHeaders: HTTPHeaders?)
    //case upload, download ..etc
}
