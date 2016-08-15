# HIPChatMessages
Loosely based on [GitHub's Swift Style Guide](https://github.com/github/swift-style-guide).
## HIPChatMessagesTests

Run the unit tests for results verification


# Implementation Details

### DetectorProtocol
Defines the protocol for parsing the messages 
#### Detector
Implements the DetectorProtocol and uses the Regex expression for finding the string
#### LinkDetector
Implements the DetectorProtocol and uses the iOS buil-in feature to identify the links
##### LinkInfoBuilder
Fetches the link and outputs the <title> tag
### DetectorFactory
Encapsulates the creation of Detectors. 
### MessageParser
Parses the messages


# Usage

```swift
let mentionDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Mentions)
        let emoticonDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Emoticons)
        let linkDetector = DetectorFactory.sharedInstance.createDetector(DetectorType.Links)
        
        var parser = MessageParser(detectors: [mentionDetector, emoticonDetector, linkDetector])
        let messageStringTokens = parser.parseMessages(messages)
        print(messageStringTokens)
```
