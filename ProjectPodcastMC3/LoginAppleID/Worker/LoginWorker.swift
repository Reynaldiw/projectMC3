//
//  LoginWorker.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 14/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginWorker {
    
    public static func loginApple(code: String, onSuccess: @escaping(_ result: String) -> Void, onFailed: @escaping(_ message: String) -> Void) {
        
        AF.request(VideoNetwork.loginApple(code: code)).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let loginResponseJSON: JSON = JSON(response.value ?? "")
                
                let uid = loginResponseJSON["id"].string
                                
                onSuccess("code")
            case .failure(let error):
                onFailed(error.localizedDescription)
            }
        }
    }
    
    public static func submitVideo(params: [String: Any], onSuccess: @escaping(_ result: String) -> Void, onFailed: @escaping(_ message: String) -> Void) {
        
        //        let fileName = (podcast.path as NSString).lastPathComponent
        //        let mimeType = fileName.mimeType()
        //        print("PODCAST",podcast)
        //        let voiceData = try? Data(contentsOf: podcast)
        //
        //        let designImage = UIImage
        //        guard let data = coverImage.jpegData(compressionQuality: 0.9) else {
        //            return
        //        }
        
        AF.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(music, withName: <#T##String#>)
//            multipartFormData.append(image, withName: <#T##String#>)
            }, to: VideoNetwork.submitVideo(params: params) as! URLConvertible).responseJSON
        { (response) in
            switch response.result {
            case .success(_):
                print("SUCCESS")
            case .failure(_):
                print("ERROR")
            }
        }
        
    }

}
