//
//  LinkInfoBuilder.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 8/13/16.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

struct LinkInfoBuilder {
    /**
     Obtains the title of the URL
     
     - parameter stringURL: string URL
     
     - returns: Title of the link (i.e. first <title> tag)
     */
    static func getLinkTitle(stringURL:String) -> [String: String] {
        let url = NSURL(string: stringURL)
        do {
            //We are doing blocking operation, ideally it should be asynchoronus operation
            let htmlSource = try String(contentsOfURL: url!)
            var titleTagDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.TitleTag)
            if let title = titleTagDetector.detectString(htmlSource)!.first as? String{
                return ["url":stringURL, "title":title]
            } else {
                return ["url":stringURL, "title":""]
            }
        } catch {
            return ["url":stringURL, "title":""]
        }
    }
}
