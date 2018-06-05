//
//  PausedState.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 29/05/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit

class PausedState: GKState {
    
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
        
    }
    
    //
    override func willExit(to nextState: GKState) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // This state can only transition to the full state.
        return stateClass is GameState.Type
    }
    
    
}
