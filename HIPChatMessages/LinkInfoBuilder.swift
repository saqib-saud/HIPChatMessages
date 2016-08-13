//
//  LinkInfoBuilder.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 8/13/16.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

struct LinkInfoBuilder {
    static func getLinkTitle(stringURL:String) -> [String: String] {
        let url = NSURL(string: stringURL)
        do {
            let htmlSource = try String(contentsOfURL: url!)
            var titleTagDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.TitleTag)
//            return ["url":stringURL, "title":titleTagDetector.detectString(htmlSource)!.first!]
            return ["url":stringURL, "title":""]
        }
        catch {
            return ["url":stringURL, "title":""]
        }
    }
}