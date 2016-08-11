//
//  NSRegularExpression+MessageParsing.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 11/08/2016.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    class func matchesInMessageString(inputString:String, pattern:String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            let matches = regex.matchesInString(inputString, options: [], range: NSRange(location: 0, length: inputString.utf16.count))
            var matchesFound = [String]()
            for match in matches {
                    let range = match.rangeAtIndex(0)
                    let r = inputString.startIndex.advancedBy(range.location) ..<
                        inputString.startIndex.advancedBy(range.location+range.length)
                    matchesFound.append(inputString.substringWithRange(r))
                
            }
            return matchesFound
        } catch {//Exception occured
            return []
        }
    }
}