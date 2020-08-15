//
//  EditRepository.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 14/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation
import AVFoundation

struct RangeTime {
    var startTime: Int = 0
    var endTime: Int = 0
}

class EditAudioRepository {
    
    static func checkBookFileExists(withLink link: String, completion: @escaping ((_ filePath: URL)->Void), failed: @escaping((_ message: String) -> Void)){
        
        let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print("urlString: \(urlString)")
        
        if let url  = URL.init(string: urlString ?? ""){
            let fileManager = FileManager.default
            if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){

                print("documentDirectory: \(documentDirectory)")
                
                let filename = "\(url.lastPathComponent).mp3"
                let filePath = documentDirectory.appendingPathComponent(filename, isDirectory: false)
                print("filePath: \(filePath)")

                do {
                    if try filePath.checkResourceIsReachable() {
                        print("file exist")
                        completion(filePath)

                    } else {
                        print("file doesnt exist")
                        EditAudioRepository.downloadFile(withUrl: url, andFilePath: filePath, completion: completion, failed: failed)
                    }
                } catch {
                    print("file doesnt exist")
                    EditAudioRepository.downloadFile(withUrl: url, andFilePath: filePath, completion: completion, failed: failed)
                }
            }else{
                print("file doesnt exist")
                failed("File Doesnt Exist")
            }
        }else{
                print("file doesnt exist")
                failed("File Doesnt Exist")
        }
    }
    
    static func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void), failed: @escaping ((_ message: String) -> Void)){
        
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data.init(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                print("saved at \(filePath.absoluteString)")
                DispatchQueue.main.async {
                    print("here")
                    completion(filePath)
                }
            } catch {
                failed("an error happened while downloading or saving the file")
                print("an error happened while downloading or saving the file")
            }
        }
    }
    
    static func trimAudio(urlAudio: URL, rangeTime: RangeTime, outputFileName: String, successEditAudio: @escaping(_ urlResult: URL) -> Void, failed: @escaping(_ message: String) -> Void) {
        
        let assetAudio = AVURLAsset(url: urlAudio, options: [AVURLAssetPreferPreciseDurationAndTimingKey: true])

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let trimmedSoundFileURL = documentsDirectory.appendingPathComponent("\(outputFileName).m4a")
        print("saving to \(trimmedSoundFileURL.absoluteString)")

        print("creating export session for \(assetAudio)")

        if let exporter = AVAssetExportSession(asset: assetAudio, presetName: AVAssetExportPresetAppleM4A) {
            exporter.outputFileType = AVFileType.m4a
            exporter.outputURL = trimmedSoundFileURL as URL

            // e.g. the first 5 seconds
            let startTime = CMTimeMake(value: Int64(rangeTime.startTime), timescale: 1)
            let stopTime = CMTimeMake(value: Int64(rangeTime.endTime), timescale: 1)
            exporter.timeRange = CMTimeRangeFromTimeToTime(start: startTime, end: stopTime)

            // do it
            exporter.exportAsynchronously(completionHandler: {
                print("export complete \(exporter.status)")

                switch exporter.status {
                case  AVAssetExportSession.Status.failed:

                    if let e = exporter.error {
                        failed("export failed \(e)")
                        print("export failed \(e)")
                    }

                case AVAssetExportSession.Status.cancelled:
                    print("export cancelled \(String(describing: exporter.error))")

                case AVAssetExportSession.Status.completed:
                    print("export complete")
                    successEditAudio(trimmedSoundFileURL)

                default:
                    break
                }
            })
        } else {
            print("cannot create AVAssetExportSession for asset \(assetAudio)")
            failed("Failed to Create Asset Export Session")
        }
    }
    
    static func merge(audioFilesURL: [URL], fileName: String, successExport: @escaping(_ url: URL) -> Void, failedExport: @escaping(_ message: String) -> Void) {
                
        let composition = AVMutableComposition()
        
        for i in 0..<audioFilesURL.count {
            
            //Create AVMutableComposition Object.This object will hold our multiple AVMutableCompositionTrack.
            let compositionAudioTrack: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: CMPersistentTrackID())!
            
            let avAsset = AVURLAsset(url: audioFilesURL[i])
            
            let tracks =  avAsset.tracks(withMediaType: AVMediaType.audio)
            
            if tracks.count == 0 {
                failedExport("URL Asset not found")
                return
            }
            
            let track = tracks[0]
            
            let timeRange = CMTimeRange(start: CMTimeMake(value: 0, timescale: 1), duration: track.timeRange.duration)
            
            try! compositionAudioTrack.insertTimeRange(timeRange, of: track, at: composition.duration)
            
        }
        
        //create new file to receive data
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileDestinationUrl = documentDirectoryURL?.appendingPathComponent("\(fileName).m4a")
        print(fileDestinationUrl?.absoluteString ?? "")
        
        if let assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A) {
            
            assetExport.outputFileType = AVFileType.m4a
            assetExport.outputURL = fileDestinationUrl
            assetExport.exportAsynchronously(completionHandler: {
                
                switch assetExport.status{
                case  AVAssetExportSessionStatus.failed:
                    
                    if let e = assetExport.error {
                        failedExport("export merge failed \(e)")
                    }
                    
                case AVAssetExportSessionStatus.cancelled:
                    failedExport("export merge cancelled \(String(describing: assetExport.error))")
                default:
                    print("Export Merge Success")
                    successExport(fileDestinationUrl!)
                }
            })
        }
    }
    
    static func isFileURLExist(url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    static func removeExistingFile(atPath url: URL) {
        if isFileURLExist(url: url) {
            do {
                try FileManager.default.removeItem(atPath: url.path)
                print("Success Remove")
            } catch {
                print("could not remove \(url)")
                print(error.localizedDescription)
            }
        }
    }
    
    static func getNumberForFileManager() -> Int {
        var number = UserDefaults.standard.integer(forKey: Constants.KEY_NUMBER_FOR_FILEMANAGER)
        
        if number == 0 {
            UserDefaults.standard.set(1, forKey: Constants.KEY_NUMBER_FOR_FILEMANAGER)
            number = UserDefaults.standard.integer(forKey: Constants.KEY_NUMBER_FOR_FILEMANAGER)
        }
        
        UserDefaults.standard.set(number + 1, forKey: Constants.KEY_NUMBER_FOR_FILEMANAGER)
        
        return number
    }
    
    
//    static func trimAudio(urlAudio: URL, rangeTime: RangeTime, outputFileName: String, successEditAudio: @escaping(_ urlResult: URL) -> Void, failed: @escaping(_ message: String) -> Void) {
//
//        let asset = AVAsset(url: urlAudio)
//
//        guard asset.isExportable else {
//            failed("Not Exportable")
//            return
//        }
//
//        let composition = AVMutableComposition()
//        let compositionAudioTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid))
//
//        let sourceAudioTrack = asset.tracks(withMediaType: AVMediaType.audio).first!
//        do {
//            try compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: asset.duration), of: sourceAudioTrack, at: CMTime.zero)
//        } catch(_) {
//            failed("Error of Composition")
//            return
//        }
//
//        let compatiblePresets = AVAssetExportSession.exportPresets(compatibleWith: composition)
//        var preset: String = AVAssetExportPresetPassthrough
//        if compatiblePresets.contains(AVAssetExportPresetAppleM4A) { preset = AVAssetExportPresetAppleM4A }
//
//        guard
//            let exportSession = AVAssetExportSession(asset: composition, presetName: preset),
//            exportSession.supportedFileTypes.contains(AVFileType.m4a) else {
//            failed("error export")
//            return
//        }
//
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let trimmedSoundFileURL = documentsDirectory.appendingPathComponent("\(outputFileName).m4a")
//
//        exportSession.outputURL = trimmedSoundFileURL
//        exportSession.outputFileType = AVFileType.m4a
//
//        let startTime = CMTimeMake(value: Int64(rangeTime.startTime), timescale: 1)
//        let stopTime = CMTimeMake(value: Int64(rangeTime.endTime), timescale: 1)
//        exportSession.timeRange = CMTimeRangeFromTimeToTime(start: startTime, end: stopTime)
//
//        exportSession.exportAsynchronously(completionHandler: {
//
//            switch exportSession.status{
//            case  AVAssetExportSessionStatus.failed:
//
//                if let e = exportSession.error {
//                    failed("export merge failed \(e)")
//                }
//
//            case AVAssetExportSessionStatus.cancelled:
//                failed("export merge cancelled \(String(describing: exportSession.error))")
//
//            default:
//                print("Export Merge Success")
//                print(trimmedSoundFileURL.absoluteString)
//                successEditAudio(trimmedSoundFileURL)
//            }
//        })
//    }
    
//    static func editAudioForIGStory(urlAudio: URL, ranges: [RangeTime], outputFileName: String, successEditAudio: @escaping(_ urlResult: URL) -> Void, failed: @escaping(_ message: String) -> Void) {
//
//        var urls = [URL]()
//
//        for i in 0..<ranges.count {
//
//            let temporaryOutputFileName = String( EditAudioRepository.getNumberForFileManager())
//
//            if ranges.count == 1 {
//                trimAudio(urlAudio: urlAudio, rangeTime: ranges[i], outputFileName: outputFileName, successEditAudio: { (url) in
//
//                    let asset = AVAsset(url: url)
//                    let duration = CMTimeGetSeconds(asset.duration)
//
//                    if duration > 15 {
//                        failed("Duration is too long for IG Story, Try to edit audio compatible with IG Story, which is max 15 Seconds")
//                        removeExistingFile(atPath: url)
//                        return
//                    }
//
//                    successEditAudio(url)
//                    return
//
//                }) { (message) in
//                    failed(message)
//                    return
//                }
//            } else {
//                trimAudio(urlAudio: urlAudio, rangeTime: ranges[i], outputFileName: temporaryOutputFileName, successEditAudio: { (url) in
//
//                    urls.append(url)
//
//                }) { (message) in
//
//                    failed(message)
//                    return
//                }
//                continue
//            }
//        }
//
//        for _ in 0... {
//
//            if urls.count == ranges.count {
//
//                var urlsString = [String]()
//
//                for i in 0..<urls.count {
//                    let urlString = urls[i].absoluteString
//                    urlsString.append(urlString)
//                }
//                urlsString.sort()
//
//                var newUrls = [URL]()
//
//                for i in 0..<urlsString.count {
//                    if let url = URL(string: urlsString[i]) {
//                        newUrls.append(url)
//                    }
//                }
//
//                print(newUrls)
//                EditAudioRepository.merge(audioFilesURL: newUrls, fileName: outputFileName, successExport: { (url) in
//                    print("this merge")
//
//                    for i in 0..<newUrls.count {
//                        let url = newUrls[i]
//                        removeExistingFile(atPath: url)
//                    }
//
//                    let asset = AVAsset(url: url)
//                    let duration = CMTimeGetSeconds(asset.duration)
//
//                    if duration > 15 {
//                        failed("Duration is too long for IG Story, Try to edit audio compatible with IG Story, which is max 15 Seconds")
//                        removeExistingFile(atPath: url)
//                        return
//                    }
//
//                    successEditAudio(url)
//
//                }) { (message) in
//                    failed("Fail to trim audio")
//                }
//                return
//
//            } else {
//                continue
//            }
//        }
//    }
}
