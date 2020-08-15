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
    var waveformPosition: String?
    
    
    static func getDummyData() -> [PotraitTemplateModel] {
        var result = [PotraitTemplateModel]()
        
        let image0 = PotraitTemplateModel(number: 0, imageUrl: "empty", isUploadImage: false, isTextField1: false, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image1 = PotraitTemplateModel(number: 1, imageUrl: "image-potrait3", isUploadImage: true, isTextField1: true, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image2 = PotraitTemplateModel(number: 2, imageUrl: "imageView-potrait2", isUploadImage: true, isTextField1: false, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image3 = PotraitTemplateModel(number: 3, imageUrl: "imageView-potrait3", isUploadImage: true, isTextField1: true, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image4 = PotraitTemplateModel(number: 4, imageUrl: "imageView-potrait4", isUploadImage: true, isTextField1: true, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image5 = PotraitTemplateModel(number: 5, imageUrl: "imageView-potrait5", isUploadImage: true, isTextField1: true, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "middle")
        let image6 = PotraitTemplateModel(number: 6, imageUrl: "imageView-potrait6", isUploadImage: true, isTextField1: true, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "top")

        
        result.append(image0)
        result.append(image1)
        result.append(image2)
        result.append(image3)
        result.append(image4)
        result.append(image5)
        result.append(image6)

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
    var waveformPosition: String?
    
    
    static func getDummyData() -> [SquareTemplateModel] {
        var result = [SquareTemplateModel]()
        
        let image0 = SquareTemplateModel(number: 0, imageUrl: "empty", isUploadImage: false, isTextField1: false, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image1 = SquareTemplateModel(number: 1, imageUrl: "image-squareTemp1", isUploadImage: true, isTextField1: false, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image2 = SquareTemplateModel(number: 2, imageUrl: "image-squareTemp2", isUploadImage: true, isTextField1: true, isTextField2: true, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image3 = SquareTemplateModel(number: 3, imageUrl: "imageView-square3", isUploadImage: true, isTextField1: true, isTextField2: false, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image4 = SquareTemplateModel(number: 4, imageUrl: "imageView-square4", isUploadImage: true, isTextField1: true, isTextField2: true, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image5 = SquareTemplateModel(number: 5, imageUrl: "imageView-square5", isUploadImage: true, isTextField1: true, isTextField2: true, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "bottom")
        let image6 = SquareTemplateModel(number: 6, imageUrl: "imageView-square6", isUploadImage: true, isTextField1: true, isTextField2: true, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "middle")
        let image7 = SquareTemplateModel(number: 7, imageUrl: "imageView-square7", isUploadImage: true, isTextField1: true, isTextField2: true, isTextField3: false, isEditColor1: true, isEditColor2: false, isEditWaveform: false, waveformPosition: "top")
        
        
        
        

        result.append(image0)
        result.append(image1)
        result.append(image2)
        result.append(image3)
        result.append(image4)
        result.append(image5)
        result.append(image6)
        result.append(image7)

        return result
        
        
    }
}
