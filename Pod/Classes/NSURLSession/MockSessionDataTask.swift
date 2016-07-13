//
//  MockSessionDataTask.swift
//  Pods
//
//  Created by Sam Dean on 19/01/2016.
//
//

import Foundation

private var globalTaskIdentifier: Int = 100000 // Some number bigger than the session would naturally create

/**
Internal implementation of `NSURLSessionDataTask` with read-write properties.

And, curiously, added the properties that `NSURLSessionDataTask` says it has but doesn't actually have. Not sure what's going on there.
*/
class MockSessionDataTask : NSURLSessionDataTask {
    
    let onResume: (task: MockSessionDataTask)->()
    
    init(onResume: (task: MockSessionDataTask)->()) {
        self.onResume = onResume
        _countOfBytesReceivedPrivate = 0;
        _countOfBytesSentPrivate = 0;
        _countOfBytesExpectedToSendPrivate = 0;
        _countOfBytesExpectedToReceivePrivate = 0;
    }
    
    var _taskIdentifier: Int = {
        globalTaskIdentifier += 1
        return globalTaskIdentifier
    }()
    override var taskIdentifier: Int {
        return _taskIdentifier
    }
    
    var _originalRequest: NSURLRequest?
    override var originalRequest: NSURLRequest? {
        return _originalRequest
    }
    
    var _currentRequest: NSURLRequest?
    override var currentRequest: NSURLRequest? {
        return _currentRequest
    }
    
    var _state: NSURLSessionTaskState = .Suspended
    override var state: NSURLSessionTaskState {
        return _state
    }
    
    var _countOfBytesReceivedPrivate: Int64
    override var countOfBytesReceived: Int64 {
        return _countOfBytesReceivedPrivate
    }

    var _countOfBytesSentPrivate: Int64
    override var countOfBytesSent: Int64 {
        return _countOfBytesSentPrivate
    }

    var _countOfBytesExpectedToSendPrivate: Int64
    override var countOfBytesExpectedToSend: Int64 {
        return _countOfBytesExpectedToSendPrivate
    }

    var _countOfBytesExpectedToReceivePrivate: Int64
    override var countOfBytesExpectedToReceive: Int64 {
        return _countOfBytesExpectedToReceivePrivate
    }
    
    override func resume() {
        self.onResume(task: self)
    }
    
    private var _taskDescription: String?
    override var taskDescription: String? {
        get { return _taskDescription }
        set { _taskDescription = newValue }
    }
    
    private var _response: NSURLResponse?
    override var response: NSURLResponse? {
        get { return _response }
        set { _response = newValue }
    }
    
    override func cancel() {
        self._state = .Canceling
    }
}
