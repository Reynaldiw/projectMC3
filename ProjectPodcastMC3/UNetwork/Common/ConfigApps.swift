//
//  ConfigApps.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 05/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation

struct ConfigApps {
    private static func getConfig() -> Dictionary<String, Any>? {
        var myDict: Dictionary<String, Any>?
        
        // Get Path path of Config -> Dict ["baseUrl": https://listen-api.listennotes.com/api/v2]
        if let path = Bundle.main.path(forResource: "KMConfig", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String : Any] {
            myDict = dict
        }
        
        /*
         Get the url of path config
         Result: file:///Users/reynaldiwijaya/Library/Developer/CoreSimulator/Devices/299152F8-3715-4776-9B38-91B6BA7DB44E/data/Containers/Bundle/Application/BD5A4650-EDF1-4851-A07D-7D5CF89788A9/Belajar%20Movie.app/KMConfig.plist"
         */
        if let url = Bundle.main.url(forResource: "KMConfig", withExtension: "plist") {
            let d = NSDictionary(contentsOf: url)
            debugPrint("URL: \(url)")
            debugPrint(d ?? "")
        } else {
            debugPrint("No URL")
        }
        
        if let fileUrl = Bundle.main.url(forResource: "KMConfig", withExtension: "plist"), let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String : Any]] {
                print("result: \(result)")
            }
        }
        
        return myDict
    }
    
    public static func getUrlVideo() -> String {
        if let config = getConfig() {
            return config["baseUrlVideo"] as! String
        }
        return ""
    }
    
    public static func getUrl() -> String {
        if let config = getConfig() {
            return config["baseUrl"] as! String
        }
        return ""
    }
    
    public static func getApiKey() -> String {
        if let config = getConfig() {
            return config["apiKey"] as! String
        }
        return ""
    }
}
