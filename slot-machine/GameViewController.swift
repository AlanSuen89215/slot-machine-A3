//
//  MAPD724 W2023
//  Group 9
//  Assignment 1
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  StartPafgeViewController.swift
//  Date: Jan 18, 2023
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var moneyAmountLabel: UILabel!
    @IBOutlet weak var jackpotLabel: UILabel!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    @IBOutlet weak var BtnMinus: UIButton!
    @IBOutlet weak var BtnPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //color
        let yellow = UIColor(red: 255/255, green: 212/255, blue: 96/255, alpha: 1.0)

        //style of Label
        moneyLabel.layer.masksToBounds = true
        moneyLabel.layer.cornerRadius = 10
        moneyLabel.layer.borderWidth = 4
        moneyLabel.layer.borderColor = yellow.cgColor
        
        betLabel.layer.masksToBounds = true
        betLabel.layer.cornerRadius = 10
        betLabel.layer.borderWidth = 4
        betLabel.layer.borderColor = yellow.cgColor
        
        //style of button
        BtnMinus.layer.masksToBounds = true
        BtnMinus.layer.cornerRadius = 20
        BtnPlus.layer.cornerRadius = 20
        
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
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
    }
    
    //Add function - add 50 to current bet per clicking
    @IBAction func AddBet(_ sender: UIButton) {
//        let formater = NumberFormatter()
//            formater.groupingSeparator = ","
//            formater.numberStyle = .decimal
        let currentBet = Int(betLabel.text!) ?? 1000
        let newBet = currentBet + 50
        betLabel!.text = String(newBet)
//        betLabel!.text = formater.string(from: newBet as NSNumber)
    }
    
    //Minus function - minus 50 to current bet per clicking
    @IBAction func MinusBet(_ sender: Any) {
        let currentBet = Int(betLabel.text!) ?? 1000
        let newBet = currentBet - 50
        betLabel!.text = String(newBet)
    }
    
    //Reset Function
    @IBAction func ResetFunction(_ sender: Any) {
        moneyAmountLabel.text = "10,000"
        betLabel.text = "1000"
        jackpotLabel.text = "10,000,000"
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
