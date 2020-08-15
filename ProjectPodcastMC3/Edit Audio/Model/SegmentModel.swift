//
//  SegmentModel.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation

struct SegmentModel {
    var nameSegment: String?
    var startTimeSeconds: Int?
    var endTimeSeconds: Int?
    var urlSegment: URL?
    var urlAdditionalAudio: URL?
    var durationAdditionalAudio: Int?
    var typeSegment: TypeOfSegment = .EditAudio
}

enum TypeOfSegment {
    case EditAudio
    case AddtionalAudio
}

struct TimeModel {
    var hours: Int?
    var minutes: Int?
    var seconds: Int?
}
