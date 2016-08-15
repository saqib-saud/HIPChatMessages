//
//  String+JSON.swift
//  HIPChatMessages
//
//  Created by Saqib Saud on 15/08/2016.
//  Copyright © 2016 Saqib Saud. All rights reserved.
//

import Foundation

extension String {
    
    var parseJSONString: AnyObject? {
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do {
                return try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
            }
            catch {
                return nil //Needs more exaustive catch
            }
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}
