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
    var detectedStrings: [String]?
    init(name:String, regexQuery:String) {
        self.regexQuery = regexQuery
        self.name = name
    }
    
    mutating func detectString(message: String) -> [String]? {
        let detector = try! NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let matches = detector.matchesInString(message, options: [], range: NSRange(location: 0, length: message.utf16.count))
        var linksObtained = [String]()
        for match in matches {
            let url = message.substringWithRange(match.range.rangeForString(message)!)
            linksObtained.append(url)
            print("Link title:" + getLinkTitle(url))
        }
        return linksObtained
    }
}

extension LinkDetector {
    func getLinkTitle(stringURL:String) -> String {
        let url = NSURL(string: stringURL)
        do {
            let htmlSource = try String(contentsOfURL: url!)
            var titleTagDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.TitleTag)
            return titleTagDetector.detectString(htmlSource)!.first!
        }
        catch {
            return ""
        }
    }
}