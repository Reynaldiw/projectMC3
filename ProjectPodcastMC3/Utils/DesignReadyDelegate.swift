//
//  DesignReadyDelegate.swift
//  ProjectPodcastMC3
//
//  Created by Mohamad Naufal Nafian on 12/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import UIKit

protocol designReadyDelegate: class {
    func didDesignReady(isReady: Bool)
    func imageReady(image: UIImage)
    func isDesignPotrait(potrait: Bool)
    func imageForSend(image: UIImage)
    func waveformColor(color: UIColor)
    func waveformPosition(position: String)
    func didAudioReady(isReady: Bool)
    func audioReady(model: [SegmentModel])
}
