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

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var bgImage : Background?
    var reel1 : Reel?
    var reel2 : Reel?
    var reel3 : Reel?
    
    override func sceneDidLoad() {
        name = "GAME"
        
        bgImage = Background()
        addChild(bgImage!)
        
        reel1  = Reel(xPosition: -180)
        addChild(reel1!)
        
        reel2  = Reel(xPosition: 0)
        addChild(reel2!)
        
        reel3  = Reel(xPosition: 180)
        addChild(reel3!)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {

    }
}
