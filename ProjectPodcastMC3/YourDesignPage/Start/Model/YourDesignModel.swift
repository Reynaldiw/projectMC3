//
//  YourDesignModel.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

struct YourDesignCVModel {
    var imageUrl: String?
    var title: String?
    var isClickable: Bool?
    
    static func getDummyData() -> [YourDesignCVModel] {
        var result = [YourDesignCVModel]()
        let template = YourDesignCVModel(imageUrl: "template", title: "template", isClickable: true)
        let image = YourDesignCVModel(imageUrl: "image", title: "image", isClickable: false)
        let waveform = YourDesignCVModel(imageUrl: "waveform", title: "waveform", isClickable: false)
        let text = YourDesignCVModel(imageUrl: "text", title: "text", isClickable: false)
        let background = YourDesignCVModel(imageUrl: "background", title: "background", isClickable: false)
        
        result.append(template)
        result.append(image)
        result.append(waveform)
        result.append(text)
        result.append(background)

        
        return result
        
        
    }
}
