//
//  ImageCacheble.swift
//  DemoProject
//
//  Created by K12 Services on 04/01/21.
//

import Foundation
import UIKit

//1 Create the protocol
protocol Cachable {}

//2 creating a imageCache private instance
private  let imageCache = NSCache<NSString, UIImage>()

//3 UIImageview conforms to Cachable
extension UIImageView: Cachable {}

//4 creating a protocol extension to add optional function implementations,
extension Cachable where Self: UIImageView {
    
    //5 creating the function
    typealias SuccessCompletion = (Bool) -> ()
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                self.contentMode = .scaleAspectFill
                completion(true)
            }
            return
        }
        self.image = placeHolder
        self.contentMode = .center
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                self.contentMode = .scaleAspectFill
                                completion(true)
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                        self.contentMode = .center
                    }
                }
            }).resume()
        } else {
            self.image = placeHolder
            self.contentMode = .center
        }
    }
}
