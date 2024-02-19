//
//  RESTAPIEnpoint.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import Alamofire

protocol RESTEnpoint: APIEndpoint {
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var encodableParameters: Encodable { get }
    var parameters: Parameters? { get }
    var encoder: JSONParameterEncoder { get }
    var baseURL: String { get }
    var url: String? { get }
}

extension RESTEnpoint {
    var baseURL: String {
        return Secrets.baseURL.rawValue
    }
    var headers: HTTPHeaders? {
        return ["Content-type": "application/json"]
    }
}
