//
//  ReminderAlertView.swift
//  ReminderAlertView
//
//  Created by Kenta Hara on 2017/12/17.
//  Copyright © 2017 Kenta Hara. All rights reserved.
//

import Foundation
import UIKit

public struct ReminderAlertView {
    
    private static var alertInstancesDic = [String: ReminderAlertView]()
    
    private static var bundleId: String {
        
        return "harakenta.ReminderAlertView."
    }
    
    private static var udCountKeyBase: String {
        
        return bundleId + "udCountKeyBase."
    }
    
    private static var udDisplayedNumKeyBase: String {
        
        return bundleId + "udDisplayedNumKeyBase."
    }
    
    private static var udHasBeenPushedOKButtonKeyBase: String {
        
        return bundleId + "udHasBeenPushedOKButtonKeyBase."
    }
    
    private var alertId: String
    private var countToRemind: Int
    private var alertTitle: String
    private var message: String
    private var cancelButtonTitle: String
    private var OKButtonTitle: String
    
    init(alertId: String, countToRemind: Int, alertTitle: String, message: String, cancelButtonTitle: String, OKButtonTitle: String) {
        
        self.alertId = alertId
        self.countToRemind = countToRemind
        self.alertTitle = alertTitle
        self.message = message
        self.cancelButtonTitle = cancelButtonTitle
        self.OKButtonTitle = OKButtonTitle
    }
    
    public static func registerAlert(id: String, countToRemind: Int, alertTitle: String, message: String, cancelButtonTitle: String, OKButtonTitle: String) {
        
        let alert = ReminderAlertView(
            alertId: id,
            countToRemind: countToRemind,
            alertTitle: alertTitle,
            message: message,
            cancelButtonTitle: cancelButtonTitle,
            OKButtonTitle: OKButtonTitle)
        
        alertInstancesDic[id] = alert
    }
    
    public static func showAlert(id: String, pushedOKButtonClosure: (() -> Void)?) {
        
        guard let alert = alertInstancesDic[id] else { fatalError("There is no alert id : \(id)") }
        
        alert.showAlertController(pushedOKButtonClosure: pushedOKButtonClosure)
        
    }
    
    public static func incrementCount(id: String, pushedOKButtonClosure: (() -> Void)? ){
        
        var currentCount = UserDefaults.standard.integer(forKey: udCountKey(alertId: id))
        currentCount += 1
        
        guard let alert = alertInstancesDic[id] else { fatalError("There is no alert id : \(id)") }
        
        if alert.shouldShowAlertController(currentCount: currentCount) {
            alert.showAlertController(pushedOKButtonClosure: pushedOKButtonClosure)
        } else {
            UserDefaults.standard.set(currentCount, forKey: udCountKey(alertId: id))
            UserDefaults.standard.synchronize()
        }
    }
    
    public static func hasBeenDisplayed(id: String) -> Bool {
        
        let udKey = udDisplayedNumKey(alertId: id)
        let hasBeenDisplayed = UserDefaults.standard.bool(forKey: udKey)
        
        return hasBeenDisplayed
    }
    
    public static func hasBeenPushedOKButton(id: String) -> Bool {
        
        let udKey = udHasBeenPushedOKButtonKey(alertId: id)
        let hasBeenPushedOKButton = UserDefaults.standard.bool(forKey: udKey)
        
        return hasBeenPushedOKButton
    }
    
    //MARK: - private methods
    
    private static func udCountKey(alertId: String) -> String {
        
        return udCountKeyBase + alertId
    }
    
    private static func udDisplayedNumKey(alertId: String) -> String {
        
        return udDisplayedNumKeyBase + alertId
    }
    
    private static func udHasBeenPushedOKButtonKey(alertId: String) -> String {
        
        return udHasBeenPushedOKButtonKeyBase + alertId
    }
    
    private func shouldShowAlertController(currentCount: Int) -> Bool {
        
        return currentCount >= countToRemind
    }
    
    private func showAlertController(pushedOKButtonClosure: (() -> Void)?) {
        
        UserDefaults.standard.set(0, forKey: type(of: self).udCountKey(alertId: alertId))
        
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: cancelButtonTitle,
            style: .cancel,
            handler: nil))
        
        alertController.addAction(UIAlertAction(
            title: OKButtonTitle,
            style: .default,
            handler: { (action) -> Void in
                pushedOKButtonClosure?()
                UserDefaults.standard.set(true, forKey: type(of: self).udHasBeenPushedOKButtonKey(alertId: self.alertId))
                UserDefaults.standard.synchronize()
        }))
        
        let currentVC = currentViewController()
        
        currentVC.present(alertController, animated: true, completion: nil)
        
        incrementDisplayedNum()
    }
    
    private func currentViewController() -> UIViewController {
        
        guard var baseView = UIApplication.shared.keyWindow?.rootViewController else { fatalError("There is no rootViewController") }
        
        while baseView.presentedViewController != nil && !baseView.presentedViewController!.isBeingDismissed {
            baseView = baseView.presentedViewController!
        }
        
        return baseView
    }
    
    private func incrementDisplayedNum() {
        
        var currentDisplayedNum = UserDefaults.standard.integer(forKey: type(of: self).udDisplayedNumKey(alertId: alertId))
        currentDisplayedNum += 1
        
        UserDefaults.standard.set(currentDisplayedNum, forKey: type(of: self).udDisplayedNumKey(alertId: alertId))
        UserDefaults.standard.synchronize()
    }
}
