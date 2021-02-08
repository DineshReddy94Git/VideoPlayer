//
//  VideoListViewModel.swift
//  DemoProject
//
//  Created by K12 Services on 02/01/21.
//

import UIKit

class VideoListViewModel: NSObject {

    var videoList : [VideoListModel]? = nil
    
    func getVideoList(completion: (() -> Void)?){
        
        let myEndPoint = "media.json?print=pretty"
        
        ApiHelper.shared.getVideoListApi(setUrl: myEndPoint) { [weak self] (successJson) in
            guard let self = self else { return } // To handle memory leak
            do {
                let data = try JSONDecoder().decode([VideoListModel].self, from: successJson)
                self.videoList = data
            } catch let err {
                print(err.localizedDescription)
            }
            completion?()
        } failure: { (err) in
            print("Error = \(err.localizedDescription)")
        }

    }
    
}
