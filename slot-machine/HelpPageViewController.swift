//
//  MAPD724 W2023
//  Group 9
//  Assignment 2
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  HelpPageViewController.swift
//  Date: Feb 16, 2023
//  Version: 3.0
//

import UIKit

class HelpPageViewController: UIViewController {

    @IBOutlet weak var userInstructionsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let userInstructionsFile: URL! = Bundle.main.url(forResource: "user_instructions", withExtension: "txt")
            let userInstructions = try String(contentsOf: userInstructionsFile)
            userInstructionsTextView.text = userInstructions
        }
        catch {
            print("Fail to load help docs!")
        }
    }
}
