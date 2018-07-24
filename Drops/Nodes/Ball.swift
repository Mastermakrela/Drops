//
//  Ball.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 04/06/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit

class Ball: SKSpriteNode {
    
    // Properties
    private let ballRadius: CGFloat = 20.0
    private var imageName: String = {
        if let kek = UserDefaults.standard.dictionary(forKey: "settings") {
            if (kek["IgelBall"] as! Bool) {
                return "FB_Hedgehog"
            }
        }
        return "ball"
    }()
    
    //MARK: - Initalizers
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let defaultSize = CGSize(width: 2 * ballRadius, height: 2 * ballRadius)
        var img = UIImage(named: imageName)
        img = img?.resizeImageWith(newSize: defaultSize)

        super.init(texture: SKTexture(image: img!), color: color, size: size)
        
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        let defaultSize = CGSize(width: 2 * ballRadius, height: 2 * ballRadius)
        var img = UIImage(named: imageName)
        img = img?.resizeImageWith(newSize: defaultSize)
        
        super.init(coder: aDecoder)
        
        self.size = defaultSize
        self.texture = SKTexture(image: img!)

        setupPhysics()
    }
    
    //MARK: - Setup Physics
    private func setupPhysics() {
        self.physicsBody!.isDynamic = true
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.affectedByGravity = false

        self.physicsBody!.friction = 0.1
        self.physicsBody!.restitution = 0.8
        self.physicsBody!.linearDamping = 0.2

        
        // Default BitMasks
        self.physicsBody!.categoryBitMask = ContactCategory.Ball
        self.physicsBody!.collisionBitMask = PhysicsCategory.ball
    }
    
}
