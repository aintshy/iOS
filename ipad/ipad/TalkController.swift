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

class TalkController: UIViewController {
    
    @IBOutlet var answer : UITextField!
    @IBOutlet var photo : UIImageView!
    @IBOutlet var talker : UILabel!
    
    var talk : Talk?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reload()
    }
    
    private func reload() {
        self.talker.text = "wait a sec..."
        RtHub().next { (talk : Talk) -> Void in
            self.talk = talk
            let dude = talk.human
            let url = NSURL.URLWithString(dude.photo)
            let data = NSData(contentsOfURL : url)
            dispatch_async(dispatch_get_main_queue()) {
                self.photo.image = UIImage(data : data)
                self.talker.text = "\(dude.name) \(dude.sex) \(dude.age)"
            }
        }
    }
    
}

