//
//  MakeScene.swift
//  Hedgehog Dash
//
//  Created by Luke on 5/8/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class MakeScene {
    
    //Map Data
    class func setupMap()
    {
        //Map Data
        let hole_point_1:CGPoint = CGPoint(x: Game.screen[0]/6, y: Game.screen[1]/3.5)
        let hole_point_2:CGPoint = CGPoint(x: Game.screen[0] - Game.screen[0]/6, y: Game.screen[1]/3.5)
        let hole_point_3:CGPoint = CGPoint(x: Game.screen[0]/6, y:  Game.screen[1] - Game.screen[1]/4)
        let hole_point_4:CGPoint = CGPoint(x: Game.screen[0] - Game.screen[0]/6, y:  Game.screen[1] - Game.screen[1]/4)

        Game.Holes_MapData = [hole_point_1, hole_point_2, hole_point_3, hole_point_4];
        
    }

    class func MakePlayer() -> Player
    {
        let tempSprite = Player(texture: Textures.Hedgehog_Anim.Hedgehog_Animation0001());
        
        tempSprite.setScale(Game.scale_value * 0.65);
        
        // Adding SpriteKit physics body for collision detection
        tempSprite.physicsBody = SKPhysicsBody(circleOfRadius: tempSprite.size.width/2)
        tempSprite.physicsBody?.categoryBitMask = PhysicsCategory.col_player
        tempSprite.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_hole | PhysicsCategory.col_spikes;
        tempSprite.physicsBody?.fieldBitMask = PhysicsCategory.None;
        tempSprite.physicsBody?.dynamic = true
        tempSprite.physicsBody?.linearDamping = 5;
        tempSprite.physicsBody?.friction = 0.0;
        tempSprite.physicsBody?.angularDamping = 0.8;
        tempSprite.physicsBody?.restitution = 0.2;
        tempSprite.physicsBody?.mass = 0.6;
        tempSprite.physicsBody?.allowsRotation = true;
        tempSprite.name = "player"
        
        tempSprite.position = CGPointMake(Game.screen[0]/2, Game.screen[1]/2)
        tempSprite.zPosition = 2;
        
        return tempSprite;
    }
    
    class func MakeHoles(HolesOnThisMap:Int!) -> [Hole]
    {
        
        var tempArray:[Hole] = [];
        
        for(var i:Int = 0; i<HolesOnThisMap; i++)
        {
            let tempSprite:Hole = Hole(texture: Textures.Hole_sheet.Hole_Empty());
            tempSprite.setScale(Game.scale_value/1.5);
            tempSprite.position = Game.Holes_MapData[i];
            tempSprite.zPosition = 1;
            tempArray.append(tempSprite);
            
            tempSprite.physicsBody = SKPhysicsBody(circleOfRadius: tempSprite.size.width/2)
            tempSprite.physicsBody?.categoryBitMask = 0
            tempSprite.physicsBody?.collisionBitMask = PhysicsCategory.col_player;
            tempSprite.physicsBody?.contactTestBitMask = PhysicsCategory.col_player;
            tempSprite.physicsBody?.fieldBitMask = PhysicsCategory.None;
            tempSprite.physicsBody?.dynamic = false
            tempSprite.physicsBody?.restitution = 1;
            
            tempSprite.Setup();
        }
        
        return tempArray;
    }
    
    class func MakeSpike() -> CircleSpike
    {
        let CicleSpike:CircleSpike = CircleSpike(texture: Textures.Enemies_sheet.Enemy_Spike())
        CicleSpike.size = CGSize(width: Game.screen[0]/14, height: Game.screen[0]/14)
        
        CicleSpike.physicsBody = SKPhysicsBody(circleOfRadius: CicleSpike.size.width/2.5)
        CicleSpike.physicsBody?.categoryBitMask = PhysicsCategory.col_spikes
        CicleSpike.physicsBody?.collisionBitMask = PhysicsCategory.col_walls;
        CicleSpike.physicsBody?.contactTestBitMask = PhysicsCategory.col_player
        CicleSpike.physicsBody?.fieldBitMask = PhysicsCategory.None;
        CicleSpike.physicsBody?.dynamic = true
        CicleSpike.physicsBody?.mass = 0;
        CicleSpike.physicsBody?.density = 0;
        CicleSpike.physicsBody?.restitution = 1;
        CicleSpike.physicsBody?.angularVelocity = 20;
        CicleSpike.physicsBody?.velocity = CGVectorMake(100, 100);
        CicleSpike.physicsBody?.friction = 0;
        CicleSpike.physicsBody?.angularDamping = 0;
        CicleSpike.physicsBody?.linearDamping = 0;
        CicleSpike.name = "ciclespike"
        
        CicleSpike.position = CGPointMake(CGFloat(arc4random()) % (Game.screen[0] - 150) + 50 , CGFloat(arc4random()) % (Game.screen[1] - 150) + 50)
        CicleSpike.zPosition = 2;
        
        CicleSpike.Setup();
        
        return CicleSpike;
    }
    
    class func MakeCannon() -> Cannon
    {
        var random_pos:Int = 0;
        if let temp_random_pos:Int = Int(arc4random() % 4){
            random_pos = temp_random_pos;
        }
        else
        {
            if(random_pos < 3){
                random_pos++;
            }
        }
        
        let cannonTemp:Cannon!;
        if(random_pos < 2){
            cannonTemp = Cannon(texture: Textures.Enemies_sheet.WallCannon_Horizontal0001());
        }else{
            cannonTemp = Cannon(texture: Textures.Enemies_sheet.WallCannon_Vertical0001());
        }

        cannonTemp.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: cannonTemp.size.width, height: cannonTemp.size.height));
        cannonTemp.physicsBody?.dynamic = false;
        cannonTemp.zPosition = 1;
        
        cannonTemp.Setup(random_pos);
        
        return cannonTemp;
    }
    
    class func MakePowerup(pos:CGPoint) -> Powerup
    {
        let tempPowerup:Powerup = Powerup(texture: Textures.GUI_sheet.Icon_Shield());
        tempPowerup.position = pos;
        
        tempPowerup.physicsBody = SKPhysicsBody(rectangleOfSize: tempPowerup.size)
        tempPowerup.physicsBody?.categoryBitMask = PhysicsCategory.col_pickup
        tempPowerup.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_hole;
        tempPowerup.physicsBody?.contactTestBitMask = PhysicsCategory.col_player
        tempPowerup.physicsBody?.fieldBitMask = PhysicsCategory.gravity_player;
        tempPowerup.physicsBody?.dynamic = true
        tempPowerup.physicsBody?.linearDamping = 5;
        tempPowerup.physicsBody?.allowsRotation = false;
        
        tempPowerup.Setup();
        
        return tempPowerup;
    }
}