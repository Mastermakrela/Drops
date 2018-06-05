//
//  GameScene.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 21/05/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion


class GameScene: PrototypeScene {
    
    //TODO
    //MARK: - Initializers
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Main Logic
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        
//        // Get Ball node
//        ball = childNode(withName: EntitiesNames.Ball) as! SKSpriteNode
//        ball.physicsBody?.categoryBitMask = ContactCategory.Ball
//        ball.physicsBody?.collisionBitMask = PhysicsCategory.ball
        
        /*
         // Setup all Holes
         setupHoles()
         */
        
//        // Creates and adds states to the state machine.
//        stateMachine = GKStateMachine(states: [
//            MenuState(game: self),
//            GameState(game: self),
//            PausedState(game: self),
//            GameOverState(game: self)
//            ])
        
        // Tells the state machine to enter the menu state.
        stateMachine.enter(MenuState.self)
        
        //DEBUG
        stateMachine.enter(GameState.self)
    }
    
//    func didBegin(_ contact: SKPhysicsContact) {
//        var firstBody: SKPhysicsBody
//        var secondBody: SKPhysicsBody
//
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        } else {
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
//
//        if firstBody.categoryBitMask == ContactCategory.Ball && secondBody.categoryBitMask == ContactCategory.Hole {
//            print(secondBody.node?.name ?? "HUI")
//
//            if let s = stateMachine.currentState as? GameState {
//                s.removeBall()
//            }
//        }
//
//    }
    
    override func twoBodiesTouched(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody){
        if firstBody.categoryBitMask == ContactCategory.Ball && secondBody.categoryBitMask == ContactCategory.Hole {
            print(secondBody.node?.name ?? "HUI")
            
            if let s = stateMachine.currentState as? GameState {
                s.removeBall()
            }
        }
    }
    
    
    
//    override func update(_ currentTime: TimeInterval) {
//        
//
//    }
}
