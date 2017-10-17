//
//  Enemy.swift
//  Hedgehog Dash
//
//  Created by Luke on 3/29/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : SKSpriteNode {
    
    var animSpeed:CGFloat = 1.0;
    var EnemyTimer:NSTimer!;
    
    func Update()
    {
        if(Level.Clock_Powerup)
        {
            animSpeed = 1.5;
        }
        else
        {
            animSpeed = 1.0;
        }
    }
    
    //Wall Enemies - Place them on wall functions
    var pos_array:[CGPoint]!;
    
    var rotation_array:[CGFloat] = [180, 0, 90, 270];
    
    var random_pos:Int = 0;
    
    var isHorizontalSpawn:Bool = false; //IS the cannon spawning accross the wall horizonatally or if false vertically
    
    var checkPositionCount:Int = 0; //dont check the cannon position to much as there might not be space on the scene and it will just use up resources (or infinite loop) and crash
    
    var left:CGPoint = CGPoint(x: 0,y: 0);
    var right:CGPoint = CGPoint(x: 0,y: 0);
    var top:CGPoint = CGPoint(x: 0,y: 0);
    var bot:CGPoint = CGPoint(x: 0,y: 0);
    
    var direction:String = "";
    
    func CheckWallPosition(NewPos:CGRect)
    {
        var intercepts:Bool = false;
        
        if(checkPositionCount < 4)
        {
            checkPositionCount++;
            if(Level.AlreadyWallObjectThere.count > 0)
            {
                for(var i = 0; i < Level.AlreadyWallObjectThere.count; i++)
                {
                    
                    if(CGRectIntersectsRect(NewPos, Level.AlreadyWallObjectThere[i])){
                        intercepts = true;
                    }
                    else
                    {
                        intercepts = false;
                    }
                }
            }
            
            if(intercepts){
                SetWallPosition();
            }else{
                self.position = pos_array[random_pos];
            }
        }
        else
        {
            //There is no space left on this wall for a cannon so delete this
            DeleteTimer();
            self.removeFromParent();
        }
    }
    
    func SetWallPosition(){
        let randomWidthInBox:CGFloat = CGFloat.random(Game.WallHeight, upper: (Game.screen[1] - Game.WallHeight));
        let randomHeightInBox:CGFloat = CGFloat.random(Game.WallWidth, upper: (Game.screen[0] - Game.WallWidth));
        
        if(direction == "left"){
            left.y = randomHeightInBox;
            pos_array = [left,right,top,bot];
            CheckWallPosition(CGRect(x: left.x - self.size.width/2, y: left.y - self.size.height/2, width: self.size.width, height: self.size.height))
        }else if(direction == "right"){
            right.y = randomHeightInBox;
            pos_array = [left,right,top,bot];
            CheckWallPosition(CGRect(x: right.x - self.size.width/2, y: right.y - self.size.height/2, width: self.size.width, height: self.size.height))
        }else if(direction == "top"){
            top.x = randomWidthInBox;
            pos_array = [left,right,top,bot];
            CheckWallPosition(CGRect(x: top.x - self.size.width/2, y: top.y - self.size.height/2, width: self.size.width, height: self.size.height))
        }else if(direction == "bot"){
            bot.x = randomWidthInBox;
            pos_array = [left,right,top,bot];
            CheckWallPosition(CGRect(x: bot.x - self.size.width/2, y: bot.y - self.size.height/2, width: self.size.width, height: self.size.height))
        }
    }
    
    func DeleteTimer()
    {
        EnemyTimer.invalidate();
    }
}
