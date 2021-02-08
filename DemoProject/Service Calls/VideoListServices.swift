//
//  VideoListServices.swift
//  DemoProject
//
//  Created by K12 Services on 02/01/21.
//

import Foundation

extension ApiHelper {
    
    func getVideoListApi(setUrl: String, success: @escaping(Data) -> (), failure: @escaping(serviceError) -> ()){
        GetRequest(endpoint: setUrl, headers: nil, failure: { (err) in
            failure(err)
        }) { (data) in
            success(data)
        }
    }
}
