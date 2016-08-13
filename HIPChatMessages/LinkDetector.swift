
//
//  LinkDetector.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 8/11/16.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

struct LinkDetector:DetectorProtocol {
    let regexQuery: String
    let name: String
    init(name:String, regexQuery:String) {
        self.regexQuery = regexQuery
        self.name = name
    }
    
    mutating func detectString(message: String) -> [AnyObject]? {
        let detector = try! NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let matches = detector.matchesInString(message, options: [], range: NSRange(location: 0, length: message.utf16.count))
        var linksObtained = [AnyObject]()
        for match in matches {
            let url = message.substringWithRange(match.range.rangeForString(message)!)
            linksObtained.append(LinkInfoBuilder.getLinkTitle(url) as AnyObject)
        }
        if linksObtained.count > 0 {
            return linksObtained
        }
        else {
            return nil
        }
    }
}
