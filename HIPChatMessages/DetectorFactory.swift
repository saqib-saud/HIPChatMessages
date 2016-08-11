//
//  DetectorFactory.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 11/08/2016.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

struct DetectorFactory {
    static let sharedInstance:DetectorFactory = DetectorFactory()
    func createDetector(detectorType:DetectorType) -> DetectorProtocol {
        switch detectorType {
        case .Mentions:
            return Detector(name: "Mentions", regexQuery: "(?<=^|\\s)(@[\\w\\.]+)(?<!\\.)")
            
        case .Emoticons:
            return Detector(name: "Emoticons", regexQuery: "\\([a-zA-Z0-9]{1,15}\\)")
        case .Links:
            return LinkDetector(name: "Links", regexQuery: "")
        }
    }
}
