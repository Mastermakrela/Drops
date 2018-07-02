//
//  PlayingState.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 13/06/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import GameplayKit

class PlayingState: GKState {
    
    let gameScene: GameScene
    
    init(scene: SKScene?) {
        self.gameScene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        
        preseentScene()
        
    }
    
    func preseentScene(){
        let lvl = gameScene.currentLevel
        let file = "Level_\(lvl)"
        
        if let scene = GKScene(fileNamed: file) {
            if let sceneNode = scene.rootNode as! LevelPrototype? {
                sceneNode.scaleMode = .aspectFill
                
                sceneNode.ownState = self
                
                gameScene.mySKView!.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1))
            }
        }
    }
    
}
