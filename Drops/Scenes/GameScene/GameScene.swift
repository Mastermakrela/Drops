//
//  GameScene.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 21/05/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: PrototypeScene {
    
    //MARK: - Properties
    static let numberOfLevels = 10
    static var startlevel = 0
    var currentLevel = 0
    
    //MARK: - Initializers
    override init(size: CGSize) {
        super.init(size: size)
        currentLevel = GameScene.startlevel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        currentLevel = GameScene.startlevel
    }
    
    // Main Logic
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        preseentScene()
        
    }
    
    func goToNextLevel() {
        currentLevel += 1
        preseentScene()
    }
    
    func goToMenu() {
        GameScene.startlevel = 0
        if let scene = GKScene(fileNamed: "MenuScene") {
            if let sceneNode = scene.rootNode as! MenuScene? {
                sceneNode.scaleMode = .aspectFill
                
                mySKView!.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1))
            }
        }
    }
    
    func preseentScene(){
        let lvl = currentLevel
        let file = "Level_\(lvl)"
        
        if let scene = GKScene(fileNamed: file) {
            if let sceneNode = scene.rootNode as! LevelPrototype? {
                sceneNode.scaleMode = .aspectFill
                
                sceneNode.gameScene = self
                
                mySKView!.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1.5))
            }
        }
    }
    
    //MARK: - Update function
//    override func update(_ currentTime: TimeInterval) {
//        super.update(currentTime)
//    }
    
    
}
