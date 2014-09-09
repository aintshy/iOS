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

protocol Hub : class {
    func next(callback : ((Talk) -> Void)!);
    func ask(question : String!, callback : (() -> Void)!);
    func answer(talk : Int!, text : String!, callback : (() -> Void)!);
}

struct Talk {
    var number : Int
    var human : Human
    var messages : [Message]
}

struct Human {
    var name : String
    var age : Int
    var sex : String
    var photo : NSData
}

struct Message {
    var text : String
    var mine : Bool
    var date : String
}

