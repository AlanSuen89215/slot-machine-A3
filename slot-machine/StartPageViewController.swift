//
//  MAPD724 W2023
//  Group 9
//  Assignment 3
//  App description: slot-machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  StartPageViewController.swift
//  Date: Jan 18, 2023
//  Version: 3.0
//

import UIKit

class StartPageViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var BtnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a gradient layer for the background
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame = view.bounds
                gradientLayer.colors = [#colorLiteral(red: 0.2213869393, green: 0.2213869393, blue: 0.2213869393, alpha: 1).cgColor, #colorLiteral(red: 0.05490195006, green: 0.05490195006, blue: 0.05490195006, alpha: 1).cgColor]
                gradientLayer.shouldRasterize = true
                backgroundView.layer.addSublayer(gradientLayer)
        
        //style of button
        BtnStart.layer.cornerRadius = 10
        BtnStart.layer.borderWidth = 2
        BtnStart.layer.borderColor = #colorLiteral(red: 0.8932096362, green: 0.6982428432, blue: 0.3265957236, alpha: 1).cgColor
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
