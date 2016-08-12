//
//  NSRange+MessageParsing.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 8/11/16.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

extension NSRange {
    func rangeForString(str: String) -> Range<String.Index>? {
        guard location != NSNotFound else { return nil }
        return str.startIndex.advancedBy(location) ..< str.startIndex.advancedBy(location + length)
    }
    
    func rangeForString(str: String, omitStartEnd:String) -> Range<String.Index>? {
        guard location != NSNotFound else { return nil }
        return str.startIndex.advancedBy(location+omitStartEnd.characters.count) ..< str.startIndex.advancedBy(location + length - omitStartEnd.characters.count)
    }
}