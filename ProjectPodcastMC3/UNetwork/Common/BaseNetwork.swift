//
//  BaseNetwork.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 06/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

// Base for request data
protocol BaseRequest {
}

// Base for response data
public protocol BaseResponse : class {
    func displayError(message: String)
}
