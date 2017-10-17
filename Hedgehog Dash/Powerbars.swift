//
//  Powerbars.swift
//  Hedgehog Dash
//
//  Created by Luke on 6/21/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class Powerbars : SKSpriteNode {
    
    var bars:Int = 0;
    
    var shield_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Shield());
    var _2X_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_X2());
    var clock_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Clock());
    var magnet_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_magnet());
    
    var shield_bar:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBarFull());
    var _2X_bar:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBarFull());
    var clock_bar:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBarFull());
    var magnet_bar:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBarFull());
    
    var shield_bar_bg:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBar());
    var _2X_bar_bg:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBar());
    var clock_bar_bg:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBar());
    var magnet_bar_bg:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBar());
    
    var shield_bar_width:CGFloat!;
    var _2X_bar_width:CGFloat!;
    var clock_bar_width:CGFloat!;
    var magnet_bar_width:CGFloat!;
    
    func Setup()
    {
        
        self.addChild(shield_bar_bg);
        self.addChild(_2X_bar_bg);
        self.addChild(clock_bar_bg);
        self.addChild(magnet_bar_bg);
        
        shield_bar_bg.position.y = -shield_bar_bg.size.height * 1;
        _2X_bar_bg.position.y = -_2X_bar_bg.size.height * 2;
        clock_bar_bg.position.y = -clock_bar_bg.size.height * 3;
        magnet_bar_bg.position.y = -magnet_bar_bg.size.height * 4;
        
        self.addChild(shield_bar);
        self.addChild(_2X_bar);
        self.addChild(clock_bar);
        self.addChild(magnet_bar);
        
        shield_bar.anchorPoint = CGPoint(x: 0, y: 0);
        _2X_bar.anchorPoint = CGPoint(x: 0, y: 0);
        clock_bar.anchorPoint = CGPoint(x: 0, y: 0);
        magnet_bar.anchorPoint = CGPoint(x: 0, y: 0);
        
        shield_bar_bg.setScale(Game.scale_value * 1.5);
        _2X_bar_bg.setScale(Game.scale_value * 1.5);
        clock_bar_bg.setScale(Game.scale_value * 1.5);
        magnet_bar_bg.setScale(Game.scale_value * 1.5);
        
        shield_bar.setScale(Game.scale_value * 1.5);
        _2X_bar.setScale(Game.scale_value * 1.5);
        clock_bar.setScale(Game.scale_value * 1.5);
        magnet_bar.setScale(Game.scale_value * 1.5);
        
        shield_bar.position = CGPoint(x: shield_bar_bg.position.x - shield_bar.size.width/2, y: shield_bar_bg.position.y - shield_bar.size.height/2);
        _2X_bar.position = CGPoint(x: _2X_bar_bg.position.x - _2X_bar.size.width/2, y: _2X_bar_bg.position.y - _2X_bar.size.height/2);
        clock_bar.position = CGPoint(x: clock_bar_bg.position.x - clock_bar.size.width/2, y: clock_bar_bg.position.y - clock_bar.size.height/2);
        magnet_bar.position = CGPoint(x: magnet_bar_bg.position.x - magnet_bar.size.width/2, y: magnet_bar_bg.position.y - magnet_bar.size.height/2);
        
        shield_bar_bg.alpha = 0;
        _2X_bar_bg.alpha = 0;
        clock_bar_bg.alpha = 0;
        magnet_bar_bg.alpha = 0;
        
        shield_bar.alpha = 0;
        _2X_bar.alpha = 0;
        clock_bar.alpha = 0;
        magnet_bar.alpha = 0;
        
        shield_bar_width = shield_bar.size.width;
        _2X_bar_width = _2X_bar.size.width;
        clock_bar_width = clock_bar.size.width;
        magnet_bar_width = magnet_bar.size.width;
        
        //Icons
        self.addChild(shield_icon);
        self.addChild(_2X_icon);
        self.addChild(clock_icon);
        self.addChild(magnet_icon);
        
        shield_icon.position = CGPoint(x: shield_bar_bg.position.x - shield_bar_bg.size.width/2, y: shield_bar_bg.position.y);
        _2X_icon.position = CGPoint(x: _2X_bar_bg.position.x - _2X_bar.size.width/2, y: _2X_bar_bg.position.y);
        clock_icon.position = CGPoint(x: clock_bar_bg.position.x - clock_bar.size.width/2, y: clock_bar_bg.position.y);
        magnet_icon.position = CGPoint(x: magnet_bar_bg.position.x - magnet_bar.size.width/2, y: magnet_bar_bg.position.y);
        
        shield_icon.alpha = 0;
        _2X_icon.alpha = 0;
        clock_icon.alpha = 0;
        magnet_icon.alpha = 0;
        
        shield_icon.zPosition = 1;
        magnet_icon.zPosition = 1;
        _2X_icon.zPosition = 1;
        clock_icon.zPosition = 1;
    }
    
    func Update()
    {
        shield_icon.position.y = shield_bar_bg.position.y;
        _2X_icon.position.y = _2X_bar_bg.position.y;
        clock_icon.position.y = clock_bar_bg.position.y;
        magnet_icon.position.y = magnet_bar_bg.position.y;

        shield_bar.position.y = shield_bar_bg.position.y - shield_bar.size.height/2;
        _2X_bar.position.y = _2X_bar_bg.position.y - _2X_bar.size.height/2;
        clock_bar.position.y = clock_bar_bg.position.y - clock_bar.size.height/2;
        magnet_bar.position.y = magnet_bar_bg.position.y - magnet_bar.size.height/2;

        
    
        if(Level.Shield_Powerup)
        {
            shield_icon.alpha = 1.0;
            shield_bar_bg.alpha = 0.6;
            shield_bar.alpha = 0.8;
            shield_bar.size.width = (shield_bar_width * Level.Shield_Time) / 75;
            Level.Shield_Time -= 0.1;
            if(Level.Shield_Time <= 0){Level.Shield_Time = 0;}
        }
        
        if(Level.Shield_Time <= 0 && Level.Shield_Powerup){bars--;}
        
        if(Level.Shield_Time <= 0)
        {
            shield_icon.alpha = 0;
            shield_bar_bg.alpha = 0;
            shield_bar.alpha = 0;
        }
        
        // ------ //
        
        if(Level._2X_Powerup)
        {
            _2X_icon.alpha = 1.0;
            _2X_bar_bg.alpha = 0.6;
            _2X_bar.alpha = 0.8;
            _2X_bar.size.width = (_2X_bar_width * Level._2X_Time) / 75;
            Level._2X_Time -= 0.1;
            if(Level._2X_Time <= 0){Level._2X_Time = 0;}
        }
        
        if(Level._2X_Time <= 0 && Level._2X_Powerup){bars--;}
        
        if(Level._2X_Time <= 0)
        {
            _2X_icon.alpha = 0;
            _2X_bar_bg.alpha = 0;
            _2X_bar.alpha = 0;
            Level._2X_Powerup = false;
        }
        
         // ------ //
        
        if(Level.Clock_Powerup)
        {
            clock_icon.alpha = 1.0;
            clock_bar_bg.alpha = 0.6;
            clock_bar.alpha = 0.8;
            clock_bar.size.width = (clock_bar_width * Level.Clock_Time) / 75;
            Level.Clock_Time -= 0.1;
            if(Level.Clock_Time <= 0){Level.Clock_Time = 0;}
        }
        
        if(Level.Clock_Time <= 0 && Level.Clock_Powerup){bars--;}
        
        if(Level.Clock_Time <= 0)
        {
            clock_icon.alpha = 0;
            clock_bar_bg.alpha = 0;
            clock_bar.alpha = 0;
        }
        
         // ------ //

        if(Level.Magnet_Powerup)
        {
            magnet_icon.alpha = 1.0;
            magnet_bar_bg.alpha = 0.6;
            magnet_bar.alpha = 0.8;
            magnet_bar.size.width = (magnet_bar_width * Level.Magnet_Time) / 75;
            Level.Magnet_Time -= 0.1;
            if(Level.Magnet_Time <= 0){Level.Magnet_Time = 0;}
        }
        
        if(Level.Magnet_Time <= 0 && Level.Magnet_Powerup){bars--;}
        
        if(Level.Magnet_Time <= 0)
        {
            magnet_icon.alpha = 0;
            magnet_bar_bg.alpha = 0;
            magnet_bar.alpha = 0;
        }

    }
    
    func ResetAllBars()
    {
        shield_icon.alpha = 0;
        shield_bar_bg.alpha = 0;
        shield_bar.alpha = 0;
        
        _2X_icon.alpha = 0;
        _2X_bar_bg.alpha = 0;
        _2X_bar.alpha = 0;
        
        clock_icon.alpha = 0;
        clock_bar_bg.alpha = 0;
        clock_bar.alpha = 0;
        
        magnet_icon.alpha = 0;
        magnet_bar_bg.alpha = 0;
        magnet_bar.alpha = 0;
        
        Level.Shield_Powerup = false;
        Level._2X_Powerup = false;
        Level.Clock_Powerup = false;
        Level.Magnet_Powerup = false;
    }
}