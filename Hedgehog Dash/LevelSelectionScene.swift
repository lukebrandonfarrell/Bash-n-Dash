//
//  LevelSelectionScene.swift
//  Hedgehog Dash
//
//  Created by Luke on 3/29/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class LevelSelectionScene : SKScene {
    
    var title:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Title_WorldSelection());
    var back_btn:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_Back0001());
    
    let level_1:SKSpriteNode = SKSpriteNode();
    let level_2:SKSpriteNode = SKSpriteNode();
    
    var box_1:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Locked_WorldCardboard());
    var box_2:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Locked_WorldCardboard());
    
    let stick_1:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Branch_Golden());
    let stick_2:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Branch_Golden());
    let stick_3:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Branch_Golden());
    
    let stick_1_2:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Branch_Golden());
    let stick_2_2:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Branch_Golden());
    let stick_3_2:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Branch_Golden());
    
    let box_1_score:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let box_2_score:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")

    let box_1_level:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let box_2_level:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
    let playbtn_1:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_Play0001())

    var slideing:Bool = false;
    var currentLevel:Int = 0;
    var ActiveLevelGraphic:String = "Level_1";
    
    //GUI
    let Icon_Diamond = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Diamond())
    let Icon_Key = SKSpriteNode(texture: Textures.GUI_sheet.Branch_Normal())
    
    let Ammount_Diamond:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    let Ammount_Key:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")

    override init(size: CGSize)
    {
        super.init(size: size);
        
        //GUI
        
        Ammount_Diamond.zPosition = 1;
        Ammount_Diamond.fontSize = 22 * Game.scale_value
        Ammount_Diamond.fontColor = SKColor.whiteColor()
        Ammount_Diamond.position = CGPoint(x: 90, y: size.height-50)
        Ammount_Diamond.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        Ammount_Diamond.text = String(Currency.Diamonds);
        addChild(Ammount_Diamond);
        
        Ammount_Key.zPosition = 1;
        Ammount_Key.fontSize = 22 * Game.scale_value
        Ammount_Key.fontColor = SKColor.whiteColor()
        Ammount_Key.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        Ammount_Key.text = String(Currency.Keys);
        Ammount_Key.position.y = size.height-45;
        addChild(Ammount_Key);
        
        Icon_Diamond.position = CGPoint(x: 50, y: size.height-45)
        Icon_Diamond.setScale(Game.scale_value);
        Icon_Diamond.zPosition = 1;
        addChild(Icon_Diamond)
        
        Icon_Key.position = CGPoint(x: 140 + Ammount_Diamond.frame.width, y: size.height-45)
        Icon_Key.setScale(Game.scale_value * 0.2);
        Icon_Key.zPosition = 1;
        addChild(Icon_Key);
        
        Ammount_Key.position.x = Icon_Key.position.x + 44;

        
        //Background
        let Background = SKSpriteNode(imageNamed: "BG_Menu");
        Background.size = CGSize(width: self.size.width+10, height: self.size.height+5);
        Background.position = CGPoint(x: (self.size.width/2)-2, y: (self.size.height/2));
        addChild(Background);
        
        //Scene
        box_1.setScale(Game.scale_value * 0.7);
        box_1.position = CGPoint(x: self.size.width/2, y: self.size.height/1.4);
        level_1.addChild(box_1);
        
        box_2.setScale(Game.scale_value * 0.7);
        box_2.position = CGPoint(x: self.size.width/2, y: self.size.height/1.4);
        level_2.addChild(box_2);
        
        back_btn.setScale(Game.scale_value * 0.7);
        back_btn.position = CGPoint(x: back_btn.size.width/1.5, y: back_btn.size.height/1.5);
        back_btn.name = "back_btn";
        back_btn.zPosition = 2;
        addChild(back_btn);
        
        
        stick_1.setScale(Game.scale_value * 0.25);
        stick_1.position = CGPoint(x: (self.size.width/2) - stick_1.size.width * 1.3, y: self.size.height/2.8);
        level_1.addChild(stick_1);
        
        
        stick_2.setScale(Game.scale_value * 0.25);
        stick_2.position = CGPoint(x: (self.size.width/2), y: self.size.height/2.8);
        level_1.addChild(stick_2);
        
        
        stick_3.setScale(Game.scale_value * 0.25);
        stick_3.position = CGPoint(x: (self.size.width/2) + stick_1.size.width * 1.3, y: self.size.height/2.8);
        level_1.addChild(stick_3);

        stick_1_2.setScale(Game.scale_value * 0.25);
        stick_1_2.position = CGPoint(x: (self.size.width/2) - stick_1.size.width * 1.3, y: self.size.height/2.8);
        level_2.addChild(stick_1_2);
        
        
        stick_2_2.setScale(Game.scale_value * 0.25);
        stick_2_2.position = CGPoint(x: (self.size.width/2), y: self.size.height/2.8);
        level_2.addChild(stick_2_2);
        
        
        stick_3_2.setScale(Game.scale_value * 0.25);
        stick_3_2.position = CGPoint(x: (self.size.width/2) + stick_3_2.size.width * 1.3, y: self.size.height/2.8);
        level_2.addChild(stick_3_2);
        
        box_1_level.position = CGPoint(x: self.size.width/2, y: (self.size.height/1.6) - box_1.size.height/2.2);
        box_1_level.fontSize = 22 * Game.scale_value
        box_1_level.fontColor = SKColor.whiteColor()
        level_1.addChild(box_1_level);
        
        box_2_level.position = CGPoint(x: self.size.width/2, y: (self.size.height/1.6) - box_2.size.height/2.2);
        box_2_level.fontSize = 22 * Game.scale_value
        box_2_level.fontColor = SKColor.whiteColor()
        level_2.addChild(box_2_level);

        box_1_score.position = CGPoint(x: self.size.width/2, y: self.size.height/4.4);
        box_1_score.fontSize = 22 * Game.scale_value
        box_1_score.fontColor = SKColor.whiteColor()
        box_1_score.text = "0/3";
        level_1.addChild(box_1_score);

        box_2_score.position = CGPoint(x: self.size.width/2, y: self.size.height/4.4);
        box_2_score.fontSize = 22 * Game.scale_value
        box_2_score.fontColor = SKColor.whiteColor()
        box_2_score.text = "0/3";
        level_2.addChild(box_2_score);

        playbtn_1.setScale(Game.scale_value * 0.7);
        playbtn_1.position = CGPoint(x: self.size.width - playbtn_1.size.width/1.5, y: playbtn_1.size.height/1.5);
        playbtn_1.name = "Play";
        addChild(playbtn_1);

        addChild(level_1);
        
        level_2.position = CGPoint(x: self.size.width + level_2.size.width, y: 0);
        addChild(level_2);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        LoadBox();
        back_btn.texture = Textures.GUI_sheet.Button_Back0001();
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
        }
        
        if(node.name == "back_btn")
        {
            back_btn.texture = Textures.GUI_sheet.Button_Back0002();
            Scenes.skView.presentScene(Scenes.WORLD_MENU_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: NSTimeInterval(1.0)));
        }
        
        if(node.name == "Play")
        {
            if(Level.levelsunlocked[Level.world][currentLevel] == 1)
            {
                playbtn_1.texture = Textures.GUI_sheet.Button_Play0002();
                Scenes.skView.presentScene(Scenes.GAME_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
            }
        }
    }
    
    override func  touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.count > 0 {
            let touch: UITouch = (touches.first as UITouch?)!
            let position: CGPoint = touch.locationInView(self.view)
            let prevposition: CGPoint = touch.previousLocationInView(self.view);
            
            if(level_1.actionForKey("Slide") == nil)
            {
                slideing = false;
            }
            
            if(!slideing)
            {
                if (position.x > prevposition.x * 1.05)
                {
                    //finger touch went right

                    slideing = true;
                    if(currentLevel > 0)
                    {
                        currentLevel--;
                        
                        if(ActiveLevelGraphic == "Level_1")
                        {
                            level_2.position = CGPoint(x: -self.size.width, y: 0);
                            
                            let l_1_action:SKAction = SKAction.moveToX(self.size.width + level_1.size.width, duration: NSTimeInterval(0.5))
                            l_1_action.timingMode = SKActionTimingMode.EaseOut
                            level_1.runAction(l_1_action, withKey: "Slide");
                            
                            let l_2_action:SKAction = SKAction.moveToX(0, duration: NSTimeInterval(0.5));
                            l_2_action.timingMode = SKActionTimingMode.EaseOut;
                            level_2.runAction(l_2_action);
                            
                            ActiveLevelGraphic = "Level_2";
                        }
                        else if(ActiveLevelGraphic == "Level_2")
                        {
                            level_1.position = CGPoint(x: -self.size.width, y: 0);
                            
                            let l_1_action:SKAction = SKAction.moveToX(0, duration: NSTimeInterval(0.5))
                            l_1_action.timingMode = SKActionTimingMode.EaseOut;
                            level_1.runAction(l_1_action, withKey: "Slide")
                            
                            let l_2_action:SKAction = SKAction.moveToX(self.size.width + level_2.size.width, duration: NSTimeInterval(0.5));
                            l_2_action.timingMode = SKActionTimingMode.EaseOut;
                            level_2.runAction(l_2_action)
                            ActiveLevelGraphic = "Level_1";
                        }
                        LoadBox()
                    }
                } else if (position.x * 1.05 < prevposition.x){
                    //finger touch went left
                    
                    slideing = true;
                    if(currentLevel < Level.levelscompleted[Level.world].count - 1)
                    {
                        currentLevel++;
                        
                        if(ActiveLevelGraphic == "Level_1")
                        {
                            level_2.position = CGPoint(x: self.size.width + level_2.size.width, y: 0);

                            let l_1_action:SKAction = SKAction.moveToX(-self.size.width, duration: NSTimeInterval(0.5))
                            l_1_action.timingMode = SKActionTimingMode.EaseOut;
                            level_1.runAction(l_1_action, withKey: "Slide")
                            
                            let l_2_action:SKAction = SKAction.moveToX(0, duration: NSTimeInterval(0.5));
                            l_2_action.timingMode = SKActionTimingMode.EaseOut;
                            level_2.runAction(l_2_action)
                            ActiveLevelGraphic = "Level_2";
                        }
                        else if(ActiveLevelGraphic == "Level_2")
                        {
                            level_1.position = CGPoint(x: self.size.width + level_1.size.width, y: 0);
                            
                            let l_1_action:SKAction = SKAction.moveToX(0, duration: NSTimeInterval(0.5))
                            l_1_action.timingMode = SKActionTimingMode.EaseOut;
                            level_1.runAction(l_1_action, withKey: "Slide")
                            
                            let l_2_action:SKAction = SKAction.moveToX(-self.size.width, duration: NSTimeInterval(0.5));
                            l_2_action.timingMode = SKActionTimingMode.EaseOut;
                            level_2.runAction(l_2_action)
                            ActiveLevelGraphic = "Level_1";
                        }
                        LoadBox()
                    }
                }
            }
        }
    }
    
    func LoadBox()
    {
        if(ActiveLevelGraphic == "Level_1")
        {
            if(Level.levelsunlocked[Level.world][currentLevel] == 0)
            {
                box_1.texture = Textures.GUI_sheet.Locked_Worlds()[Level.world];
                playbtn_1.texture = Textures.GUI_sheet.Button_Unlock0003();
            }
            else
            {
                box_1.texture = Textures.GUI_sheet.Unlocked_Worlds()[Level.world];
                playbtn_1.texture = Textures.GUI_sheet.Button_Play0001();
            }
            box_1_level.text = "Level - " + String(currentLevel + 1);
        }
        else if(ActiveLevelGraphic == "Level_2")
        {
            if(Level.levelsunlocked[Level.world][currentLevel] == 0)
            {
                box_2.texture = Textures.GUI_sheet.Locked_Worlds()[Level.world];
                playbtn_1.texture = Textures.GUI_sheet.Button_Unlock0003();
            }
            else
            {
                box_2.texture = Textures.GUI_sheet.Unlocked_Worlds()[Level.world];
                playbtn_1.texture = Textures.GUI_sheet.Button_Play0001();
            }
            box_2_level.text = "Level - " + String(currentLevel + 1);
        }
    }
}