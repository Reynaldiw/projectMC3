//
//  DAOPodcastResults.swift
//
//  Created by Reynaldi Wijaya on 06/08/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOPodcastResults: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let rss = "rss"
    static let totalEpisodes = "total_episodes"
    static let publisherHighlighted = "publisher_highlighted"
    static let genreIds = "genre_ids"
    static let thumbnail = "thumbnail"
    static let itunesId = "itunes_id"
    static let publisherOriginal = "publisher_original"
    static let latestPubDateMs = "latest_pub_date_ms"
    static let email = "email"
    static let listennotesUrl = "listennotes_url"
    static let id = "id"
    static let image = "image"
    static let explicitContent = "explicit_content"
    static let earliestPubDateMs = "earliest_pub_date_ms"
    static let titleOriginal = "title_original"
    static let titleHighlighted = "title_highlighted"
    static let descriptionOriginal = "description_original"
    static let descriptionHighlighted = "description_highlighted"
  }

  // MARK: Properties
  public var rss: String?
  public var totalEpisodes: Int?
  public var publisherHighlighted: String?
  public var genreIds: [Int]?
  public var thumbnail: String?
  public var itunesId: Int?
  public var publisherOriginal: String?
  public var latestPubDateMs: Int?
  public var email: String?
  public var listennotesUrl: String?
  public var id: String?
  public var image: String?
  public var explicitContent: Bool? = false
  public var earliestPubDateMs: Int?
  public var titleOriginal: String?
  public var titleHighlighted: String?
  public var descriptionOriginal: String?
  public var descriptionHighlighted: String?

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
    rss = json[SerializationKeys.rss].string
    totalEpisodes = json[SerializationKeys.totalEpisodes].int
    publisherHighlighted = json[SerializationKeys.publisherHighlighted].string
    if let items = json[SerializationKeys.genreIds].array { genreIds = items.map { $0.intValue } }
    thumbnail = json[SerializationKeys.thumbnail].string
    itunesId = json[SerializationKeys.itunesId].int
    publisherOriginal = json[SerializationKeys.publisherOriginal].string
    latestPubDateMs = json[SerializationKeys.latestPubDateMs].int
    email = json[SerializationKeys.email].string
    listennotesUrl = json[SerializationKeys.listennotesUrl].string
    id = json[SerializationKeys.id].string
    image = json[SerializationKeys.image].string
    explicitContent = json[SerializationKeys.explicitContent].boolValue
    earliestPubDateMs = json[SerializationKeys.earliestPubDateMs].int
    titleOriginal = json[SerializationKeys.titleOriginal].string
    titleHighlighted = json[SerializationKeys.titleHighlighted].string
    descriptionOriginal = json[SerializationKeys.descriptionOriginal].string
    descriptionHighlighted = json[SerializationKeys.descriptionHighlighted].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = rss { dictionary[SerializationKeys.rss] = value }
    if let value = totalEpisodes { dictionary[SerializationKeys.totalEpisodes] = value }
    if let value = publisherHighlighted { dictionary[SerializationKeys.publisherHighlighted] = value }
    if let value = genreIds { dictionary[SerializationKeys.genreIds] = value }
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
    if let value = itunesId { dictionary[SerializationKeys.itunesId] = value }
    if let value = publisherOriginal { dictionary[SerializationKeys.publisherOriginal] = value }
    if let value = latestPubDateMs { dictionary[SerializationKeys.latestPubDateMs] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = listennotesUrl { dictionary[SerializationKeys.listennotesUrl] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    dictionary[SerializationKeys.explicitContent] = explicitContent
    if let value = earliestPubDateMs { dictionary[SerializationKeys.earliestPubDateMs] = value }
    if let value = titleOriginal { dictionary[SerializationKeys.titleOriginal] = value }
    if let value = titleHighlighted { dictionary[SerializationKeys.titleHighlighted] = value }
    if let value = descriptionOriginal { dictionary[SerializationKeys.descriptionOriginal] = value }
    if let value = descriptionHighlighted { dictionary[SerializationKeys.descriptionHighlighted] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.rss = aDecoder.decodeObject(forKey: SerializationKeys.rss) as? String
    self.totalEpisodes = aDecoder.decodeObject(forKey: SerializationKeys.totalEpisodes) as? Int
    self.publisherHighlighted = aDecoder.decodeObject(forKey: SerializationKeys.publisherHighlighted) as? String
    self.genreIds = aDecoder.decodeObject(forKey: SerializationKeys.genreIds) as? [Int]
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? String
    self.itunesId = aDecoder.decodeObject(forKey: SerializationKeys.itunesId) as? Int
    self.publisherOriginal = aDecoder.decodeObject(forKey: SerializationKeys.publisherOriginal) as? String
    self.latestPubDateMs = aDecoder.decodeObject(forKey: SerializationKeys.latestPubDateMs) as? Int
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.listennotesUrl = aDecoder.decodeObject(forKey: SerializationKeys.listennotesUrl) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.explicitContent = aDecoder.decodeBool(forKey: SerializationKeys.explicitContent)
    self.earliestPubDateMs = aDecoder.decodeObject(forKey: SerializationKeys.earliestPubDateMs) as? Int
    self.titleOriginal = aDecoder.decodeObject(forKey: SerializationKeys.titleOriginal) as? String
    self.titleHighlighted = aDecoder.decodeObject(forKey: SerializationKeys.titleHighlighted) as? String
    self.descriptionOriginal = aDecoder.decodeObject(forKey: SerializationKeys.descriptionOriginal) as? String
    self.descriptionHighlighted = aDecoder.decodeObject(forKey: SerializationKeys.descriptionHighlighted) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(rss, forKey: SerializationKeys.rss)
    aCoder.encode(totalEpisodes, forKey: SerializationKeys.totalEpisodes)
    aCoder.encode(publisherHighlighted, forKey: SerializationKeys.publisherHighlighted)
    aCoder.encode(genreIds, forKey: SerializationKeys.genreIds)
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(itunesId, forKey: SerializationKeys.itunesId)
    aCoder.encode(publisherOriginal, forKey: SerializationKeys.publisherOriginal)
    aCoder.encode(latestPubDateMs, forKey: SerializationKeys.latestPubDateMs)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(listennotesUrl, forKey: SerializationKeys.listennotesUrl)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(explicitContent, forKey: SerializationKeys.explicitContent)
    aCoder.encode(earliestPubDateMs, forKey: SerializationKeys.earliestPubDateMs)
    aCoder.encode(titleOriginal, forKey: SerializationKeys.titleOriginal)
    aCoder.encode(titleHighlighted, forKey: SerializationKeys.titleHighlighted)
    aCoder.encode(descriptionOriginal, forKey: SerializationKeys.descriptionOriginal)
    aCoder.encode(descriptionHighlighted, forKey: SerializationKeys.descriptionHighlighted)
  }

}
