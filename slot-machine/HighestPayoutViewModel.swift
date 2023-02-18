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
    // deliver the document id of the created highest payout record
    func onHighestPayoutCreated(id: String)
}

// View model for accessing highest payout
class HighestPayoutViewModel {
    private let delegate: HighestPayoutViewModelDelegate
    private let firestore: Firestore
    private static let collectionName = "HighestPayouts"
    private static let fieldAmount = "amount"
    private var id: String = ""
    
    public init(delegate: HighestPayoutViewModelDelegate) {
        self.delegate = delegate
        firestore = Firestore.firestore()
    }
    
    public init(delegate: HighestPayoutViewModelDelegate, id: String) {
        self.delegate = delegate
        self.id = id
        firestore = Firestore.firestore()
    }
    
    // start listening to the update of the highest payout of the user
    public func startListeningToHighestPayout() {
        firestore
            .collection(HighestPayoutViewModel.collectionName)
            .document(id)
            .addSnapshotListener { [unowned self] (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Fail to get highest payout from firestore")
                    return
                }
                
                let data = snapshot.data()!
                let highestPayout = HighestPayout(
                    amount: data[HighestPayoutViewModel.fieldAmount] as? Int ?? 0)
                delegate.onHighestPayoutUpdate(highestPayout: highestPayout)
            }
    }
    
    // update the highest payout of the user to the firestore
    public func updateHighestPayout(highestPayout: HighestPayout) {
        var data = [String : Any]()
        data[HighestPayoutViewModel.fieldAmount] = highestPayout.amount
        
        firestore
            .collection(HighestPayoutViewModel.collectionName)
            .document(id)
            .setData(data)
    }
    
    // create a highest payout record of the user in the firestore
    public func createHighestPayout() {
        var data = [String : Any]()
        data[HighestPayoutViewModel.fieldAmount] = 0
        
        firestore
            .collection(HighestPayoutViewModel.collectionName)
            .addDocument(data: data)
            .addSnapshotListener { [unowned self] (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Fail to create highest payout from firestore")
                    return
                }
                
                id = snapshot.documentID
                delegate.onHighestPayoutCreated(id: id)
            }
    }
}
