//
//  DesignTemplateModel.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation

struct PotraitTemplateModel {
    var number: Int?
    var imageUrl: String?
    var isUploadImage: Bool?
    var isTextField1: Bool?
    var isTextField2: Bool?
    var isTextField3: Bool?
    var isEditColor1: Bool?
    var isEditColor2: Bool?
    var isEditWaveform: Bool?
    
    
    static func getDummyData() -> [PotraitTemplateModel] {
        var result = [PotraitTemplateModel]()
        
        let image0 = PotraitTemplateModel(number: 0, imageUrl: "empty", isUploadImage: false, isTextField1: false, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false)
        let image1 = PotraitTemplateModel(number: 0, imageUrl: "image-potrait3", isUploadImage: true, isTextField1: true, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false)
        let image2 = PotraitTemplateModel(number: 1, imageUrl: "image-potrait3", isUploadImage: true, isTextField1: true, isTextField2: true, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false)

        
        result.append(image0)
        result.append(image1)
        result.append(image2)

        return result
        
        
    }
}


struct SquareTemplateModel {
    var number: Int?
    var imageUrl: String?
    var isUploadImage: Bool?
    var isTextField1: Bool?
    var textFieldName1: String?
    var isTextField2: Bool?
    var textFieldName2: String?
    var isTextField3: Bool?
    var textFieldName3: String?
    var isEditColor1: Bool?
    var isEditColor2: Bool?
    var isEditWaveform: Bool?
    //var viewClassName: String?
    
    
    static func getDummyData() -> [SquareTemplateModel] {
        var result = [SquareTemplateModel]()
        
        let image0 = SquareTemplateModel(number: 0, imageUrl: "empty", isUploadImage: false, isTextField1: false, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false)
        let image1 = SquareTemplateModel(number: 0, imageUrl: "image-square1", isUploadImage: true, isTextField1: false, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false)
        let image2 = SquareTemplateModel(number: 1, imageUrl: "image-square1", isUploadImage: true, isTextField1: true, isTextField2: true, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false)

        result.append(image0)
        result.append(image1)
        result.append(image2)

        return result
        
        
    }
}
