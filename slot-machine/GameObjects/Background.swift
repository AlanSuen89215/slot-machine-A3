//
//  MAPD724 W2023
//  Group 9
//  Assignment 2
//  App description: slot-machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  StartPafgeViewController.swift
//  Date: Jan 18, 2023
//  Version: 2.0
//

import GameplayKit
import SpriteKit

class Background : GameObject {
    // constructor
    init() {
        super.init(imageString: "screen", initialScale: 1.8)
        zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
