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
    var name: String { get }
    mutating func detectString(message: String) -> [AnyObject]?
}


struct Detector: DetectorProtocol {
    let regexQuery: String
    let name: String
    init(name:String, regexQuery:String) {
        self.regexQuery = regexQuery
        self.name = name
    }
    
    /**
     Performs regex string detection operation
     
     - parameter message: message string
     
     - returns: Regex identified String without tags 
     */
    mutating func detectString(message: String) -> [AnyObject]? {
        return NSRegularExpression.matchesInMessageString(message, pattern: regexQuery)
    }
}

