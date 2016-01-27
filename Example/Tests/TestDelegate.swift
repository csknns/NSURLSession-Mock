//
//  TestDelegate.swift
//  NSURLSession-Mock
//
//  Created by Sam Dean on 15/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class TestDelegate : NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    var response: NSURLResponse?
    var data: NSMutableData?
    var error: NSError?
    var headers: [String : String]?
    
    let complete: () -> ()
    
    init(complete: () -> ()) {
        self.complete = complete
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.response = response
        
        guard let httpResponse = response as? NSHTTPURLResponse else {
            return
        }
        
        guard let headers = httpResponse.allHeaderFields as? [String : String] else {
            return
        }
        
        self.headers = headers
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        if self.data == nil {
            self.data = NSMutableData()
        }
        self.data!.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.complete()
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        self.error = error
        self.complete()
    }
}
