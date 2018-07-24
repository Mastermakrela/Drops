//
//  LevelSelection.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 08/06/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import SpriteKit
import GameplayKit

class LevelSelection: PrototypeScene {
    
    //MARK: - Properties
    lazy var ballCamera: SKCameraNode? = {
        for child in children {
            if child is SKCameraNode {
                return child as? SKCameraNode
            }
        }
        return nil
    }()
    //Sizes
    private let holesDistance:CGFloat = 200
    
    //MARK: - Initialization
    override init(size: CGSize) {
        let wid = CGFloat(GameScene.numberOfLevels  + 1)  * holesDistance
        super.init(size: CGSize(width: wid, height: size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let wid = CGFloat(GameScene.numberOfLevels  + 1)  * holesDistance
        self.size = CGSize(width: wid, height: self.size.height)
    }
    
    //MARK: -
//    override func didMove(to view: SKView) {
//
//        super.didMove(to: view)
//        
//    }
    
    override func setupHoles() {
        var pos = CGPoint(x: (-self.size.width/2) + holesDistance/2, y: 0)
        
        //Setup menuHole with label
        let menuHole = Hole()
        menuHole.name = "holeMenu"
        menuHole.position = pos
        
        let mLab = SKLabelNode(text: "Menu")
        mLab.position.x = pos.x
        mLab.position.y = -60
        
        addChild(menuHole)
        addChild(mLab)
        
        //Setup level holes with labels
        for i in 0..<GameScene.numberOfLevels {
            pos.x += holesDistance
            
            let new = Hole()
            new.type = .level
            new.name = "\(i)"
            new.position = pos
            
            let lab = SKLabelNode(text: "Level \(new.name!)")
            lab.position.x = pos.x
            lab.position.y = -60
            
            addChild(new)
            addChild(lab)
        }
    }
    
    override func twoBodiesTouched(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody) {
        if firstBody.categoryBitMask == ContactCategory.Ball && secondBody.categoryBitMask == ContactCategory.Hole {
            let hole = secondBody.node as! Hole
            
            if hole.name == "holeMenu" {
                goToMenu()
            } else {
                GameScene.startlevel = Int(hole.name!)!
                
                print("Going to GameScene")
                if let scene = GKScene(fileNamed: "GameScene") {
                    if let sceneNode = scene.rootNode as! GameScene? {
                        sceneNode.scaleMode = .aspectFill
                        
                        mySKView!.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1))
                    }
                }
            }
            
        }
        
    }
    
    //Horizontal camera scrolling, moving only in x-axis
    override func didSimulatePhysics() {
        if camera != nil && ball != nil {
            let scrWid = UIScreen.main.bounds.width
//            let bPos = ball!.position.x
            
            
            //TODO: Make camera move smoother
//            if bPos <= -((scrWid/2)*1.2) {
//                camera!.position.x = -(((scrWid/2)*1.2))
//            } else if bPos >= ((scrWid/2)*1.2) {
//                camera!.position.x = (((scrWid/2)*1.2))
//            } else {
//                camera!.position.x = ball!.position.x
//            }
            camera!.position.x = ball!.position.x
            if camera!.position.x <= ((-self.size.width/2) + scrWid/2) {
                camera!.position.x = ((-self.size.width/2) + scrWid/2)
            } else if camera!.position.x >= ((self.size.width/2) - scrWid/2) {
                camera!.position.x = ((self.size.width/2) - scrWid/2)
            }
            
        }
    }
    
    func goToMenu() {
        if let scene = GKScene(fileNamed: "MenuScene") {
            if let sceneNode = scene.rootNode as! MenuScene? {
                sceneNode.scaleMode = .aspectFill
                mySKView!.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1))
            }
        }
    }
    
}
