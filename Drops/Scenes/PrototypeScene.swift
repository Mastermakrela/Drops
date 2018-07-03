//
//  PrototypeScene.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 04/06/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

struct EntitiesNames {
    static let Ball = "ball"
    static let Hole = "hole"
}

struct ContactCategory {
    static let Ball : UInt32 = 0x1 << 0
    static let Hole : UInt32 = 0x1 << 1
}

struct PhysicsCategory {
    static let ball : UInt32 = 1
    static let hole : UInt32 = 0
}

class PrototypeScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - Properties
    var mySKView: SKView? = nil
    private let motionMenager = CMMotionManager()
    
    //Ball with initalizer
    public lazy var ball: Ball? = {
        for child in children {
            if child is Ball {
                self.motionMenager.startDeviceMotionUpdates()
                self.motionMenager.deviceMotionUpdateInterval = 1.0/30.0
                return child as? Ball
            }
        }
        return nil
    }()
    
    
    //MARK: - Initializers
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        mySKView = view
        
        // Set self to be conntact delegate
        physicsWorld.contactDelegate = self
        
        // Setup screen border
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        //Setups
        setupWalls()
        setupHoles()
        
    }
    
    //MARK: - Setups
    func setupWalls() {
        for child in children {
            if child is Wall {
                let childPos = child.position
                let childName = child.name
                let childSize = child.frame.size
                child.removeFromParent()
                child.removeAllChildren()
                
                let w = Wall(texture: nil, color: UIColor.blue, size: childSize)
                w.position = childPos
                w.name = childName
                addChild(w)
            }
        }
    }
    
    func setupHoles() {
        for child in children {
            if child is Hole {
                let childPos = child.position
                let childName = child.name
                child.removeFromParent()
                child.removeAllChildren()
                
                let h = Hole()
                h.position = childPos
                h.name = childName
                addChild(h)
            }
        }
    }
    
    //MARK: - Contact Delegate
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        twoBodiesTouched(firstBody: firstBody, secondBody: secondBody)
    }
    
    func twoBodiesTouched(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody){
        fatalError("Must Implement")
    }
    
    //MARK: - Update function
    override func update(_ currentTime: TimeInterval) {
        //Update state machine
        //stateMachine.update(deltaTime: currentTime)
        
        // Check if this scene contains ball
        if ball != nil {
            // Get current device motion
            let deviceMotion = motionMenager.deviceMotion
            updateBall(deviceMotion: deviceMotion)
        }
        
    }
    
    // Update balls position using CGVector
    fileprivate func updateBall(deviceMotion: CMDeviceMotion?) {
        let sensivity = 0.05
        let steps = CGFloat(10)
        if deviceMotion != nil && ball!.physicsBody != nil {
            if(deviceMotion!.attitude.pitch > sensivity) {
                ball!.physicsBody!.velocity = CGVector(dx: ball!.physicsBody!.velocity.dx+steps, dy: ball!.physicsBody!.velocity.dy)
            }
            
            if(deviceMotion!.attitude.pitch < -sensivity) {
                ball!.physicsBody!.velocity = CGVector(dx: ball!.physicsBody!.velocity.dx-steps, dy: ball!.physicsBody!.velocity.dy)
            }
            
            if(deviceMotion!.attitude.roll > sensivity) {
                ball!.physicsBody!.velocity = CGVector(dx: ball!.physicsBody!.velocity.dx, dy: ball!.physicsBody!.velocity.dy+steps)
            }
            
            if(deviceMotion!.attitude.roll < -sensivity) {
                ball!.physicsBody!.velocity = CGVector(dx: ball!.physicsBody!.velocity.dx, dy: ball!.physicsBody!.velocity.dy-steps)
            }
        }
    }
    
    
}
