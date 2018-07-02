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
    var levelsStateMachine: GKStateMachine!
    
    //TODO
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
        
        // Creates and adds states to the state machine.
        levelsStateMachine = GKStateMachine(states: [
            PlayingState(scene: self)
            ])
        
        levelsStateMachine.enter(PlayingState.self)
        
    }
    
    func goToNextLevel() {
        currentLevel += 1
        levelsStateMachine.enter(PlayingState.self)
    }
    
    func goToMenu() {
        currentLevel = 0
        if let scene = GKScene(fileNamed: "MenuScene") {
            if let sceneNode = scene.rootNode as! MenuScene? {
                sceneNode.scaleMode = .aspectFill
                
                mySKView!.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1))
            }
        }
    }
    
    //MARK: - Update function
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        //Update state machine
        levelsStateMachine.update(deltaTime: currentTime)
    }
    
    
}
