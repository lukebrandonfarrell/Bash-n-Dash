//
//  GameMenuScene.swift
//  Hedgehog Dash
//
//  Created by Luke on 3/29/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class GameMenuScene : SKScene {
    
    var storymode_btn:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_StoryMode0001());
    var endless_btn:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_EndlessMode0001());
    var objectives_btn:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_Objectives0001());
    var shop_btn:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_Shop0001());
    
    var settings_btn:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_Settings());
    
    var UnlockAtLevel_1:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular");
    var UnlockAtLevel_2:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular");
    var UnlockAtLevel_3:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular");
    
    //Main GUI
    let Icon_Diamond = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Diamond())
    let Ammount_Diamond:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
    //Overlay
    let crop:SKCropNode = SKCropNode();
    var faded_background:SKSpriteNode!;
    
    var faded_rectangled:SKSpriteNode!;
    var tutorialpopup:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.TutorialScreen0001());
    var clearSection:SKSpriteNode!;
    
    var tutorialtext_line1:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular");
    var tutorialtext_line2:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular");
    var tutorialtext_line3:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular");
    var tutorialtext_line4:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular");
    
    var taptoproceed:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular");
    
    var isTutorial:Bool = false;
    var tutorialCount:Int = 0;
    
    override init(size: CGSize)
    {
        super.init(size: size);
        Game.scale_value = self.size.width/800;
        
        let Background = SKSpriteNode(imageNamed: "BG_Menu");
        Background.size = CGSize(width: self.size.width+10, height: self.size.height+5);
        Background.position = CGPoint(x: (self.size.width/2)-2, y: (self.size.height/2));
        addChild(Background);
        
        storymode_btn.setScale(Game.scale_value);
        endless_btn.setScale(Game.scale_value);
        objectives_btn.setScale(Game.scale_value);
        shop_btn.setScale(Game.scale_value);
        
        settings_btn.setScale(Game.scale_value);
        
        storymode_btn.position = CGPoint(x: storymode_btn.size.width * 1.3 , y: size.height/2);
        endless_btn.position = CGPoint(x: size.width - storymode_btn.size.width * 1.3, y: size.height/2);
        objectives_btn.position = CGPoint(x: storymode_btn.size.width * 1.3, y: storymode_btn.position.y - objectives_btn.size.height * 1.5);
        shop_btn.position = CGPoint(x: size.width - storymode_btn.size.width * 1.3, y: endless_btn.position.y - shop_btn.size.height * 1.5);
        
        settings_btn.position = CGPoint(x: size.width - settings_btn.size.width/1.5, y: size.height - settings_btn.size.height/1.5);
        
        //Unlock at X text
        UnlockAtLevel_1.fontSize = 14 * Game.scale_value
        UnlockAtLevel_1.fontColor = SKColor.whiteColor()
        UnlockAtLevel_1.position = CGPoint(x: endless_btn.position.x, y: endless_btn.position.y - endless_btn.size.height/1.4)
        UnlockAtLevel_1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        UnlockAtLevel_1.text = "Unlocks at Level 3";
        UnlockAtLevel_1.zPosition = 2;
        addChild(UnlockAtLevel_1);
        
        UnlockAtLevel_2.fontSize = 14 * Game.scale_value
        UnlockAtLevel_2.fontColor = SKColor.whiteColor()
        UnlockAtLevel_2.position = CGPoint(x: objectives_btn.position.x, y: objectives_btn.position.y - objectives_btn.size.height/1.4)
        UnlockAtLevel_2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        UnlockAtLevel_2.text = "Unlocks at Level 3";
        UnlockAtLevel_2.zPosition = 2;
        addChild(UnlockAtLevel_2);

        UnlockAtLevel_3.fontSize = 14 * Game.scale_value
        UnlockAtLevel_3.fontColor = SKColor.whiteColor()
        UnlockAtLevel_3.position = CGPoint(x: shop_btn.position.x, y: shop_btn.position.y - shop_btn.size.height/1.4)
        UnlockAtLevel_3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        UnlockAtLevel_3.text = "Unlocks at Level 3";
        UnlockAtLevel_3.zPosition = 2;
        addChild(UnlockAtLevel_3);

        
        //Set Names
        storymode_btn.name = "storymode_btn";
        endless_btn.name = "endless_btn";
        objectives_btn.name = "objectives_btn";
        shop_btn.name = "shop_btn";
        
        addChild(storymode_btn);
        addChild(endless_btn);
        addChild(objectives_btn);
        addChild(shop_btn);
        
        addChild(settings_btn);
        
        //Main GUI
        Icon_Diamond.setScale(Game.scale_value);
        Icon_Diamond.position = CGPoint(x: Icon_Diamond.size.width, y: size.height-Icon_Diamond.size.height)
        Icon_Diamond.zPosition = 2;
        addChild(Icon_Diamond)
        
        Ammount_Diamond.fontSize = 22 * Game.scale_value
        Ammount_Diamond.fontColor = SKColor.whiteColor()
        Ammount_Diamond.position = CGPoint(x: Icon_Diamond.size.width * 1.8, y: size.height-(Icon_Diamond.size.height*1.2))
        Ammount_Diamond.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        Ammount_Diamond.text = String(Currency.Diamonds);
        Ammount_Diamond.zPosition = 2;
        addChild(Ammount_Diamond);
        
        
        //Overlay
        faded_background = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: self.size.width, height: self.size.height))
        faded_background.position = CGPoint(x: self.size.width/2, y: self.size.height/2);
        faded_background.alpha = 0.8;
        faded_background.zPosition = 9;
        //faded_background.blendMode = SKBlendMode.Subtract;
        addChild(faded_background);
        
        faded_rectangled = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: self.size.width, height: self.size.height))
        faded_rectangled.alpha = 0.1;
        faded_rectangled.blendMode = SKBlendMode.Screen;
        
        clearSection = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: self.size.width/2, height: self.size.height))
        clearSection.alpha = 0.8;
        
        crop.addChild(faded_rectangled);
        crop.maskNode = clearSection;
        crop.position = CGPoint(x: self.size.width/2, y: self.size.height/2);
        crop.zPosition = 0;
        addChild(crop);
        
        tutorialpopup.position = CGPoint(x: self.size.width/2, y: self.size.height/2);
        tutorialpopup.zPosition = 0;
        tutorialpopup.setScale(Game.scale_value);
        addChild(tutorialpopup);
        
        tutorialtext_line1.zPosition = 0;
        tutorialtext_line1.fontSize = 20 * Game.scale_value
        tutorialtext_line1.fontColor = SKColor.whiteColor()
        tutorialtext_line1.position = CGPoint(x: (self.size.width/2) - tutorialpopup.size.width/2.4, y: (self.size.height/2) + tutorialpopup.size.height/3.5);
        tutorialtext_line1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        addChild(tutorialtext_line1);
        
        tutorialtext_line2.zPosition = 0;
        tutorialtext_line2.fontSize = 20 * Game.scale_value
        tutorialtext_line2.fontColor = SKColor.whiteColor()
        tutorialtext_line2.text = "Demo";
        tutorialtext_line2.position = CGPoint(x: (self.size.width/2) - tutorialpopup.size.width/2.4, y: tutorialtext_line1.position.y - tutorialtext_line2.frame.height * 1.4);
        tutorialtext_line2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        addChild(tutorialtext_line2);
        
        tutorialtext_line3.zPosition = 0;
        tutorialtext_line3.fontSize = 20 * Game.scale_value
        tutorialtext_line3.fontColor = SKColor.whiteColor()
        tutorialtext_line3.text = "Demo";
        tutorialtext_line3.position = CGPoint(x: (self.size.width/2) - tutorialpopup.size.width/2.4, y: tutorialtext_line2.position.y - tutorialtext_line3.frame.height * 1.4);
        tutorialtext_line3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        addChild(tutorialtext_line3);
        
        tutorialtext_line4.zPosition = 0;
        tutorialtext_line4.fontSize = 20 * Game.scale_value
        tutorialtext_line4.fontColor = SKColor.whiteColor()
        tutorialtext_line4.text = "Demo";
        tutorialtext_line4.position = CGPoint(x: (self.size.width/2) - tutorialpopup.size.width/2.4, y: tutorialtext_line3.position.y - tutorialtext_line4.frame.height * 1.4);
        tutorialtext_line4.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        addChild(tutorialtext_line4);
        
        taptoproceed.zPosition = 0;
        taptoproceed.alpha = 0;
        taptoproceed.fontSize = 25 * Game.scale_value
        taptoproceed.fontColor = SKColor.whiteColor()
        taptoproceed.text = "Tap to Continue";
        taptoproceed.position = CGPoint(x: tutorialpopup.position.x, y: taptoproceed.frame.height * 2);
        taptoproceed.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        addChild(taptoproceed);
        
        TutorialActive();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToView(view: SKView) {
        //Reset Scene
        storymode_btn.texture = Textures.GUI_sheet.Button_StoryMode0001();
        endless_btn.texture = Textures.GUI_sheet.Button_EndlessMode0001();
        objectives_btn.texture = Textures.GUI_sheet.Button_Objectives0001();
        shop_btn.texture = Textures.GUI_sheet.Button_Shop0001();

        
        if(Currency.PlayerLevel < 3){
            endless_btn.texture = Textures.GUI_sheet.Button_EndlessMode0003();
            objectives_btn.texture = Textures.GUI_sheet.Button_Objectives0003();
            shop_btn.texture = Textures.GUI_sheet.Button_Shop0003();
        }else{
            UnlockAtLevel_1.text = "";
            UnlockAtLevel_2.text = "";
            UnlockAtLevel_3.text = "";
        }
        
        //Setup and add level bar to scene
        if(!Game.levelbar.isSetup){
            Game.levelbar.SetUp();
        }
        
        if(Game.levelbar.isAddedToScene){
            Game.levelbar.removeFromParent();
            Game.levelbar.isAddedToScene = false;
        }
        addChild(Game.levelbar)
        Game.levelbar.isAddedToScene = true;
       // Game.levelbar.setScale(Game.scale_value);
        Game.levelbar.position = CGPoint(x: size.width/2, y: size.height - size.height/4);
        
        Scenes.audio.playMusic("MenuMusic");
    }
    
    func TutorialActive(){
        isTutorial = true;
        
        if(tutorialCount == 0){
            faded_rectangled.zPosition = 10;
            
            tutorialpopup.zPosition = 10;
            
            tutorialtext_line1.zPosition = 10;
            tutorialtext_line1.text = "Hey there!";
            
            tutorialtext_line2.zPosition = 10;
            tutorialtext_line2.text = "I've been waiting for you...";
            
            tutorialtext_line3.zPosition = 10;
            tutorialtext_line3.text = "We have a lot to do.";
            
            tutorialtext_line4.zPosition = 10;
            tutorialtext_line4.text = "Lets take you on a quick tour";
            
            taptoproceed.zPosition = 10;
            let taptoproceed_sequence = [SKAction.fadeInWithDuration(NSTimeInterval(1.5)), SKAction.fadeOutWithDuration(NSTimeInterval(1.5))];
            taptoproceed.runAction(SKAction.repeatActionForever(SKAction.sequence(taptoproceed_sequence)));
        }
        else if(tutorialCount == 1)
        {
            tutorialpopup.zPosition = -1;
            
            crop.zPosition = 9;
            crop.position.x = Icon_Diamond.frame.maxX;
            crop.position.y = Icon_Diamond.frame.midY;
            
            clearSection.size.width = Icon_Diamond.frame.size.width * 2;
            clearSection.size.height = Icon_Diamond.frame.height * 1.5;
        }
        else if(tutorialCount == 2)
        {
            crop.position = Game.levelbar.position;
            clearSection.size.width = Game.levelbar.levelbar_empty.size.width * 1.2;
            clearSection.size.height = Game.levelbar.thumbnail.size.height;
        }
        else if(tutorialCount == 3)
        {
            
        }
        else if(tutorialCount == 4)
        {
            
        }
        else if(tutorialCount == 5)
        {
            faded_background.zPosition = -1;
            faded_rectangled.zPosition = -1;
            clearSection.zPosition = -1;
            crop.zPosition = -1;
            
            tutorialpopup.zPosition = -1;
            
            tutorialtext_line1.zPosition = -1;
            tutorialtext_line2.zPosition = -1;
            tutorialtext_line3.zPosition = -1;
            tutorialtext_line4.zPosition = -1;
            
            taptoproceed.zPosition = -1;

        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
        }

        if(node.name == "storymode_btn")
        {
            storymode_btn.texture = Textures.GUI_sheet.Button_StoryMode0002();
            Scenes.skView.presentScene(Scenes.WORLD_MENU_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
            Scenes.audio.playSound("button_press");
        }
        
        if(node.name == "endless_btn")
        {
            if(Currency.PlayerLevel >= 3){
                endless_btn.texture = Textures.GUI_sheet.Button_EndlessMode0002();
                Scenes.skView.presentScene(Scenes.GAME_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: NSTimeInterval(1.0)));
                Scenes.audio.playSound("button_press");
            }
        }

        if(node.name == "objectives_btn")
        {
            if(Currency.PlayerLevel >= 3){
                objectives_btn.texture = Textures.GUI_sheet.Button_Objectives0002();
                Scenes.audio.playSound("button_press");
            }
        }

        if(node.name == "shop_btn")
        {
            if(Currency.PlayerLevel >= 3){
                shop_btn.texture = Textures.GUI_sheet.Button_Shop0002();
                Scenes.audio.playSound("button_press");
            }
        }
        
        if(isTutorial){
            tutorialCount++;
            TutorialActive();
        }
    }
}