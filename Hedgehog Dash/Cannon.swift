//
//  Cannon.swift
//  Hedgehog Dash
//
//  Created by Luke on 6/17/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class Cannon : Enemy {
    
    var timebetweenshots:Double = 0;
    
    func Setup(pos:Int)
    {
        //get the randomized wall position
        random_pos = pos;
        setScale(Game.scale_value);
        
        if(random_pos == 0){ //Left
            self.texture = Textures.Enemies_sheet.WallCannon_Horizontal0001();
            isHorizontalSpawn = true;
            left = CGPoint(x: size.width/2, y: 0);
            direction = "left";
        }else if(random_pos == 1){ //Right
            self.texture = Textures.Enemies_sheet.WallCannon_Horizontal0001();
            isHorizontalSpawn = true;
            self.zRotation = 180 * Math.DegreesToRadians;
            right = CGPoint(x: Game.screen[0] - size.width/2, y: 0);
            direction = "right";
        }else if(random_pos == 2){ //Top
            self.texture = Textures.Enemies_sheet.WallCannon_Vertical0001();
            isHorizontalSpawn = false;
            top = CGPoint(x: 0, y: Game.screen[1] - size.width/4);
            direction = "top";
        }else if(random_pos == 3){ //Bot
            self.texture = Textures.Enemies_sheet.WallCannon_Vertical0001();
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
        let cannonRect:CGRect = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.size.width, height: self.size.height);
        Level.AlreadyWallObjectThere.append(cannonRect);
    }
    
    override func Update()
    {
        super.Update();
    }
    
    func Fire()
    {
        var animTexture:[SKTexture]!;
        let cannonball:CannonBall = CannonBall(texture: Textures.Enemies_sheet.Cannonball());
        
        if(random_pos == 0){ cannonball.position = CGPoint(x: self.position.x + self.size.width/2, y: self.position.y); animTexture = Textures.Enemies_sheet.WallCannon_Horizontal();
}else if(random_pos == 1){ cannonball.position = CGPoint(x: self.position.x - self.size.width/2, y: self.position.y); animTexture = Textures.Enemies_sheet.WallCannon_Horizontal();
}else if(random_pos == 2){ cannonball.position = CGPoint(x: self.position.x, y: self.position.y - self.size.height/4); animTexture = Textures.Enemies_sheet.WallCannon_Vertical();
}else if(random_pos == 3){ cannonball.position = CGPoint(x: self.position.x, y: self.position.y + self.size.height/4); animTexture = Textures.Enemies_sheet.WallCannon_Vertical();}
        
        let fire:SKAction = SKAction.animateWithTextures(animTexture, timePerFrame: NSTimeInterval(0.05 * animSpeed));
        self.runAction(fire);
        
        cannonball.physicsBody = SKPhysicsBody(circleOfRadius: cannonball.size.width/2);
        cannonball.physicsBody?.categoryBitMask = PhysicsCategory.col_spikes;
        cannonball.physicsBody?.collisionBitMask = PhysicsCategory.None;
        cannonball.physicsBody?.contactTestBitMask = PhysicsCategory.col_player;
        cannonball.physicsBody?.fieldBitMask = PhysicsCategory.None;
        cannonball.physicsBody?.dynamic = true
        cannonball.physicsBody?.linearDamping = 0.2;
        cannonball.physicsBody?.friction = 0.2;
        cannonball.physicsBody?.angularDamping = 0.8;
        cannonball.physicsBody?.restitution = 0.2;
        cannonball.physicsBody?.mass = 0.2;
        cannonball.physicsBody?.allowsRotation = true;
        cannonball.name = "cannonball";
        
        cannonball.setScale(Game.scale_value);

        cannonball.zRotation = rotation_array[random_pos] * Math.DegreesToRadians;
        cannonball.zPosition = 1;
    
        
        let seconds = 0.2 * Double(animSpeed);
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            Scenes.GAME_SCENE?.addChild(cannonball)
            let cannonpower = 120 * Game.scale_value;
            cannonball.physicsBody?.applyImpulse(CGVectorMake(-cos(cannonball.zRotation) * (cannonpower), -sin(cannonball.zRotation) * (cannonpower)));
        })
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