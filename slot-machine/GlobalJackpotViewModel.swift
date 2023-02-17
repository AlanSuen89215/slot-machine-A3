//
//  MAPD724 W2023
//  Group 9
//  Assignment 3
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  GlobalJackpotViewModel.swift
//  Date: Feb 16, 2023
//  Version: 3.0
//

import Foundation
import FirebaseFirestore

// delegate to handle events from GlobalJackpotViewModel
protocol GlobalJackpotViewModelDelegate: AnyObject {
    // deliver the update of the global jackpot
    func onGlobalJackpotUpdate(jackpot: Jackpot)
}

// View model for accessing global jackpot
class GlobalJackpotViewModel {
    private let delegate: GlobalJackpotViewModelDelegate
    private let firestore: Firestore
    private static let collectionName = "GlobalJackpot"
    private static let documentName = "Jackpot"
    private static let fieldAmount = "amount"
    
    public init(delegate: GlobalJackpotViewModelDelegate) {
        self.delegate = delegate
        firestore = Firestore.firestore()
    }
    
    // start listening to the updates of the amount of the global jackpot
    public func startListeningToGlobalJackpot() {
        firestore
            .collection(GlobalJackpotViewModel.collectionName)
            .document(GlobalJackpotViewModel.documentName)
            .addSnapshotListener { [unowned self] (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Fail to get jackpot from firestore")
                    return
                }
                
                let data = snapshot.data()!
                let jackpot = Jackpot(amount: data[GlobalJackpotViewModel.fieldAmount] as? Int ?? 0)
                delegate.onGlobalJackpotUpdate(jackpot: jackpot)
            }
    }
    
    // update the amount of the global jackpot to the firestore
    public func updateGlobalJackpot(jackpot: Jackpot) {
        var data = [String : Any]()
        data[GlobalJackpotViewModel.fieldAmount] = jackpot.amount
        
        firestore
            .collection(GlobalJackpotViewModel.collectionName)
            .document(GlobalJackpotViewModel.documentName)
            .setData(data)
    }
}
