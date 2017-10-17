//
//  GameViewController.swift
//  Hedgehog Dash
//
//  Created by Luke on 2/15/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Essential Math
        Math.DegreesToRadians = Math.Pi / 180;
        Math.RadiansToDegrees = 180 / Math.Pi;

        // Configure the view.
        Scenes.skView = self.view as! SKView
        Scenes.skView.showsFPS = true
        Scenes.skView.ignoresSiblingOrder = true
        
        Scenes.GAME_MENU_SCENE = GameMenuScene(size: Scenes.skView.bounds.size);
        Scenes.WORLD_MENU_SCENE = WorldSelectionScene(size: Scenes.skView.bounds.size);
        Scenes.GAME_SCENE = GameScene(size: Scenes.skView.bounds.size);
        Scenes.LEVEL_SELECTION_SCENE = LevelSelectionScene(size: Scenes.skView.bounds.size);
        
        Scenes.GAME_MENU_SCENE?.scaleMode = SKSceneScaleMode.ResizeFill
        Scenes.GAME_SCENE?.scaleMode = SKSceneScaleMode.ResizeFill
        
        Scenes.skView.presentScene(Scenes.GAME_MENU_SCENE)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

   /* override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
