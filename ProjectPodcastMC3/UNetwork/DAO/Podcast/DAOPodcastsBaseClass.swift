//
//  DAOPodcastBaseClass.swift
//
//  Created by Reynaldi Wijaya on 06/08/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOPodcastsBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let total = "total"
    static let took = "took"
    static let nextOffset = "next_offset"
    static let results = "results"
    static let count = "count"
  }

  // MARK: Properties
  public var total: Int?
  public var took: Float?
  public var nextOffset: Int?
  public var results: [DAOPodcastResults]?
  public var count: Int?

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
    total = json[SerializationKeys.total].int
    took = json[SerializationKeys.took].float
    nextOffset = json[SerializationKeys.nextOffset].int
    if let items = json[SerializationKeys.results].array { results = items.map { DAOPodcastResults(json: $0) } }
    count = json[SerializationKeys.count].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = total { dictionary[SerializationKeys.total] = value }
    if let value = took { dictionary[SerializationKeys.took] = value }
    if let value = nextOffset { dictionary[SerializationKeys.nextOffset] = value }
    if let value = results { dictionary[SerializationKeys.results] = value.map { $0.dictionaryRepresentation() } }
    if let value = count { dictionary[SerializationKeys.count] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.total = aDecoder.decodeObject(forKey: SerializationKeys.total) as? Int
    self.took = aDecoder.decodeObject(forKey: SerializationKeys.took) as? Float
    self.nextOffset = aDecoder.decodeObject(forKey: SerializationKeys.nextOffset) as? Int
    self.results = aDecoder.decodeObject(forKey: SerializationKeys.results) as? [DAOPodcastResults]
    self.count = aDecoder.decodeObject(forKey: SerializationKeys.count) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(total, forKey: SerializationKeys.total)
    aCoder.encode(took, forKey: SerializationKeys.took)
    aCoder.encode(nextOffset, forKey: SerializationKeys.nextOffset)
    aCoder.encode(results, forKey: SerializationKeys.results)
    aCoder.encode(count, forKey: SerializationKeys.count)
  }

}
