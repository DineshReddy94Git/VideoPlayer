//
//  ApiHelper.swift
//  K12TeachersApp
//
//  Created by K12 Techno Services Dinesh on 19/08/20.
//  Copyright © 2020 K12 Techno Services. All rights reserved.
//
import Foundation

class ApiHelper: Any {
    var header = [String: String]()
    static let shared = ApiHelper()
    private init (){}
    private func MakeRequest<T>(method: HTTPMethod, endpoint: String, httpHeaders: [String:String]? = nil, payloadBody: [String: Any]? = nil, failure: @escaping (serviceError) -> (), success: @escaping (_ data: T)->()) {
        
        let SET_URL = URL(string: baseUrl + endpoint)
        var urlRequest = URLRequest(url: SET_URL!)
        urlRequest.httpMethod = "\(method)"
        urlRequest.allHTTPHeaderFields = httpHeaders
        print("SET_URL = \(SET_URL?.description ?? "")")
        if method != .get {
            guard   let body = try? JSONSerialization.data(withJSONObject: payloadBody ?? "") else {
                print("\n*** serialize sad\n")
                return
            }
            urlRequest.httpBody = body
        }
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            // status code
            if let errorCode = urlResponse as? HTTPURLResponse{
                if (500...599).contains(errorCode.statusCode) {
//                    DispatchQueue.main.async {
//                        let alert = UIAlertController(title: "\(errorCode.statusCode)", message: "something went wrong...", preferredStyle: UIAlertController.Style.alert)
//                        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                        alert.addAction(action)
//                        alert.show()
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showEmptyData"), object: nil)
//                    }
                }else {
                    if let err = error {
                        failure(serviceError.defaultError(error: err as NSError))
                        return
                    }
                    
                    guard let data = data else { return print("*****--- Serialization falied ---*****")}
                    if let response = data as? T {
                        success(response)
                    }
                }
            }
            
            
        }
        
        urlSession.resume()
        
    }
}

extension ApiHelper {
    
    public func GetRequest<T>(endpoint: String, headers: [String: String]? = nil, failure: @escaping (serviceError) -> (), success: @escaping (_ data: T)->()) {
        MakeRequest(method: .get, endpoint: endpoint, httpHeaders: headers, payloadBody: nil, failure: failure, success: success)
    }
    
    public func PostRequest<T>(endpoint: String,headers: [String: String]? = nil, payloads: [String: Any]? = nil, failure: @escaping (serviceError) -> (), success: @escaping (_ data: T)->()) {
        MakeRequest(method: .post, endpoint: endpoint, httpHeaders: headers, payloadBody: payloads, failure: failure, success: success)
    }
    public func PutRequest<T>(endpoint: String,headers: [String: String]? = nil, payloads: [String: Any]? = nil, failure: @escaping (serviceError) -> (), success: @escaping (_ data: T)->()) {
        MakeRequest(method: .put, endpoint: endpoint, httpHeaders: headers, payloadBody: payloads, failure: failure, success: success)
    }
    public func DeleteRequest<T>(endpoint: String,headers: [String: String]? = nil, payloads: [String: Any]? = nil, failure: @escaping (serviceError) -> (), success: @escaping (_ data: T)->()) {
        MakeRequest(method: .delete, endpoint: endpoint, httpHeaders: headers, payloadBody: payloads, failure: failure, success: success)
    }
}
