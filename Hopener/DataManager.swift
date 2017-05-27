//
//  DataManager.swift
//  Hopener
//
//  Created by Damian Nowakowski on 17/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import Foundation
import Locksmith

class DataManager {
    
    static let shared = DataManager()

    private let passwordKey = "keychainPasswordeKey"
    private let userAccount = "HopenerAccount"
    private let firstRunKey = "firstAppRunKey"
    
    func saveUuid(_ uuid: String) {
        try! Locksmith.saveData(data: [passwordKey:uuid], forUserAccount: userAccount)
    }
    
    func getUuid() -> String? {
        if let dictionary = Locksmith.loadDataForUserAccount(userAccount: userAccount),
            let uuid = dictionary[passwordKey] {
            return uuid as? String
        }
        return nil
    }
    
    func removeUuid() {
        try! Locksmith.deleteDataForUserAccount(userAccount: userAccount)
    }
    
    func isFirstAppRun() -> Bool {
        let defaults = UserDefaults.standard
        guard let _ = defaults.object(forKey: firstRunKey) else {
            defaults.set(true, forKey: firstRunKey)
            return true
        }
        return false
    }
    
}
