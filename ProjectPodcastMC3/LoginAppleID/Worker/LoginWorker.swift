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
import SwiftKeychainWrapper

class LoginWorker {
    
    public static func loginApple(code: String, onSuccess: @escaping(_ result: String) -> Void, onFailed: @escaping(_ message: String) -> Void) {
        
        AF.request(VideoNetwork.loginApple(code: code)).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let loginResponseJSON: JSON = JSON(response.value ?? "")
                
                let uid = loginResponseJSON["id"].string
                print(uid)
                
                if let uid = uid {
                    KeychainWrapper.standard.set(uid, forKey: Constants.KEY_UID_KEYCHAIN)
                }
                                            
                onSuccess("code")
            case .failure(let error):
                onFailed(error.localizedDescription)
            }
        }
    }
    
    public static func submitVideo(params: [String: String], podcast: URL, designImage: UIImage, onSuccess: @escaping(_ result: String) -> Void, onFailed: @escaping(_ message: String) -> Void) {

        let fileName = (podcast.path as NSString).lastPathComponent
        print("PODCAST",podcast)
        let voiceData = try? Data(contentsOf: podcast)
        
        guard let dataAudio = voiceData else { return }
    
        let designImage = designImage
        guard let dataImage = designImage.jpegData(compressionQuality: 0.9) else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        let dateString = dateFormatter.string(from: NSDate() as Date)
        let imgName = "file.png"
        
        if let name = params["name"], let uid = params["uid"], let waveformPosition = params["waveformPosition"], let waveformColor = params["waveformColor"], let dimension = params["dimension"] {
            
            let url = "https://podcast.ganangariefp.xyz/submit?name=\(name)&uid=\(uid)&waveformPosition=\(waveformPosition)&waveformColor=\(waveformColor)&dimension=\(dimension)"
            print(url)

            AF.upload(multipartFormData: { (multipartFormData) in
//                multipartFormData.append(dataAudio, withName: "file")
//                multipartFormData.append(dataImage, withName: "file")
                multipartFormData.append(dataAudio, withName: "file", fileName: fileName, mimeType: "audio/mp3")
                multipartFormData.append(dataImage, withName: "file", fileName: imgName, mimeType: "image/png")
            }, to: url, method: .post).responseJSON { (response) in
                print(response)
                
//                switch response.result {
//                    case .success(_):
//                        print("SUCCESS")
//                    case .failure(let error):
//                        print("ERROR \(error.errorDescription)")
//                }
            }
        }
        
//        AF.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(dataAudio, withName: "audio", fileName: fileName, mimeType: "audio/m4a")
//            multipartFormData.append(dataImage, withName: "fileset", fileName: "file.jpg", mimeType: "image/jpg")
//        }, with: urlRequestConvertible).responseJSON { (response) in
//            switch response.result {
//            case .success(_):
//                print("SUCCESS")
//            case .failure(let error):
//                print("ERROR \(error.errorDescription)")
//            }
//        }
    }
}
