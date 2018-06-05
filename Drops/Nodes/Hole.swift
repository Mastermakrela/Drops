//
//  Hole.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 23/05/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit

class Hole: SKSpriteNode {
    
    // Properties
    private var imageName = "hole"
    private var defaultSize = CGSize(width: 45, height: 45)
    private var physicRadius: CGFloat = 7.5
    
    // Initalizers
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        var img = UIImage(named: imageName)
        img = img?.resizeImageWith(newSize: defaultSize)
        
        super.init(texture: SKTexture(image: img!), color: color, size: defaultSize)
        
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        var img = UIImage(named: imageName)
        img = img?.resizeImageWith(newSize: defaultSize)
        
        super.init(coder: aDecoder)
        
        self.size = defaultSize
        self.texture = SKTexture(image: img!)
        
        setupPhysics()
    }
    
    //MARK: - Setup Physics
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: physicRadius)
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.friction = 0.0
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.isDynamic = false
        self.physicsBody!.usesPreciseCollisionDetection = true
        //self.physicsBody?.pinned = true
        
        // Default BitMasks
        self.physicsBody!.categoryBitMask = ContactCategory.Hole
        self.physicsBody!.collisionBitMask = PhysicsCategory.hole
        self.physicsBody!.contactTestBitMask = ContactCategory.Ball
        
    }
    
    
}
