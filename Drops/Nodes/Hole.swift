//
//  Hole.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 23/05/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit

enum HoleType {
    case win
    case lose
    case level
    case other
}

class Hole: SKSpriteNode {
    
    // Properties
    private var imageName = "hole"
    private var defaultSize = CGSize(width: 45, height: 45)
    private var physicRadius: CGFloat = 7.5
    
    public var type: HoleType = .other
    override var name: String? {
        didSet {
            super.name = self.name
            
            if name?.lowercased().range(of: "win") != nil {
                self.type = .win
            } else if name?.lowercased().range(of: "lose") != nil {
                self.type = .lose
            } else {
                self.type = .other
            }
        }
    }
    
    // Initalizers
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        var img = UIImage(named: imageName)
        img = img?.resizeImageWith(newSize: defaultSize)
        
        super.init(texture: SKTexture(image: img!), color: color, size: defaultSize)
        
        self.zPosition = 1
        
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        var img = UIImage(named: imageName)
        img = img?.resizeImageWith(newSize: defaultSize)
        
        super.init(coder: aDecoder)
        
        self.zPosition = 1
        
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
        
        // Default BitMasks
        self.physicsBody!.categoryBitMask = ContactCategory.Hole
        self.physicsBody!.collisionBitMask = PhysicsCategory.hole
        self.physicsBody!.contactTestBitMask = ContactCategory.Ball
        
    }
    
    
}
