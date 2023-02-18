//
//  MAPD724 W2023
//  Group 9
//  Assignment 3
//  App description: slot-machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  Reel.swift
//  Date: Jan 18, 2023
//  Version: 2.0
//

import GameplayKit
import SpriteKit

class Reel : GameObject {
    // constructor
    init(xPosition xPos: CGFloat) {
        super.init(imageString: "1", initialScale: 0.6)
        zPosition = 1
        position.y = -58
        position.x = xPos
    }
    /*
    init() {
        super.init(imageString: "1", initialScale: 0.6)
        zPosition = 1
        position.y = -58
    }
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
