//
//  DAOEpisodesEpisodes.swift
//
//  Created by Reynaldi Wijaya on 07/08/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOEpisodes: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let audio = "audio"
    static let thumbnail = "thumbnail"
    static let descriptionValue = "description"
    static let audioLengthSec = "audio_length_sec"
    static let title = "title"
    static let listennotesUrl = "listennotes_url"
    static let pubDateMs = "pub_date_ms"
  }

  // MARK: Properties
  public var id: String?
  public var audio: String?
  public var thumbnail: String?
  public var descriptionValue: String?
  public var audioLengthSec: Int?
  public var title: String?
  public var listennotesUrl: String?
  public var pubDateMs: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    id = json[SerializationKeys.id].string
    audio = json[SerializationKeys.audio].string
    thumbnail = json[SerializationKeys.thumbnail].string
    descriptionValue = json[SerializationKeys.descriptionValue].string
    audioLengthSec = json[SerializationKeys.audioLengthSec].int
    title = json[SerializationKeys.title].string
    listennotesUrl = json[SerializationKeys.listennotesUrl].string
    pubDateMs = json[SerializationKeys.pubDateMs].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = audio { dictionary[SerializationKeys.audio] = value }
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = audioLengthSec { dictionary[SerializationKeys.audioLengthSec] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = listennotesUrl { dictionary[SerializationKeys.listennotesUrl] = value }
    if let value = pubDateMs { dictionary[SerializationKeys.pubDateMs] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.audio = aDecoder.decodeObject(forKey: SerializationKeys.audio) as? String
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.audioLengthSec = aDecoder.decodeObject(forKey: SerializationKeys.audioLengthSec) as? Int
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.listennotesUrl = aDecoder.decodeObject(forKey: SerializationKeys.listennotesUrl) as? String
    self.pubDateMs = aDecoder.decodeObject(forKey: SerializationKeys.pubDateMs) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(audio, forKey: SerializationKeys.audio)
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(audioLengthSec, forKey: SerializationKeys.audioLengthSec)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(listennotesUrl, forKey: SerializationKeys.listennotesUrl)
    aCoder.encode(pubDateMs, forKey: SerializationKeys.pubDateMs)
  }

}
