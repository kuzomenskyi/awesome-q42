//
//  ScreenEventsObserver.swift
//  Just business
//
//  Created by vladimir.kuzomenskyi on 5/23/20.
//  Copyright © 2020 vladimir.kuzomenskyi. All rights reserved.
//

import UIKit

class ScreenEventsObserver {
    // MARK: Constant
    
    // MARK: Variable
    private var notificationCenter = NotificationCenter.default
    
    // MARK: Init
    
    // MARK: Function
    
    // MARK: - Deinit
    deinit {
        notificationCenter.removeObserver(self)
    }
}

// MARK: - IScreenEventsObserver
extension ScreenEventsObserver: IScreenEventsObserver {
    func observeForScreenTransition(handler: @escaping (() -> Void)) {
        // swiftlint:disable:next discarded_notification_center_observer
        notificationCenter.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main, using: { _ in
            handler()
        })
    }
    
    func observeForWillEnterForeground(handler: @escaping (() -> Void)) {
        // swiftlint:disable:next discarded_notification_center_observer
        notificationCenter.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main, using: { _ in
            handler()
        })
    }
    
    func observerForDidEnterBackground(handler: @escaping (() -> Void)) {
        // swiftlint:disable:next discarded_notification_center_observer
        notificationCenter.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main, using: { _ in
            handler()
        })
    }
    
    func observeForWillTerminate(handler: @escaping (() -> Void)) {
        // swiftlint:disable:next discarded_notification_center_observer
        notificationCenter.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main, using: { _ in
            handler()
        })
    }
}
