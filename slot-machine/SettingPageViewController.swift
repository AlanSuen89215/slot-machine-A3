//
//  MAPD724 W2023
//  Group 9
//  Assignment 3
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  SettingPageViewController.swift
//  Date: Feb 16, 2023
//  Version: 3.0
//

import UIKit

class SettingPageViewController: UIViewController {

    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //color
        let yellow = UIColor(red: 250/255, green: 218/255, blue: 94/255, alpha: 1.0)
        let orange = UIColor(red: 240/255, green: 123/255, blue: 63/255, alpha: 1.0)
        
        //grdient color of the popup view background
        let gradientColor = CAGradientLayer()
        gradientColor.frame = popupView.bounds
        gradientColor.colors = [ orange.cgColor,yellow.cgColor,UIColor.red.cgColor]
        gradientColor.cornerRadius = 10
        
        //
        settingLabel.layer.masksToBounds = true
        settingLabel.layer.cornerRadius = 10
        settingLabel.layer.borderWidth = 4
        settingLabel.layer.borderColor = UIColor.red.cgColor
        
        popupView.layer.borderWidth = 4
        popupView.layer.borderColor = orange.cgColor
        popupView.layer.backgroundColor = yellow.cgColor
        popupView.layer.addSublayer(gradientColor)
        
        resetButton.layer.cornerRadius = 10
        resetButton.layer.borderWidth = 4
        resetButton.layer.borderColor = UIColor.white.cgColor
        
        helpButton.layer.cornerRadius = 10
        helpButton.layer.borderWidth = 4
        helpButton.layer.borderColor = UIColor.white.cgColor
        
        quitButton.layer.cornerRadius = 10
        quitButton.layer.borderWidth = 4
        quitButton.layer.borderColor = UIColor.white.cgColor
        
        
    }
    


}
