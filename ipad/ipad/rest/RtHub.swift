/**
* Copyright (c) 2014, Aintshy.com
* All rights reserved.
*
* Redistribution and use in source or binary forms, with or without
* modification, are NOT permitted.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
* NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
* THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
* INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
* STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
* ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
* OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit

class RtHub : Hub {

    var token : String!;
    
    convenience init() {
        self.init(tkn : "5FRMGL0U-9DF7CA16-AD4IOLA2-0K7IERBR-910HU7HA-79NGKP9E-8O94QIQH-B5712TO8-APEM6E97-A94J04IE-9L81Q393-4OEG80H7-E1IF8===");
    }

    init(tkn : String!) {
        self.token = tkn;
    }
    
    func next(callback : ((Talk) -> Void)!) {
        let url = NSURL(string: "http://i.aintshy.com/58");
        let request = NSMutableURLRequest()
        request.HTTPMethod = "GET"
        request.URL = url
        request.setValue("iOS app", forHTTPHeaderField: "User-Agent")
        request.setValue("application/xml", forHTTPHeaderField: "Accept")
        request.setValue("Rexsl-Auth=\(self.token)", forHTTPHeaderField: "Cookie")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            println("loaded \(data.length) bytes of \(response.MIMEType)")
            let doc = CXMLDocument(data: NSData(data: data), options: 0, error: nil)
            let messages : [Message] = [Message(text: "How are you", mine: true, date: "today")]
            let talk = Talk(number: 1, human: self.human(doc), messages: messages)
            callback(talk)
        }
        task.resume();
    }
    
    func ask(question : String!, callback : (() -> Void)!) {
        let url = NSURL(string: "http://i.aintshy.com");
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) in
            callback()
        }
        task.resume();
    }

    // Fetch Human from XML
    func human(doc : CXMLDocument) -> Human {
        let role = doc.nodeForXPath("/page/role", error: nil)
        return Human(
            name: role.nodeForXPath("name/text()", error: nil).stringValue(),
            age: role.nodeForXPath("age/text()", error: nil).stringValue().toInt()!,
            sex: role.nodeForXPath("sex/text()", error: nil).stringValue(),
            photo: role.nodeForXPath("links/link[@rel='photo']/@href", error: nil).stringValue()
        )
    }
    
}

