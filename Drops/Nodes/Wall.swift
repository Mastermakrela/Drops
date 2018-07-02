//
//  Wall.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 01/07/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit

class Wall: SKSpriteNode {
    
    // Properties
    private var imageName = ""
    
    // Initalizers
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.color = UIColor.blue
        
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.color = UIColor.blue
        
        setupPhysics()
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        
        physicsBody!.pinned = true
        physicsBody!.affectedByGravity = false
        physicsBody!.allowsRotation = false
        physicsBody!.isDynamic = false
        
        physicsBody!.restitution = 0.0
        physicsBody!.friction = 0.0
        physicsBody?.linearDamping = 0.0
        physicsBody?.angularDamping = 0.0
        
    }
    
}
