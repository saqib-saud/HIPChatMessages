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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
      
    func testMessages() {
        let messages = ["@chris you around? @saqib ","Good morning! (megusta) (coffee)",
                        "Olympics are starting soon;http://www.nbcolympics.com",
                        "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"]
        
        var parser = MessageParser()
        let messageStringTokens = parser.parseMessages(messages)
        let parsedJson = messageStringTokens.parseJSONString as! [String:AnyObject]?
        XCTAssertNotNil(parsedJson!, "Invalid JSON; Unable to parse")

    }
    
}
