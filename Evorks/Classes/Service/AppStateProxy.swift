//
//  AppStateProxy.swift
//  Evorks
//
//  Created by Anton Samonin on 1/31/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import RxCocoa

class AppStateProxy {
    struct PushNotificationsProxy {
        static var notifyAboutPushTokenHasArrived: (() -> Void)?
        static let notifyAboutPushMessageArrived = PublishRelay<[AnyHashable : Any]>()
    }
    
    struct ApplicationProxy {
        static let didBecomeActive = PublishRelay<Void>()
    }
}

