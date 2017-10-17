//
//  Hole.swift
//  Hedgehog Dash
//
//  Created by Luke on 2/19/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class Hole : Enemy {
    
    var state:Int = 0; //0 = Epmpty //1 = Hedge, //2 = Wolf
    
    var hit:Bool = false; //Has Target been hit
    var PopTime:CGFloat = 8; //Amount of time enmy pops up for
    
    var UnPop_sequence:SKAction!; //SK sequence for unpopping a enemy
    var pop_timer:NSTimer!;
    
    let Multiplier_Label:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
    func Setup()
    {
        self.texture = Textures.Hole_sheet.Hole_Empty();
        pop_timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("Pop"), userInfo: nil, repeats: true)
        
        Multiplier_Label.fontColor = UIColor.whiteColor();
        Multiplier_Label.alpha = 0.0;
        Multiplier_Label.position = CGPoint(x: 0, y: Multiplier_Label.frame.height/2)
        Multiplier_Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        Multiplier_Label.zPosition = 2;
        addChild(Multiplier_Label);
    }
    
    func Pop()
    {
        var PopUpChance:Int = 40;
        if(Game.Score <= 25){PopUpChance -= Game.Score;}
        let popupChance = random() % PopUpChance;
        
        if(state == 0)
        {
            Multiplier_Label.alpha = 0.0;
            Multiplier_Label.position = CGPoint(x: 0, y: Multiplier_Label.frame.height/2)
            
            if(popupChance < 4)
            {
                let popup_animation = SKAction.animateWithTextures(Textures.Hole_sheet.HedgehogHole_Pop(), timePerFrame: NSTimeInterval(0.033 * animSpeed));
                self.runAction(popup_animation)
                
                state = 1;
                hit = false;
                self.physicsBody?.categoryBitMask = PhysicsCategory.col_hole;
                unPop();
            }
            else if(popupChance == 5)
            {
                let popup_animation = SKAction.animateWithTextures(Textures.Hole_sheet.WolfHole_Pop(), timePerFrame: NSTimeInterval(0.033 * animSpeed));
                self.runAction(popup_animation)
                
                state = 2;
                hit = false;
                self.physicsBody?.categoryBitMask = PhysicsCategory.col_hole;
                unPop();
            }
        }
    }
    
    func unPop()
    {
        let wait:SKAction = SKAction.waitForDuration(NSTimeInterval(PopTime * animSpeed));
        let block:SKAction = SKAction.runBlock { () -> Void in
            var popupdown_animation:SKAction = SKAction.animateWithTextures(Textures.Hole_sheet.HedgehogHole_PopDown(), timePerFrame: NSTimeInterval(0.033 * self.animSpeed));
            
            if(self.state == 1)
            {
                popupdown_animation = SKAction.animateWithTextures(Textures.Hole_sheet.HedgehogHole_PopDown(), timePerFrame: NSTimeInterval(0.033 * self.animSpeed));
            }else if(self.state == 2){
                popupdown_animation = SKAction.animateWithTextures(Textures.Hole_sheet.WolfHole_PopDown(), timePerFrame: NSTimeInterval(0.033 * self.animSpeed));
            }
            
            self.runAction(popupdown_animation)
            self.state = 0;
            self.physicsBody?.categoryBitMask = 0;
            
            
            if(!self.hit){
                Game.player.RemoveMultiplierBuffs();
            }
        }
        
        let sequence = [wait, block];
        
        UnPop_sequence = SKAction.sequence(sequence);
        self.runAction(UnPop_sequence, withKey: "UNPOP")
    }
    
    func Hurt()
    {
        var hurt_animation:SKAction = SKAction.repeatAction(SKAction.animateWithTextures(Textures.Hole_sheet.HedgehogHole_Dizzy(), timePerFrame: NSTimeInterval(0.033 * animSpeed)), count: 1);
        var hurt_down:SKAction = SKAction.animateWithTextures(Textures.Hole_sheet.HedgehogHole_PopDown(), timePerFrame: NSTimeInterval(0.033 * animSpeed));
        
        if(state == 1)
        {
            hurt_animation = SKAction.repeatAction(SKAction.animateWithTextures(Textures.Hole_sheet.HedgehogHole_Dizzy(), timePerFrame: NSTimeInterval(0.033 * animSpeed)), count: 1);
            hurt_down = SKAction.animateWithTextures(Textures.Hole_sheet.HedgehogHole_PopDown(), timePerFrame: NSTimeInterval(0.033 * animSpeed));
        }else if(state == 2){
            hurt_animation = SKAction.repeatAction(SKAction.animateWithTextures(Textures.Hole_sheet.WolfHole_Dizzy(), timePerFrame: NSTimeInterval(0.033 * animSpeed)), count: 1);
            hurt_down = SKAction.animateWithTextures(Textures.Hole_sheet.WolfHole_PopDown(), timePerFrame: NSTimeInterval(0.033 * animSpeed));
        }
        
        let block:SKAction = SKAction.runBlock { () -> Void in self.state = 0; self.physicsBody?.categoryBitMask = 0;}
        let hurt_sequence = [hurt_animation, hurt_down, block];
        
        self.removeActionForKey("UNPOP");
        self.runAction(SKAction.sequence(hurt_sequence))
        
        //Score Multiplier PopUp
        Level.Multiplier++;
        
        if(Level.Multiplier > 1){
            if(Level.Multiplier < 20){
                Multiplier_Label.fontSize = (20 + Level.Multiplier) * Game.scale_value;
                Multiplier_Label.fontColor = UIColor.whiteColor();
            }else{
                Multiplier_Label.fontColor = UIColor.orangeColor();
            }
            Multiplier_Label.alpha = 1.0;
            Multiplier_Label.text = "x" + String(Level.Multiplier);
            Multiplier_Label.runAction(SKAction.fadeAlphaTo(0.0, duration: NSTimeInterval(1.0)));
            Multiplier_Label.runAction(SKAction.moveToY(100 * Game.scale_value, duration: NSTimeInterval(1.0)))
            Game.player.MultiplyerBuffs();
        }
    }
    
    func WolfBite() //Play wolf eat animation
    {
        let wolfBite_animation:SKAction = SKAction.repeatAction(SKAction.animateWithTextures(Textures.Hole_sheet.WolfHole_Bite(), timePerFrame: NSTimeInterval(0.033 * animSpeed)), count: 1);
        self.runAction(wolfBite_animation);
    }
    
    func Pause()
    {
        if(Game.is_paused)
        {
            pop_timer.invalidate();
        }
        else
        {
            pop_timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("Pop"), userInfo: nil, repeats: true)
        }
    }
}