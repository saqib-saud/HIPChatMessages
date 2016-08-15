//
//  HIPChatMessagesTests.swift
//  HIPChatMessagesTests
//
//  Created by Saqib Saud on 11/08/2016.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import XCTest
@testable import HIPChatMessages

class HIPChatMessagesTests: XCTestCase {
    func testMessages() {
        let messages = ["@chris you around? @saqib ","Good morning! (megusta) (coffee)",
                        "Olympics are starting soon;http://www.nbcolympics.com",
                        "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"]
        
        var mentionDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Mentions)
        var emoticonDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Emoticons)
        var linkDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Links)
        
        var parser = MessageParser(detectors: [mentionDetector, emoticonDetector, linkDetector])
        let messageStringTokens = parser.parseMessages(messages)
        print(messageStringTokens)
        guard let parsedJson = (messageStringTokens.parseJSONString as? [String:AnyObject]) else {
            XCTFail("Parsing failed")
            return
        }
        guard let emoticons = parsedJson["Emoticons"] as? [String] else {
            XCTFail("failed to get Emoticons")
            return
        }
        XCTAssertEqual(emoticons.count, 3, "Must have 3 emoticons")
        XCTAssertNotNil(emoticons.contains("megusta"), "Failed to identify \"megusta\" from input String")
        XCTAssertNotNil(emoticons.contains("coffee"), "Failed to identify \"coffee\" from input String")
        XCTAssertNotNil(emoticons.contains("success"), "Failed to identify \"success\" from input String")
        
        guard let mentions = (parsedJson["Mentions"] as? [String]) else {
            XCTFail("failed to get Mentions")
            return
        }
        XCTAssertEqual(mentions.count, 4, "Must have 3 emoticons")
        XCTAssertNotNil(mentions.contains("saqib"), "Failed to identify \"saqib\" from input String")
        XCTAssertNotNil(mentions.contains("Good"), "Failed to identify \"Good\" from input String")
        XCTAssertNotNil(mentions.contains("Olympics"), "Failed to identify \"Olympics\" from input String")
        XCTAssertNotNil(mentions.contains("john"), "Failed to identify \"john\" from input String")
        
        guard let links = (parsedJson["Links"] as? [[String : AnyObject]]) else {
            XCTFail("failed to get Links")
            return
        }
        print(links[0]["url"])
        XCTAssertEqual(links.count, 2, "Must have 3 emoticons")
        XCTAssertNotNil(links[0]["url"]!, "Failed to identify link")
        XCTAssertNotNil(links[1]["url"]!, "Failed to identify link")
    }
    
}
