//
//  DAOEpisodesBaseClass.swift
//
//  Created by Reynaldi Wijaya on 07/08/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOEpisodesBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let publisher = "publisher"
    static let id = "id"
    static let episodes = "episodes"
    static let thumbnail = "thumbnail"
    static let nextEpisodePubDate = "next_episode_pub_date"
    static let title = "title"
    static let listennotesUrl = "listennotes_url"
  }

  // MARK: Properties
  public var publisher: String?
  public var id: String?
  public var episodes: [DAOEpisodes]?
  public var thumbnail: String?
  public var nextEpisodePubDate: Int?
  public var title: String?
  public var listennotesUrl: String?

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
    publisher = json[SerializationKeys.publisher].string
    id = json[SerializationKeys.id].string
    if let items = json[SerializationKeys.episodes].array { episodes = items.map { DAOEpisodes(json: $0) } }
    thumbnail = json[SerializationKeys.thumbnail].string
    nextEpisodePubDate = json[SerializationKeys.nextEpisodePubDate].int
    title = json[SerializationKeys.title].string
    listennotesUrl = json[SerializationKeys.listennotesUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = publisher { dictionary[SerializationKeys.publisher] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = episodes { dictionary[SerializationKeys.episodes] = value.map { $0.dictionaryRepresentation() } }
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
    if let value = nextEpisodePubDate { dictionary[SerializationKeys.nextEpisodePubDate] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = listennotesUrl { dictionary[SerializationKeys.listennotesUrl] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.publisher = aDecoder.decodeObject(forKey: SerializationKeys.publisher) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.episodes = aDecoder.decodeObject(forKey: SerializationKeys.episodes) as? [DAOEpisodes]
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? String
    self.nextEpisodePubDate = aDecoder.decodeObject(forKey: SerializationKeys.nextEpisodePubDate) as? Int
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.listennotesUrl = aDecoder.decodeObject(forKey: SerializationKeys.listennotesUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(publisher, forKey: SerializationKeys.publisher)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(episodes, forKey: SerializationKeys.episodes)
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(nextEpisodePubDate, forKey: SerializationKeys.nextEpisodePubDate)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(listennotesUrl, forKey: SerializationKeys.listennotesUrl)
  }

}
