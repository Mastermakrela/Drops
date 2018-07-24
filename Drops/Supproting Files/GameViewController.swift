//
//  GameViewController.swift
//  Drops
//
//  Created by Krzysztof Kostrzewa on 21/05/2018.
//  Copyright © 2018 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

struct NotificationNames {
    static let backFromSettings = Notification.Name("backFromSettings")
    static let goToSettings = Notification.Name("goToSettings")
}

class GameViewController: UIViewController {
    
    //Properties
    private var scene: GKScene? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToSettings), name: NotificationNames.goToSettings, object: nil)
        
        loadGameScene()
        
    }
    
    @objc
    func goToSettings() {
        performSegue(withIdentifier: "SettingsSegue", sender: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadGameScene), name: NotificationNames.backFromSettings, object: nil)
    }

    @objc
    func loadGameScene() {
        if let scene = GKScene(fileNamed: "MenuScene") {
            self.scene = scene
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MenuScene? {
                
                //DEBUG
                //sceneNode.gameViewController = self
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    
    //MARK: Presets
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
