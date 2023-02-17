//
//  MAPD724 W2023
//  Group 9
//  Assignment 3
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  HighestPayoutViewModel.swift
//  Date: Feb 16, 2023
//  Version: 3.0
//

import Foundation
import FirebaseFirestore

// delegate to handle events from HighestPayoutViewModel
protocol HighestPayoutViewModelDelegate: AnyObject {
    // deliver the update of the highest payout of the user
    func onHighestPayoutUpdate(highestPayout: HighestPayout)
}

// View model for accessing highest payout
class HighestPayoutViewModel {
    private let delegate: HighestPayoutViewModelDelegate
    private let firestore: Firestore
    private static let collectionName = "HighestPayouts"
    private static let fieldUserName = "user_name"
    private static let fieldAmount = "amount"
    private let userName: String
    
    public init(delegate: HighestPayoutViewModelDelegate, userName: String) {
        self.delegate = delegate
        self.userName = userName
        firestore = Firestore.firestore()
    }
    
    // start listening to the update of the highest payout of the user
    public func startListeningToHighestPayout() {
        firestore
            .collection(HighestPayoutViewModel.collectionName)
            .document(userName)
            .addSnapshotListener { [unowned self] (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Fail to get highest payout from firestore")
                    return
                }
                
                let data = snapshot.data()!
                let highestPayout = HighestPayout(
                    userName: data[HighestPayoutViewModel.fieldUserName] as? String ?? "",
                    amount: data[HighestPayoutViewModel.fieldAmount] as? Int ?? 0)
                delegate.onHighestPayoutUpdate(highestPayout: highestPayout)
            }
    }
    
    // update the highest payout of the user to the firestore
    public func updateHighestPayout(highestPayout: HighestPayout) {
        var data = [String : Any]()
        data[HighestPayoutViewModel.fieldUserName] = highestPayout.userName
        data[HighestPayoutViewModel.fieldAmount] = highestPayout.amount
        
        firestore
            .collection(HighestPayoutViewModel.collectionName)
            .document(userName)
            .setData(data)
    }
}
