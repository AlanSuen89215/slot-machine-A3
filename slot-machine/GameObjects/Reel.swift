//
//  GameScene.swift
//  slot-machine
//
//  MAPD724 Assignment 1
//  Group 9

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
