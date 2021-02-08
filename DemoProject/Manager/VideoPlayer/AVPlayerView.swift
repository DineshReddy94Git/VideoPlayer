//
//  AVPlayerView.swift
//  DemoProject
//
//  Created by K12 Services on 04/01/21.
//

import UIKit
import AVFoundation

class AVPlayerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
