//
//  MenuState.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 29/05/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuState: GKState {
    
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
        
        switch previousState {
        case .none:
            print("Entered menu from nil")
//            let menuScene = SKScene(fileNamed: "Menu")!
//            game.mySKView?.presentScene(menuScene)
            break
        case is PausedState:
            print("Entered menu from pause")
            break
        case is GameOverState:
            print("Entered menu from gameOver")
            break
        default:
            break
        
        }
        
        
    }
    
    //
    override func willExit(to nextState: GKState) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // This state can only transition to the full state.
        return stateClass is GameState.Type
    }
    
}
