//
//  MAPD724 W2023
//  Group 9
//  Assignment 3
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  GameViewController.swift
//  Date: Feb 16, 2023
//  Version: 3.0
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var moneyAmountLabel: UILabel!
    @IBOutlet weak var jackpotLabel: UILabel!
    @IBOutlet weak var jackpotWinMsgLabel: UILabel!
    @IBOutlet weak var highestPayoutLabel: UILabel!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    @IBOutlet weak var BtnMinus: UIButton!
    @IBOutlet weak var BtnPlus: UIButton!
    @IBOutlet weak var BtnSpin: UIButton!
    
    private var sceneNode: GameScene?
    private static let initialMoney = 10000
    private static let initialBet = 1000
    private static let initialSymbol = "1"
    private var money: Int = initialMoney
    private var bet: Int = initialBet
    private var jackpot: Int = 0
    private var highestPayout: Int = 0
    private var numOfSymbolsInReels: [String : Int] = [:]
    
    private var globalJackpotViewModel: GlobalJackpotViewModel? = nil
    private var highestPayoutViewModel: HighestPayoutViewModel? = nil
    
    private var slotMachineSetting: SlotMachineSetting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slotMachineSetting = SlotMachineSetting.sharedSlotMachineSetting
        
        //color
        let yellow = UIColor(red: 255/255, green: 212/255, blue: 96/255, alpha: 1.0)

        //style of Label
        moneyLabel.layer.masksToBounds = true
        moneyLabel.layer.cornerRadius = 10
        moneyLabel.layer.borderWidth = 4
        moneyLabel.layer.borderColor = yellow.cgColor
        moneyAmountLabel.text = toThousandSeparateString(num: GameViewController.initialMoney)
        
        betLabel.layer.masksToBounds = true
        betLabel.layer.cornerRadius = 10
        betLabel.layer.borderWidth = 4
        betLabel.layer.borderColor = yellow.cgColor
        betLabel.text = toThousandSeparateString(num: GameViewController.initialBet)
        
        //style of button
        BtnMinus.layer.masksToBounds = true
        BtnMinus.layer.cornerRadius = 20
        BtnPlus.layer.cornerRadius = 20
        
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                self.sceneNode = sceneNode
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
        // Get the global jackpot amount from the firestore
        globalJackpotViewModel = GlobalJackpotViewModel(delegate: self)
        globalJackpotViewModel!.startListeningToGlobalJackpot()
        // Get the highest payout of the user from the firestore
        if (slotMachineSetting.getHighestPayoutRecordId() != nil) {
            highestPayoutViewModel = HighestPayoutViewModel(delegate: self, id: slotMachineSetting.getHighestPayoutRecordId()!)
            highestPayoutViewModel!.startListeningToHighestPayout()
        }
        else { // create the highest payout record in the firestore
            highestPayoutViewModel = HighestPayoutViewModel(delegate: self)
            highestPayoutViewModel!.createHighestPayout()
        }
    }
    
    //Add function - add 50 to current bet per clicking
    @IBAction func AddBet(_ sender: UIButton) {
        bet += 50
        betLabel!.text = toThousandSeparateString(num: bet)
        changeStateOfSpinButton()
    }
    
    //Minus function - minus 50 to current bet per clicking
    @IBAction func MinusBet(_ sender: Any) {
        bet -= 50
        betLabel!.text = toThousandSeparateString(num: bet)
        changeStateOfSpinButton()
    }
    
    //Reset Function
    @IBAction func ResetFunction(_ sender: Any) {
        money = GameViewController.initialMoney
        bet = GameViewController.initialBet
        moneyAmountLabel.text = toThousandSeparateString(num: GameViewController.initialMoney)
        betLabel.text = toThousandSeparateString(num: GameViewController.initialBet)
        BtnSpin.isEnabled = true
        BtnSpin.backgroundColor = UIColor.red
        sceneNode?.reel1?.texture = SKTexture(imageNamed: GameViewController.initialSymbol)
        sceneNode?.reel2?.texture = SKTexture(imageNamed: GameViewController.initialSymbol)
        sceneNode?.reel3?.texture = SKTexture(imageNamed: GameViewController.initialSymbol)
    }
    
    // Handle the event when user click the spin btn
    // - spin the reels of the slot machine
    // - deduct the bet from the user money
    // - add the user's bet to Jackpot
    // - check if the user win the jackpot
    // - add the won jackpot (if any) to the user money and deduct it from jackpot
    // - display a message when user win the jackpot
    // - Update the highest payout of the user
    @IBAction func onSpinBtnTouchUpInside(_ sender: UIButton) {
        resetNumOfSymbolsInReels()
        jackpotWinMsgLabel.isHidden = true
        var symbol = randomGenerateSymbol()
        numOfSymbolsInReels[symbol]! += 1
        sceneNode?.reel1?.texture = SKTexture(imageNamed: symbol)
        symbol = randomGenerateSymbol()
        numOfSymbolsInReels[symbol]! += 1
        sceneNode?.reel2?.texture = SKTexture(imageNamed: symbol)
        symbol = randomGenerateSymbol()
        numOfSymbolsInReels[symbol]! += 1
        sceneNode?.reel3?.texture = SKTexture(imageNamed: symbol)
        deductMoney(amount: bet)
        addJackpot(amount: bet)
        let wonJackpotAmount = calculateWonJackpotAmount()
        if (wonJackpotAmount > 0) {
            deductJackpot(amount: wonJackpotAmount)
            addMoney(amount: wonJackpotAmount)
            jackpotWinMsgLabel.isHidden = false
            updateHighestPayout(currentPayout: wonJackpotAmount)
        }
        changeStateOfSpinButton()
    }
    
    // update the highest payout of the user and save it to the firestore
    private func updateHighestPayout(currentPayout: Int) {
        if (currentPayout <= highestPayout) {
            return
        }
        
        highestPayout = currentPayout
        highestPayoutViewModel!.updateHighestPayout(
            highestPayout: HighestPayout(
                amount: highestPayout
            )
        )
    }
    
    // enable or disable the spin button by checking if the user money is enough for bet
    private func changeStateOfSpinButton() {
        // check if the user has enough money for the bet
        // if the user doesn't has enough money, grey out the spin button to prevent them from playing the game
        if (money < bet) {
            BtnSpin.isEnabled = false
            BtnSpin.backgroundColor = UIColor.gray
        }
        else {
            // if the user has enough money, enable the spin button to let them playing the game
            BtnSpin.isEnabled = true
            BtnSpin.backgroundColor = UIColor.red
        }
    }
    
    // add user money
    private func addMoney(amount: Int) {
        money += amount
        moneyAmountLabel!.text = toThousandSeparateString(num: money)
    }
    
    // deduct user money
    private func deductMoney(amount: Int) {
        money -= amount
        moneyAmountLabel!.text = toThousandSeparateString(num: money)
    }
    
    // add amount to global jackpot
    private func addJackpot(amount: Int) {
        jackpot += amount
        globalJackpotViewModel!.updateGlobalJackpot(jackpot: Jackpot(amount: jackpot))
        jackpotLabel!.text = toThousandSeparateString(num: jackpot)
    }
    
    // deduct amount from global jackpot
    private func deductJackpot(amount: Int) {
        jackpot -= amount
        globalJackpotViewModel!.updateGlobalJackpot(jackpot: Jackpot(amount: jackpot))
        jackpotLabel!.text = toThousandSeparateString(num: jackpot)
    }
    
    // Randomly generate a symbol, return the name of the image resource of that symbol
    private func randomGenerateSymbol() -> String {
        let num = Int.random(in: 1 ... 100)
        if (num <= 26) { // 26% probability
            return "1"
        }
        else if (num <= 42) { // 16% probability
            return "2"
        }
        else if (num <= 57) { // 15% probability
            return "3"
        }
        else if (num <= 71) { // 14% probability
            return "4"
        }
        else if (num <= 83) { // 12% probability
            return "5"
        }
        else if (num <= 91) { // 8% probability
            return "6"
        }
        else if (num <= 95) { // 4% probability
            return "7"
        }
        else if (num <= 98) { // 3% probability
            return "8"
        }
        else { // 2% probability
            return "9"
        }
    }
    
    // calculate the jackpot won by the user
    private func calculateWonJackpotAmount() -> Int {
        if (numOfSymbolsInReels["1"] == 0) {
            var wonJackpotAmount = 0
            if (numOfSymbolsInReels["2"] == 3) {
                wonJackpotAmount = bet * 5
            }
            else if (numOfSymbolsInReels["3"] == 3) {
                wonJackpotAmount = bet * 10
            }
            else if (numOfSymbolsInReels["4"] == 3) {
                wonJackpotAmount = bet * 20
            }
            else if (numOfSymbolsInReels["5"] == 3) {
                wonJackpotAmount = bet * 30
            }
            else if (numOfSymbolsInReels["6"] == 3) {
                wonJackpotAmount = bet * 40
            }
            else if (numOfSymbolsInReels["7"] == 3) {
                wonJackpotAmount = bet * 50
            }
            else if (numOfSymbolsInReels["8"] == 3) {
                wonJackpotAmount = bet * 75
            }
            else if (numOfSymbolsInReels["9"] == 3) {
                wonJackpotAmount = bet * 100
            }
            else if (numOfSymbolsInReels["2"] == 2) {
                wonJackpotAmount = bet * 2
            }
            else if (numOfSymbolsInReels["3"] == 2) {
                wonJackpotAmount = bet * 2
            }
            else if (numOfSymbolsInReels["4"] == 2) {
                wonJackpotAmount = bet * 2
            }
            else if (numOfSymbolsInReels["5"] == 2) {
                wonJackpotAmount = bet * 3
            }
            else if (numOfSymbolsInReels["6"] == 2) {
                wonJackpotAmount = bet * 4
            }
            else if (numOfSymbolsInReels["7"] == 2) {
                wonJackpotAmount = bet * 5
            }
            else if (numOfSymbolsInReels["8"] == 2) {
                wonJackpotAmount = bet * 10
            }
            else if (numOfSymbolsInReels["9"] == 2) {
                wonJackpotAmount = bet * 20
            }
            else if (numOfSymbolsInReels["9"] == 1) {
                wonJackpotAmount = bet * 5
            }
            else {
                wonJackpotAmount = bet * 1
            }
            
            if (wonJackpotAmount > jackpot) {
                return jackpot
            }
            else {
                return wonJackpotAmount
            }
        }
        else {
            return 0
        }
    }
    
    // format a number to string with thousand separator
    private func toThousandSeparateString(num: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: num))
    }
    
    // reset numOfSymbolsInReels
    private func resetNumOfSymbolsInReels() {
        for i in 1...9 {
            numOfSymbolsInReels[String(i)] = 0
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GlobalJackpotViewModelDelegate {
    // deliver the update of the global jackpot
    func onGlobalJackpotUpdate(jackpot: Jackpot) {
        // update the UI of the jackpot of the slot machine
        self.jackpot = jackpot.amount
        jackpotLabel.text = toThousandSeparateString(num: self.jackpot)
    }
}

extension GameViewController: HighestPayoutViewModelDelegate {
    // handle the received document id of the created highest payout record
    func onHighestPayoutCreated(id: String) {
        // save the id of the highest payout record in the user defaults
        slotMachineSetting.setHighestPayoutRecordId(highestPayoutRecordId: id)
        highestPayoutViewModel!.startListeningToHighestPayout()
    }
    
    // handle the update of the highest payout of the user
    func onHighestPayoutUpdate(highestPayout: HighestPayout) {
        // update the UI of the highest payout of the user
        self.highestPayout = highestPayout.amount
        highestPayoutLabel.text = toThousandSeparateString(num: self.highestPayout)
    }
}
