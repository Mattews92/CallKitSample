//
//  CallKitDelegate.swift
//  CallKitSample
//
//  Created by Mathews on 06/07/18.
//  Copyright © 2018 mathews. All rights reserved.
//

import Foundation
import UIKit
import CallKit

class CallKitDelegate: NSObject {
    
    static let sharedInstance = CallKitDelegate()
    
    fileprivate var uuid: UUID?
    fileprivate var provider: CXProvider?
    
    func reportIncomingCall(completionHandler: @escaping ()->Void) {
        let config = CXProviderConfiguration(localizedName: "CallKitSample")
        config.iconTemplateImageData = UIImage(named: "telephone")!.pngData()
        config.ringtoneSound = "incoming.wav"

        if #available(iOS 11.0, *) {
            config.includesCallsInRecents = false
        }
        config.supportsVideo = true
        self.provider = CXProvider(configuration: config)
        self.provider?.setDelegate(self, queue: nil)
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: "Zehra")
        update.hasVideo = true
        self.uuid = UUID()
        self.provider?.reportNewIncomingCall(with: self.uuid!, update: update) { (error) in
            if error != nil {
                print(error)
            }
            else {
                print("call reported")
            }
            completionHandler()
        }
    }
    
    @objc func endCall() {
        let endCallAction = CXEndCallAction(call: self.uuid!)
        let transaction = CXTransaction(action: endCallAction)
        CXCallController().request(transaction) { (error) in
            if let error = error {
                print("EndCallAction transaction request failed: \(error.localizedDescription).")
                self.provider?.reportCall(with: self.uuid!, endedAt: Date(), reason: .remoteEnded)
                return
            }
            
            print("EndCallAction transaction request successful")
        }
    }
    
}

extension CallKitDelegate: CXProviderDelegate {
    @available(iOS 10.0, *)
    func providerDidReset(_ provider: CXProvider) {
    }
    
    @available(iOS 10.0, *)
    func providerDidBegin(_ provider: CXProvider) {
    }
    
    @available(iOS 10.0, *)
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
    }
    
    @available(iOS 10.0, *)
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }
    
    @available(iOS 10.0, *)
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
    }
    
    @available(iOS 10.0, *)
    func provider(_ provider: CXProvider, timedOutPerforming action: CXAction) {
    }
}
