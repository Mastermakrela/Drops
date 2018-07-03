//
//  LevelPrototype.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 12/06/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit

class LevelPrototype: PrototypeScene {
    
    //MARK: - Properties
    var gameScene: GameScene? = nil
    
    override func twoBodiesTouched(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody){
        print("body touch levelProt \(gameScene!.currentLevel)")
        if firstBody.categoryBitMask == ContactCategory.Ball && secondBody.categoryBitMask == ContactCategory.Hole {
            let hole = secondBody.node as! Hole

            switch hole.type {
            case .win:
                gameScene!.goToNextLevel()
                break
                
            case .lose:
                removeBall()
                gameScene!.goToMenu()
                break
                
            case .other, .level:
                fatalError("Collision with Hole type other")
                break
            }
            
        }
    }

    func removeBall(){
        //TODO Make better
        //IDEA: stop motion updates to save battery
        print("remove ball")

        ball!.physicsBody?.isDynamic = false
        ball!.run(SKAction.fadeOut(withDuration: 0.5)) {
            self.ball!.removeAllChildren()
            self.ball!.removeFromParent()
        }
    }
    
}
