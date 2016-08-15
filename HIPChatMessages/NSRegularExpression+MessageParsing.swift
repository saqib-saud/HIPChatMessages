//
//  NSRegularExpression+MessageParsing.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 11/08/2016.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    
    /**
     Performs the Regex operation on String.
     Note: This method specially customized regex query in 3 groups. It will not provide desired results if groups are less.
     match.rangeAtIndex(2) basically picks up the second group (e.g without @) and hence returns us mention without '@' symbol
     - parameter inputString: String to be searched
     - parameter pattern:     Regex in 3 groups ()()()
     
     - returns: regex identified String.
     */
    class func matchesInMessageString(inputString:String, pattern:String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            let matches = regex.matchesInString(inputString, options: [], range: NSRange(location: 0, length: inputString.utf16.count))
            var matchesFound = [String]()
            for match in matches {
                if match.numberOfRanges > 2 {
                    let range = match.rangeAtIndex(2)
                    let r = inputString.startIndex.advancedBy(range.location) ..<
                        inputString.startIndex.advancedBy(range.location+range.length)
                    matchesFound.append(inputString.substringWithRange(r))
                }
            }
            return matchesFound
        } catch {//Ideally It should throw exception and it should be handled gracefully.
            return []
        }
    }
}