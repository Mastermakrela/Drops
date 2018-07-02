//
//  MenuScene.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 04/06/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit

struct HoleDestination {
    static let settings = "holeSettings"
    static let play = "holeStart"
    static let levels = "holeLevels"
}

class MenuScene: PrototypeScene {
    
    // Main Logic
    override func didMove(to view: SKView) {
        super.didMove(to: view)
    }
    
    override func twoBodiesTouched(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody) {
        if firstBody.categoryBitMask == ContactCategory.Ball && secondBody.categoryBitMask == ContactCategory.Hole {
            print(secondBody.node?.name ?? "HUI")
            
            switch secondBody.node?.name {
            case HoleDestination.play:
                print("Going to GameScene")
                if let scene = GKScene(fileNamed: "GameScene") {
                    if let sceneNode = scene.rootNode as! GameScene? {
                        sceneNode.scaleMode = .aspectFill
                        
                        mySKView!.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1))
                    }
                }
                
                
                break
            case HoleDestination.levels:
                print("Going to LevelsScene")
                if let scene = GKScene(fileNamed: "LevelSelectionScene") {
                    if let sceneNode = scene.rootNode as! LevelSelection? {
                        sceneNode.scaleMode = .aspectFill
                        
                        mySKView!.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1))
                    }
                }
                
                break
            case HoleDestination.settings:
                print("Going to Settings")
                break
            default:
                break
            }
            
            
        }
    }
    
}
