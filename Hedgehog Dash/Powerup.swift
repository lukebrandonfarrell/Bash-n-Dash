//
//  Collectables.swift
//  Hedgehog Dash
//
//  Created by Luke on 2/19/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class Powerup : SKSpriteNode {
    
    var randomPowerup:[String] = ["Shield", "2X", "Clock", "Magnet"];
    var powerUp:String = "Shield";
    
    
    func Setup()
    {
        powerUp = randomPowerup[random() % 4];
        //Apply Random Force from Position
        //self.zRotation = GameScene.randomBetweenNumbers(-2, secondNum: 2);
        self.zPosition = 2;
        
        let random_force_x:CGFloat = GameScene.randomBetweenNumbers(-15 * Game.scale_value, secondNum: 15 * Game.scale_value);
        let random_force_y:CGFloat = GameScene.randomBetweenNumbers(-15 * Game.scale_value, secondNum: 15 * Game.scale_value);
        
        self.physicsBody?.applyImpulse(CGVector(dx: random_force_x, dy: random_force_y));
        
        self.name = powerUp;
        
        switch (powerUp)
        {
            case "Shield" :
                self.texture = Textures.GUI_sheet.Icon_Shield();
            case "2X" :
                self.texture = Textures.GUI_sheet.Icon_X2();
            case "Clock" :
                self.texture = Textures.GUI_sheet.Icon_Clock();
            case "Magnet" :
                self.texture = Textures.GUI_sheet.Icon_magnet();
            default:
                 self.texture = Textures.GUI_sheet.Icon_Shield();
        }
    }
}