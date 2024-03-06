//
//  RESTAPIManager.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import Alamofire

struct RESTAPIManager: APIManager {
    private func makeRequest(withEncodable: Bool, endpoint: APIEndpoint) -> DataRequest? {
        guard let endpoint = endpoint as? RESTEnpoint else { fatalError("invalid router type") }
        guard let path = endpoint.url, let url = URL(string: endpoint.baseURL + path) else { return nil }
        return withEncodable ? 
        AF.request(url, method: endpoint.method, parameters: endpoint.encodableParameters, encoder: endpoint.encoder, headers: endpoint.headers) :
        AF.request(url, method: endpoint.method, parameters: endpoint.parameters, headers: endpoint.headers)
    }
    
    func request( withEncodable: Bool, endpoint: APIEndpoint, result: @escaping (AFResult<APIResponse>) -> Void) {
        guard let request = makeRequest(withEncodable: withEncodable, endpoint: endpoint) 
        else {
            result(.failure(NeoBlogNetworkError.failedToSignIn))
            return
        }
            request
            //.validate()
            .responseData { AFresponse in
                  if let error = AFresponse.error {
                      result(.failure(error));
                      return
                  }
                  switch AFresponse.result {
                  case .success(let data):
                      let resp = RESTAPIResponse(response: AFresponse.response, result: data, error: AFresponse.error)
                      result(.success(resp))
                  case .failure(let error):
                      result(.failure(error))
                  }
            }
    }
    
    private func makeMultipartRequest(endpoint: APIEndpoint) -> UploadRequest? {
        guard let endpoint = endpoint as? RESTEnpoint else { fatalError("invalid router type") }
        guard let path = endpoint.url, let url = URL(string: endpoint.baseURL + path) else { return nil }
        guard let parameters = endpoint.parameters else { return nil }
        
        return AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let string = value as? String, let data = string.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                } else if let id = value as? Int, let data = id.description.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                } else if let data = value as? Data {
                    multipartFormData.append(data, withName: key, fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }
        }, to: url, method: endpoint.method, headers: endpoint.headers)
    }
    
    func multipartRequest(endpoint: APIEndpoint, result: @escaping (AFResult<APIResponse>) -> Void) {
        guard let uploadRequest = makeMultipartRequest(endpoint: endpoint) else { return }
        uploadRequest
            //.validate()
            .responseData { AFResponse in
                if let error = AFResponse.error {
                    result(.failure(error));
                    return
                }
                switch AFResponse.result {
                case .success(let data):
                    let resp = RESTAPIResponse(response: AFResponse.response, result: data, error: AFResponse.error)
                    result(.success(resp))
                case .failure(let error):
                    result(.failure(error))
                }
            }
    }
}
