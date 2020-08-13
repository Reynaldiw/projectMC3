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
    var additionalAudio: URL?
}

struct TimeModel {
    var hours: Int?
    var minutes: Int?
    var seconds: Int?
}
