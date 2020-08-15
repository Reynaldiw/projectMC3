//
//  DAOVideo.swift
//  ProjectPodcastMC3
//
//  Created by Ganang Arief Pratama on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOVideo: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let video = "video"
    static let image = "image"
    static let timestamp = "timestamp"
  }

  // MARK: Properties
  public var name: String?
  public var video: String?
  public var image: String?
  public var timestamp: String?

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
    name = json[SerializationKeys.name].string
    video = json[SerializationKeys.video].string
    image = json[SerializationKeys.image].string
    timestamp = json[SerializationKeys.timestamp].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = video { dictionary[SerializationKeys.video] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = timestamp { dictionary[SerializationKeys.timestamp] = value }

    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.video = aDecoder.decodeObject(forKey: SerializationKeys.video) as? String
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.timestamp = aDecoder.decodeObject(forKey: SerializationKeys.timestamp) as? String
    
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(video, forKey: SerializationKeys.video)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(timestamp, forKey: SerializationKeys.timestamp)
  }

}
