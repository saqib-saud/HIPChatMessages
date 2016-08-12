//
//  Detector.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 11/08/2016.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

enum DetectorType {
    case Mentions
    case Emoticons
    case Links
    case TitleTag
}
protocol DetectorProtocol {
    var regexQuery: String { get }
    var detectedStrings: [String]? { get }
    var name: String { get }
    mutating func detectString(message: String) -> [String]?
}


struct Detector: DetectorProtocol {
    let regexQuery: String
    let name: String
    var detectedStrings: [String]?
    init(name:String, regexQuery:String) {
        self.regexQuery = regexQuery
        self.name = name
    }
    mutating func detectString(message: String) -> [String]? {
        detectedStrings = NSRegularExpression.matchesInMessageString(message, pattern: regexQuery)
        return detectedStrings
    }
}

