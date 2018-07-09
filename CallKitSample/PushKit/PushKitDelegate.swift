//
//  PushKitDelegate.swift
//  CallKitSample
//
//  Created by Mathews on 06/07/18.
//  Copyright © 2018 mathews. All rights reserved.
//

import Foundation
import UIKit
import PushKit
import UserNotifications
import CallKit

class PushKitDelegate: NSObject {
    
    static let sharedInstance = PushKitDelegate()
    
    func registerPushKit() {
        if #available(iOS 8.0, *) {
            let voipRegistry: PKPushRegistry = PKPushRegistry(queue: DispatchQueue.main)
            voipRegistry.delegate = self
            voipRegistry.desiredPushTypes = [PKPushType.voIP]
        }
    }
}

extension PushKitDelegate: PKPushRegistryDelegate {
    
    @available(iOS 8.0, *)
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
//        print(pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined())
        print(pushCredentials.token.reduce("", {$0 + String(format: "%02X", $1)}))
    }
    
    @available(iOS, introduced: 8.0, deprecated: 11.0)
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.isCallOngoing = true
        CallKitDelegate.sharedInstance.reportIncomingCall {
        }
    }
    
    @available(iOS 11.0, *)
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {

        print(payload.dictionaryPayload)
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.isCallOngoing = true
        CallKitDelegate.sharedInstance.reportIncomingCall {
            completion()
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        print("Invalidated for type: \(type)")
    }
}
