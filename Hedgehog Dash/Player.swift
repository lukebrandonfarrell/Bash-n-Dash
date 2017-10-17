//
//  Player.swift
//  Hedgehog Dash
//
//  Created by Luke on 2/15/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion


class Player : SKSpriteNode {
    
    //Tilt Motion
    var tiltEnabled:Bool = true;
    
    var motionManager: CMMotionManager!
    var TiltOriginX:CGFloat = 0.0;
    var TiltOriginY:CGFloat = 0.0;
    
    var tilt_calibration:Bool = false;
    
    var accelX:CGFloat = 0;
    var accelY:CGFloat = 0;
    var accelZ:CGFloat = 0;
    
    var first_calibration:Bool = true;
    
    //Movement
    var playerSpeed:CGFloat = 25; //Player Speed (How fast he gonna move)
    var playerVelocity:CGVector = CGVector(dx: 0, dy: 0); //The vector of the current player velocity/movement, x and y
    
    var playerAccelLimit:CGFloat = 120;
    var playerMaxAccel:CGFloat = 80;
    var playerAccel:CGFloat = 0;
    
    var MagneticField:SKFieldNode!;
    
    //Been Hurt? Variables
    var is_hurt:Bool = false;
    var is_hurt_for_time:CGFloat = 0;
    var dead:Bool = false; //Is player dead and waiting to respawn
    
    //Powerups
    var shield:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Shield());
    
    //Fire trail
    let fireEmmiter = SKEmitterNode(fileNamed: "fire.sks")
    
    func Setup()
    {
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        MagneticField = SKFieldNode.radialGravityField()
        MagneticField.physicsBody?.categoryBitMask = PhysicsCategory.gravity_player;
        MagneticField.strength = 15
        MagneticField.falloff = 1
        MagneticField.region = SKRegion(radius: 100)
        self.addChild(MagneticField);
        
        shield.zPosition = 3;
        shield.alpha = 0;
        self.addChild(shield);
        
        fireEmmiter!.name = "fireEmmiter"
        fireEmmiter!.particleLifetime = 1
        fireEmmiter!.particleZPosition = 3;
    }
    
    func Update()
    {
        if(!Game.is_paused && dead == false)
        {
            if(tiltEnabled)
            {
                //MOVEMENT MANAGEMENT/*
                if let accelerometerData = motionManager.accelerometerData {
                    
                    let kFilteringFactor:CGFloat = 0.1;
                    
                    accelX = (CGFloat(accelerometerData.acceleration.x) * kFilteringFactor) + (accelX * (1.0 - kFilteringFactor));
                    accelY = (CGFloat(accelerometerData.acceleration.y) * kFilteringFactor) + (accelY * (1.0 - kFilteringFactor));
                    accelZ = (CGFloat(accelerometerData.acceleration.z) * kFilteringFactor) + (accelZ * (1.0 - kFilteringFactor));
                    
                    if(!tilt_calibration)
                    {
                        //Inverted x & y because device will be landscape
                        if(first_calibration)
                        {
                            TiltOriginX = accelX*10;
                            TiltOriginY = accelY*10;
                        }
                        else
                        {
                            TiltOriginX = accelX;
                            TiltOriginY = accelY;
                        }
                        
                        first_calibration = false;
                        tilt_calibration = true;
                    }
                    
                    let tilt_sensitivity:CGFloat = 40 * Game.scale_value; //Tilt Sensitivity
                    
                    let tiltX:CGFloat = accelY - TiltOriginY;
                    let tiltY:CGFloat = accelX - TiltOriginX;
                    
                    playerVelocity = CGVector(dx: 0, dy: 0)
                    playerVelocity.dx = (tiltX) * tilt_sensitivity;
                    playerVelocity.dy = (tiltY) * tilt_sensitivity;
                    
                    //Accel
                    if(playerSpeed < playerMaxAccel)
                    {
                        playerAccel = playerAccel + 0.2;
                        playerSpeed = playerSpeed + playerAccel;
                    }
                    
                    var angle:CGFloat = 0.0;
                    angle = atan2(-playerVelocity.dy, playerVelocity.dx)
                    
                    Game.actual_speed = round(sqrt(playerVelocity.dx * playerVelocity.dx + playerVelocity.dy * playerVelocity.dy))
                    
                    if Game.actual_speed > (3 * Game.scale_value) {
                        //player.zRotation = angle - 90 * DegreesToRadians;
                        if(!Level.Clock_Powerup){
                            MoveForward(-tiltX * tilt_sensitivity, ac_y: tiltY * tilt_sensitivity)
                        }else{
                            MoveForward((-tiltX * tilt_sensitivity) * 2, ac_y: (tiltY * tilt_sensitivity) * 2)
                        }
                        self.runAction(SKAction.rotateToAngle(angle - 90 * Math.DegreesToRadians, duration: NSTimeInterval(0.0), shortestUnitArc:true), withKey: "Turn")
                    }
                    else
                    {
                        playerAccel = 0;
                        playerSpeed = 25;
                        
                        //Remove action?
                        self.removeActionForKey("Turn");
                    }
                    
                    if(Level.Shield_Time <= 0 && Level.Shield_Powerup)
                    {
                        unLoadShield();
                    }
                    
                    if(Level.Magnet_Time <= 0 && Level.Magnet_Powerup)
                    {
                        unLoadMagnet();
                    }
                }
            }
            
            //Other Player Update stuff
            if(is_hurt){
                is_hurt_for_time--;
                
                if(self.actionForKey("Flash") == nil)
                {
                    let wait:SKAction = SKAction.waitForDuration(NSTimeInterval(0.2));
                    let flash:SKAction = SKAction.runBlock { () -> Void in
                        if(self.alpha > 0.5){
                            self.alpha = 0.4;
                        }else{
                            self.alpha = 1.0;
                        }
                    }
                    let sequence = [flash,wait];

                    self.runAction(SKAction.sequence(sequence), withKey:"Flash");
                }
                
                if(is_hurt_for_time <= 0)
                {
                    //Set Player back to normal ->
                    self.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_hole | PhysicsCategory.col_spikes;
                    if(self.actionForKey("Flash") != nil){self.removeActionForKey("Flash");}
                    self.alpha = 1.0;
                    
                    is_hurt = false;
                }
            }
            
            if(playerMaxAccel > playerAccelLimit){
                playerMaxAccel = playerAccelLimit;
            }
        }
    }
    
    func MoveForward(ac_x:CGFloat = 0, ac_y:CGFloat = 0)
    {
        if(playerSpeed < playerMaxAccel)
        {
            playerAccel = playerAccel + 0.00001;
            playerSpeed = playerSpeed + playerAccel;
        }
        playerVelocity.dx = (ac_x * playerSpeed);
        playerVelocity.dy = (ac_y * playerSpeed);
        
        self.physicsBody?.applyForce(CGVectorMake(playerVelocity.dx , playerVelocity.dy))
        
        Game.actual_speed = sqrt(playerVelocity.dx * playerVelocity.dx + playerVelocity.dy * playerVelocity.dy)/25;

        if(self.actionForKey("Roll") == nil && Game.actual_speed > 2)
        {
            
            //anim.speed = ... set action speed to match movement speed
            var anim_speed = 20/(100 * Game.actual_speed);
            if(anim_speed < 0.02){anim_speed = 0.02}
            let anim = SKAction.animateWithTextures(Textures.Hedgehog_Anim.Hedgehog_Roll(), timePerFrame: NSTimeInterval(anim_speed));
            self.runAction(anim, withKey: "Roll");
        }

    }
    
    func Dash(ac_x:CGFloat = 0, ac_y:CGFloat = 0)
    {
        //self.physicsBody?.applyImpulse(CGVectorMake(ac_x * 500 , ac_x * 500))
    }
    
    func HurtPlayer(waitforrespawn:Bool = false)
    {
        //Dedect life here
        if(Level.Hearts > 0 && is_hurt_for_time <= 0 && !Level.Shield_Powerup)
        {
            //Update Health bar
            Level.hearts_array[abs(Level.Hearts-Upgardes.MaxHearts)].texture = Textures.GUI_sheet.Icon_HeartEmpty();
            Level.Hearts--;
            
            //Debuff Multiplier buffs
            RemoveMultiplierBuffs();
            
            //Remove collision with enemies
            self.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_hole;
            
            if(waitforrespawn)
            {
                self.alpha = 0;
                dead = true;
                let wait:SKAction = SKAction.waitForDuration(NSTimeInterval(2.0));
                let respawn:SKAction = SKAction.runBlock { () -> Void in
                    self.position.x = Game.screen[0]/2;
                    self.position.y = Game.screen[1]/2;
                    self.is_hurt_for_time = 200;
                    self.is_hurt = true;
                    self.alpha = 1.0;
                    self.dead = false;
                }
                let sequence = [wait,respawn];
                self.runAction(SKAction.sequence(sequence));
            }
            else
            {
                //Set Player to has been hurt
                is_hurt_for_time = 200;
                is_hurt = true;
            }
        }
    }
    
    func MultiplyerBuffs(){
        playerMaxAccel++;
        
        if(Level.Multiplier == Level.MultiplierNextBuff){
            Level.MultiplierNextBuff += 5;
            //Small buff
        }
        
        if(Level.Multiplier == 20){
            //Fire trial
            addChild(fireEmmiter!)
            fireEmmiter!.targetNode = Scenes.GAME_SCENE;
            self.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_spikes;
        }
    }
    
    func RemoveMultiplierBuffs()
    {
        Level.Multiplier = 0;
        Level.MultiplierNextBuff = 5;
        playerMaxAccel = playerAccelLimit;
        
        fireEmmiter?.removeFromParent();
        self.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_hole | PhysicsCategory.col_spikes;
    }
    
    //Powerups
    func LoadShield()
    {
        if(!Level.Shield_Powerup)
        {
            shield.alpha = 1.0;
            shield.setScale(0);
            
            let appear:SKAction = SKAction.scaleTo(Game.scale_value, duration: NSTimeInterval(0.5));
            appear.timingMode = SKActionTimingMode.EaseOut;
            shield.runAction(appear);
            
            Level.Shield_Powerup = true;
        }
    }
    
    func unLoadShield()
    {
        shield.alpha = 0;
        shield.setScale(0);
        Level.Shield_Powerup = false;
    }
    
    func LoadMagnet()
    {
        MagneticField.strength = 30;
        MagneticField.region = SKRegion(radius: Upgardes.Player_Magnet_Value)
        Level.Magnet_Powerup = true;
    }
    
    func unLoadMagnet()
    {
        MagneticField.strength = 15;
        MagneticField.region = SKRegion(radius: 100)
        Level.Magnet_Powerup = false;
    }
}