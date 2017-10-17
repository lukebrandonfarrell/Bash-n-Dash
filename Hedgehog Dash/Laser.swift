//
//  Laser.swift
//  Hedgehog Dash
//
//  Created by Luke on 8/8/15.
//  Copyright © 2015 Puzzled. All rights reserved.
//

import Foundation

import SpriteKit

class Laser : Enemy {
    
    var timebetweenshots:Double = 0;
    var isFireing:Bool = false;
    
    let laserBeam:SKSpriteNode = SKSpriteNode(texture: Textures.Enemies_sheet.LaserBeam());
    let laserEnd:SKSpriteNode = SKSpriteNode(texture: Textures.Enemies_sheet.LaserBeam_End0001());
    
    var laserbeamend:SKAction!;
    
    func Setup(pos:Int)
    {
        //get the randomized wall position
        random_pos = pos;
        setScale(Game.scale_value);
        
        if(random_pos == 0){ //Left
            self.texture = Textures.Enemies_sheet.Wall_LaserBeam_Horizontal();
            isHorizontalSpawn = true;
            left = CGPoint(x: size.width/2, y: 0);
            direction = "left";
        }else if(random_pos == 1){ //Right
            self.texture = Textures.Enemies_sheet.Wall_LaserBeam_Horizontal();
            isHorizontalSpawn = true;
            self.zRotation = 180 * Math.DegreesToRadians;
            right = CGPoint(x: Game.screen[0] - size.width/2, y: 0);
            direction = "right";
        }else if(random_pos == 2){ //Top
            self.texture = Textures.Enemies_sheet.Wall_LaserBeam_Vertical();
            isHorizontalSpawn = false;
            top = CGPoint(x: 0, y: Game.screen[1] - size.width/4);
            direction = "top";
        }else if(random_pos == 3){ //Bot
            self.texture = Textures.Enemies_sheet.Wall_LaserBeam_Vertical();
            self.zRotation = 180 * Math.DegreesToRadians;
            isHorizontalSpawn = false;
            bot = CGPoint(x: 0, y: size.width/4);
            direction = "bot";
        }
        
        
        //Cannon shots
        if let shotwaittime:Double = (Double(arc4random()) % 8.0) + 3.0 {
            EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(shotwaittime, target: self, selector: Selector("Fire"), userInfo: nil, repeats: true)
            timebetweenshots = shotwaittime;
        }else{
            EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(8, target: self, selector: Selector("Fire"), userInfo: nil, repeats: true)
            timebetweenshots = 8;
        }
        
        //Set cannon position then store it in an array
        SetWallPosition()
        //Array ->
        let laserRect:CGRect = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.size.width, height: self.size.height);
        Level.AlreadyWallObjectThere.append(laserRect);
        
        //Laser Beam
        laserbeamend = SKAction.animateWithTextures(Textures.Enemies_sheet.LaserBeam_End(), timePerFrame: NSTimeInterval(0.05 * animSpeed));
        laserBeam.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: Game.screen[0], height: laserBeam.size.height));
        
        laserBeam.size.width = 0;
        addChild(laserBeam);
        
        laserEnd.alpha = 0;
        addChild(laserEnd);
    }
    
    override func Update()
    {
        super.Update();
    }
    
    func Fire()
    {
        if(!isFireing){
            isFireing = true;
            
            laserEnd.runAction(SKAction.repeatActionForever(laserbeamend));
            
            laserBeam.physicsBody?.categoryBitMask = PhysicsCategory.col_spikes;
            laserBeam.physicsBody?.collisionBitMask = PhysicsCategory.None;
            laserBeam.physicsBody?.contactTestBitMask = PhysicsCategory.col_player;
            laserBeam.physicsBody?.fieldBitMask = PhysicsCategory.None;
            laserBeam.physicsBody?.dynamic = false
            
            laserBeam.zRotation = rotation_array[random_pos] * Math.DegreesToRadians;
            laserBeam.zPosition = 1;
            
            if(isHorizontalSpawn){
                laserBeam.runAction(SKAction.scaleXTo(Game.screen[0], duration: NSTimeInterval(0.5)));
            }else{
                laserBeam.runAction(SKAction.scaleYTo(Game.screen[1], duration: NSTimeInterval(0.5)));
            }

        }else{
            
        }
    }
    
    func Pause()
    {
        if(Game.is_paused)
        {
            EnemyTimer.invalidate();
        }
        else
        {
            EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(timebetweenshots, target: self, selector: Selector("Fire"), userInfo: nil, repeats: true)
        }
    }
}