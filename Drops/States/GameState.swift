//
//  GameState.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 29/05/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameState: GKState {
    
    // MARK: Properties
    
    /// A reference to the game scene, used to alter sprites.
    let game: PrototypeScene
    
    // MARK: Initialization
    init(game: PrototypeScene) {
        self.game = game
    }
    
    // MARK: GKState overrides
    
    //
    override func didEnter(from previousState: GKState?) {
        if previousState != nil {
            switch previousState! {
            case is MenuState:
                print("Entered game from menu")
                game.motionMenager.startDeviceMotionUpdates()
                game.motionMenager.deviceMotionUpdateInterval = 1.0/30.0
                setupHoles()
                break
                
            case is PausedState:
                print("Entered game from pause")
                break
                
            default:
                print("ERROR: Enter game state")
                break
            }
        }
    }
    
    //
    override func willExit(to nextState: GKState) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // This state can transition to Pause or GameOver
        return stateClass is PausedState.Type || stateClass is GameOverState.Type
    }
    
    // Methods
    func setupHoles() {
        for child in game.children {
            if child is Hole {
                let childPos = child.position
                let childName = child.name
                child.removeFromParent()
                
                let h = Hole()
                h.position = childPos
                h.name = childName
                game.addChild(h)
                
                child.removeAllChildren()
                child.removeFromParent()
            }
        }
    }
    
    func removeBall(){
        //TODO Make better
        //IDEA: stop motion updates to save battery
        print("remove ball")
        
        game.ball!.physicsBody?.isDynamic = false
        game.ball!.run(SKAction.fadeOut(withDuration: 0.5)) {
            self.game.ball!.removeAllChildren()
            self.game.ball!.removeFromParent()
        }
    }
    
}
