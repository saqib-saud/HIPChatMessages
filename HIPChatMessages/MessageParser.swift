//
//  MessageParser.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 11/08/2016.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

struct MessageParser {
    var parsedMessage = [String:Array<AnyObject>]()
    let dectectors:Array<DetectorProtocol>
    
    /**
     Initializes the MessageParser with detectors
     
     - parameter detectors: Array of Detectors (conforming to DetectorProtocol)
     
     - returns: <#return value description#>
     */
    init(detectors:Array<DetectorProtocol>){
        self.dectectors = detectors
    }
    /**
     Parses array of String
     - parameter messages: Array of Strings
     - returns: JSON formatted String
     */
    mutating func parseMessages(messages: [String]) -> String {
        for var detector in self.dectectors {
            self.parsedMessage[detector.name] = []
            for message in messages {
                if let detectedMessage = detector.detectString(message){
                    self.parsedMessage[detector.name]!.appendContentsOf(detectedMessage as [AnyObject])
                }

            }
        }
        return self.generateJSONString()
    }
}

extension MessageParser {
    func generateJSONString() -> String {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(parsedMessage, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString = String(data: jsonData, encoding: NSUTF8StringEncoding)
            return jsonString!
            
        } catch _ as NSError {
            return ""
        }
    }
}