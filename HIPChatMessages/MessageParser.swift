//
//  MessageParser.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 11/08/2016.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

struct MessageParser {
    var parsedMessage:[String:Array<String>]?
    /**
     Parses array of String
     - parameter messages: Array of Strings
     - returns: JSON formatted String
     */
    mutating func parseMessages(messages: [String]) -> String {
        var mentionDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Mentions)
        var emoticonDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Emoticons)
        var linkDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Links)
        self.parsedMessage = [mentionDetector.name:[],emoticonDetector.name:[], linkDetector.name:[]]
        for message in messages {
            self.parsedMessage![mentionDetector.name]!.appendContentsOf(mentionDetector.detectString(message)!)
            self.parsedMessage![emoticonDetector.name]!.appendContentsOf(emoticonDetector.detectString(message)!)
            self.parsedMessage![linkDetector.name]!.appendContentsOf(linkDetector.detectString(message)!)
        }
        self.generateJSONString()
        return mentionDetector.detectString(messages[0])!.first!
    }
}

extension MessageParser {
    func generateJSONString() -> String {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(parsedMessage!, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString = String(data: jsonData, encoding: NSUTF8StringEncoding)
            print("JSON:\(jsonString!)")
            return jsonString!
            
        } catch _ as NSError {
            return ""
        }
    }
}