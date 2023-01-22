//
//  GameScene.swift
//  slot-machine
//
//  MAPD724 Assignment 1
//  Group 9

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
