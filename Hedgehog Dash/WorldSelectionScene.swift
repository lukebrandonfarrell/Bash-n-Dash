//
//  WorldSelectionScene.swift
//  Hedgehog Dash
//
//  Created by Luke on 3/29/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class WorldSelectionScene:SKScene
{
    var cardworld_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Locked_WorldCardboard());
    var woodworld_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Locked_WorldWooden());
    var overgrown_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Locked_WorldOvergrown());
    var iceworld_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Locked_WorldIce());
    var techworld_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Locked_WorldHighTech());
    var hauntedworld_icon:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Locked_WorldHaunted());
    
    var back_btn:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_Back0001());
    
    var title:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Title_WorldSelection());
    
    let cardworld_levels:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let woodworld_levels:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let overgrown_levels:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let iceworld_levels:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let techworld_levels:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let hauntedworld_levels:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
    override init(size: CGSize)
    {
        super.init(size: size);
        let Background = SKSpriteNode(imageNamed: "BG_Menu");
        Background.size = CGSize(width: self.size.width+10, height: self.size.height+5);
        Background.position = CGPoint(x: (self.size.width/2)-2, y: (self.size.height/2));
        addChild(Background);
        
        cardworld_icon.setScale(Game.scale_value * 0.5);
        woodworld_icon.setScale(Game.scale_value * 0.5);
        overgrown_icon.setScale(Game.scale_value * 0.5);
        iceworld_icon.setScale(Game.scale_value * 0.5);
        techworld_icon.setScale(Game.scale_value * 0.5);
        hauntedworld_icon.setScale(Game.scale_value * 0.5);
        
        back_btn.setScale(Game.scale_value * 0.7);
        title.setScale(Game.scale_value);
        
        cardworld_icon.position = CGPoint(x: self.size.width - self.size.width/1.2, y: self.size.height/1.6);
        woodworld_icon.position = CGPoint(x: self.size.width/2, y: self.size.height/1.6);
        overgrown_icon.position = CGPoint(x: self.size.width/1.2, y: self.size.height/1.6);
        iceworld_icon.position = CGPoint(x: self.size.width - self.size.width/1.2, y: self.size.height - self.size.height/1.4);
        techworld_icon.position = CGPoint(x: self.size.width/2, y: self.size.height - self.size.height/1.4);
        hauntedworld_icon.position = CGPoint(x: self.size.width/1.2, y: self.size.height - self.size.height/1.4)
        
        back_btn.position = CGPoint(x: back_btn.size.width/1.5, y: back_btn.size.height/1.5);
        title.position = CGPoint(x: self.size.width/2, y: self.size.height - title.size.height/1.6);
        
        cardworld_levels.position = CGPoint(x: self.size.width - self.size.width/1.2, y: (self.size.height/1.6) - cardworld_icon.size.height/1.4);
        woodworld_levels.position = CGPoint(x: self.size.width/2, y: (self.size.height/1.6) - woodworld_icon.size.height/1.4);
        overgrown_levels.position = CGPoint(x: self.size.width/1.2, y: (self.size.height/1.6) - overgrown_icon.size.height/1.6);
        iceworld_levels.position = CGPoint(x: self.size.width - self.size.width/1.2, y: self.size.height - (self.size.height/1.4) - iceworld_icon.size.height/1.4);
        techworld_levels.position = CGPoint(x: self.size.width/2, y: self.size.height - (self.size.height/1.4) - techworld_icon.size.height/1.4);
        hauntedworld_levels.position = CGPoint(x: self.size.width/1.2, y: self.size.height - (self.size.height/1.4) - hauntedworld_icon.size.height/1.4)
        
        cardworld_levels.fontSize = 22 * Game.scale_value
        cardworld_levels.fontColor = SKColor.whiteColor()
        woodworld_levels.fontSize = 22 * Game.scale_value
        woodworld_levels.fontColor = SKColor.whiteColor()
        overgrown_levels.fontSize = 22 * Game.scale_value
        overgrown_levels.fontColor = SKColor.whiteColor()
        iceworld_levels.fontSize = 22 * Game.scale_value
        iceworld_levels.fontColor = SKColor.whiteColor()
        techworld_levels.fontSize = 22 * Game.scale_value
        techworld_levels.fontColor = SKColor.whiteColor()
        hauntedworld_levels.fontSize = 22 * Game.scale_value
        hauntedworld_levels.fontColor = SKColor.whiteColor()
        
        cardworld_icon.name = "cardworld_icon";
        woodworld_icon.name = "woodworld_icon";
        overgrown_icon.name = "overgrown_icon";
        iceworld_icon.name = "iceworld_icon";
        techworld_icon.name = "techworld_icon";
        hauntedworld_icon.name = "hauntedworld_icon";
        
        back_btn.name = "back_btn";

        cardworld_levels.text = "0/15";
        woodworld_levels.text = "0/30";
        overgrown_levels.text = "0/30";
        iceworld_levels.text = "0/60";
        techworld_levels.text = "0/60";
        hauntedworld_levels.text = "0/60";
        
        addChild(cardworld_icon);
        addChild(woodworld_icon);
        addChild(overgrown_icon);
        addChild(iceworld_icon);
        addChild(techworld_icon);
        addChild(hauntedworld_icon);
        
        addChild(back_btn);
        addChild(title);
        
        addChild(cardworld_levels);
        addChild(woodworld_levels);
        addChild(overgrown_levels);
        addChild(iceworld_levels);
        addChild(techworld_levels);
        addChild(hauntedworld_levels);
        
        if(Level.levelsunlocked[0][0] == 0){
            cardworld_icon.texture = Textures.GUI_sheet.Locked_WorldCardboard()
        }else{
            cardworld_icon.texture = Textures.GUI_sheet.World_Cardboard()
        }

        if(Level.levelsunlocked[1][0] == 0){
            woodworld_icon.texture = Textures.GUI_sheet.Locked_WorldWooden()
        }else{
            woodworld_icon.texture = Textures.GUI_sheet.World_Wooden()
        }

        if(Level.levelsunlocked[2][0] == 0){
            overgrown_icon.texture = Textures.GUI_sheet.Locked_WorldOvergrown()
        }else{
            overgrown_icon.texture = Textures.GUI_sheet.World_Overgrown()
        }

        if(Level.levelsunlocked[3][0] == 0){
            iceworld_icon.texture = Textures.GUI_sheet.Locked_WorldIce()
        }else{
            iceworld_icon.texture = Textures.GUI_sheet.World_Ice()
        }

        if(Level.levelsunlocked[4][0] == 0){
            techworld_icon.texture = Textures.GUI_sheet.Locked_WorldHighTech()
        }else{
            techworld_icon.texture = Textures.GUI_sheet.World_HighTech()
        }

        if(Level.levelsunlocked[5][0] == 0){
            hauntedworld_icon.texture = Textures.GUI_sheet.Locked_WorldHaunted()
        }else{
            hauntedworld_icon.texture = Textures.GUI_sheet.World_Haunted()
        }

        print(self.size.width);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView)
    {
        //Reset Scene
        back_btn.texture = Textures.GUI_sheet.Button_Back0001();
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
        }
        
        /* Called when a touch begins */
        if(node.name == "back_btn")
        {
            back_btn.texture = Textures.GUI_sheet.Button_Back0002();
            Scenes.skView.presentScene(Scenes.GAME_MENU_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: NSTimeInterval(1.0)));
        }
        if(node.name == "cardworld_icon")
        {
            if(Level.levelsunlocked[0][0] == 0){
                //Locked (Unlock if avalible)
            }else{
                Level.world = 0;
                Level.level = 0;
                Scenes.skView.presentScene(Scenes.LEVEL_SELECTION_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
            }
        }

        if(node.name == "woodworld_icon")
        {
            if(Level.levelsunlocked[1][0] == 0){
                //Locked (Unlock if avalible)
            }else{
                Level.world = 1;
                Level.level = 0;
                Scenes.skView.presentScene(Scenes.LEVEL_SELECTION_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
            }
        }
        
        if(node.name == "overgrown_icon")
        {
            if(Level.levelsunlocked[2][0] == 0){
                //Locked (Unlock if avalible)
            }else{
                Level.world = 2;
                Level.level = 0;
                Scenes.skView.presentScene(Scenes.LEVEL_SELECTION_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
            }
        }

        if(node.name == "iceworld_icon")
        {
            if(Level.levelsunlocked[3][0] == 0){
                //Locked (Unlock if avalible)
            }else{
                Level.world = 3;
                Level.level = 0;
                Scenes.skView.presentScene(Scenes.LEVEL_SELECTION_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
            }
        }

        if(node.name == "techworld_icon")
        {
            if(Level.levelsunlocked[4][0] == 0){
                //Locked (Unlock if avalible)
            }else{
                Level.world = 4;
                Level.level = 0;
                Scenes.skView.presentScene(Scenes.LEVEL_SELECTION_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
            }
        }

        if(node.name == "hauntedworld_icon")
        {
            if(Level.levelsunlocked[5][0] == 0){
                //Locked (Unlock if avalible)
            }else{
                Level.world = 5;
                Level.level = 0;
                Scenes.skView.presentScene(Scenes.LEVEL_SELECTION_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
            }
        }
    }
}