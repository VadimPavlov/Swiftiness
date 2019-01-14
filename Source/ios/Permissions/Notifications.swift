//
//  Notifications.swift
//  Swifty
//
//  Created by Vadim Pavlov on 8/17/18.
//  Copyright © 2018 Vadym Pavlov. All rights reserved.
//

import UserNotifications

public extension Permissions {
    @available(iOS 10.0, *)
    final class Notifications {

        let status = Observable<UNAuthorizationStatus?>(nil)
        private let center = UNUserNotificationCenter.current()

        init() {
            center.getNotificationSettings { settings in
                self.status.value = settings.authorizationStatus
            }
        }

        func request(options: UNAuthorizationOptions, completion: RequestCompletion? = nil) {
            center.requestAuthorization(options: options) { granded, error in
                error.map { print($0) }
                DispatchQueue.main.async {
                    self.status.value = granded ? .authorized : .denied
                    completion?()
                }
            }
        }
    }
}
