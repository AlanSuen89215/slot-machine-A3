//
//  MAPD724 W2023
//  Group 9
//  Assignment 3
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  SlotMachineSetting.swift
//  Date: Feb 17, 2023
//  Version: 3.0
//

import Foundation

// Manage the slot machine settings saved in the user defaults
class SlotMachineSetting {
    static let sharedSlotMachineSetting: SlotMachineSetting = SlotMachineSetting()
    
    private static let highestPayoutRecordIdKey = "highestPayoutRecordId"
    
    private var highestPayoutRecordId: String?
    
    // load slot machine settings from the user defaults
    init() {
        highestPayoutRecordId = UserDefaults.standard.string(forKey: SlotMachineSetting.highestPayoutRecordIdKey)
    }
    
    func getHighestPayoutRecordId() -> String? {
        return highestPayoutRecordId
    }
    
    // save the value and also save to the user defaults
    func setHighestPayoutRecordId(highestPayoutRecordId: String) {
        self.highestPayoutRecordId = highestPayoutRecordId
        UserDefaults.standard.set(self.highestPayoutRecordId, forKey: SlotMachineSetting.highestPayoutRecordIdKey)
        UserDefaults.standard.synchronize()
    }
}
