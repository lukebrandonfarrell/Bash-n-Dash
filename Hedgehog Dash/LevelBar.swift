//
//  LevelBar.swift
//  Hedgehog Dash
//
//  Created by Luke on 8/7/15.
//  Copyright © 2015 Puzzled. All rights reserved.
//

import Foundation

import SpriteKit

class LevelBar : SKSpriteNode {
    
    var isSetup:Bool = false;
    var isAddedToScene:Bool = false;
    
    var thumbnail:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Thumbnail());
    var levelbar:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_PowerBarBlue());
    var levelbar_empty:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_LevelBar());
    
    let PlayerLevel_Label:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let Exp_Label:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let ExpNeeded_Label:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
    let MultiplierValue_Label:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
    var levelbarWidth:CGFloat!;
    
    func SetUp()
    {
        thumbnail.setScale(Game.scale_value * 0.6);
        levelbar.setScale(Game.scale_value * 0.8);
        levelbar_empty.setScale(Game.scale_value * 0.8);
        
        levelbar_empty.position = CGPoint(x: 0, y: 0);
        levelbar.position = CGPoint(x: self.position.x - levelbar.size.width/2, y: self.position.y - levelbar.size.height/2);
        thumbnail.position = CGPoint(x: self.position.x, y: 0);
        
        //Set Fonts
        PlayerLevel_Label.fontColor = UIColor.whiteColor();
        PlayerLevel_Label.fontSize = 20 * Game.scale_value;
        PlayerLevel_Label.text = "Level: " + String(Currency.PlayerLevel)
        PlayerLevel_Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left;
        
        Exp_Label.fontColor = UIColor.whiteColor();
        Exp_Label.fontSize = 20 * Game.scale_value;
        Exp_Label.text = String(Currency.Exp)
        Exp_Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right;
        
        ExpNeeded_Label.fontColor = UIColor.whiteColor();
        ExpNeeded_Label.fontSize = 20 * Game.scale_value;
        ExpNeeded_Label.text = "  / " + String(Currency.ExpNeeded)
        ExpNeeded_Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right;
        
        MultiplierValue_Label.fontColor = UIColor.whiteColor();
        MultiplierValue_Label.fontSize = 20 * Game.scale_value;
        MultiplierValue_Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right;
        
        addChild(thumbnail); thumbnail.zPosition =  5;
        addChild(levelbar); levelbar.zPosition =  4;
        addChild(levelbar_empty); levelbar_empty.zPosition =  3;
        
        PlayerLevel_Label.position = CGPoint(x: levelbar_empty.frame.minX, y: levelbar.position.y + levelbar_empty.size.height);
        ExpNeeded_Label.position = CGPoint(x:levelbar_empty.frame.maxX, y: levelbar.position.y + levelbar_empty.size.height);
        Exp_Label.position = CGPoint(x:ExpNeeded_Label.position.x - ExpNeeded_Label.frame.width, y: levelbar.position.y + levelbar_empty.size.height);
        MultiplierValue_Label.position = CGPoint(x:levelbar_empty.frame.maxX, y: levelbar.position.y - levelbar_empty.size.height);
        
        addChild(PlayerLevel_Label);
        addChild(Exp_Label);
        addChild(ExpNeeded_Label);
        addChild(MultiplierValue_Label);
        
        PlayerLevel_Label.zPosition = 5;
        Exp_Label.zPosition = 5;
        ExpNeeded_Label.zPosition = 5;
        MultiplierValue_Label.zPosition =  5;
        
        levelbarWidth = levelbar.size.width;
        levelbar.anchorPoint = CGPoint(x: 0, y: 0);
        levelbar.size.width = (levelbarWidth * CGFloat(Currency.Exp)) / CGFloat(Currency.ExpNeeded);
        
        isSetup = true;
    }
    
    func Update()
    {
        PlayerLevel_Label.text = "Level: " + String(Currency.PlayerLevel)
        Exp_Label.text = String(Currency.Exp)
        ExpNeeded_Label.text = "  / " + String(Currency.ExpNeeded)
        levelbar.size.width = (levelbarWidth * CGFloat(Currency.Exp)) / CGFloat(Currency.ExpNeeded);
        
        if(Currency.Exp >= Currency.ExpNeeded){
            Currency.ExpNeeded += Currency.ExpNeeded;
            Currency.Exp = 0;
            Currency.PlayerLevel++;
        }
        
        if(Level.Multiplier >= 2){
            MultiplierValue_Label.text = "x" + String(Level.Multiplier) + " BONUS";
        }else{
            MultiplierValue_Label.text = "";
        }
    }
}