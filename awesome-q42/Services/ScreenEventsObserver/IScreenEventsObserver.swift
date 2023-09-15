//
//  IScreenEventsObserver.swift
//  Just business
//
//  Created by vladimir.kuzomenskyi on 5/23/20.
//  Copyright © 2020 vladimir.kuzomenskyi. All rights reserved.
//

import Foundation

protocol IScreenEventsObserver: AnyObject {
    func observeForScreenTransition(handler: @escaping (() -> Void))
    func observeForWillEnterForeground(handler: @escaping (() -> Void))
    func observerForDidEnterBackground(handler: @escaping (() -> Void))
    func observeForWillTerminate(handler: @escaping (() -> Void))
}
