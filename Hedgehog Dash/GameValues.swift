//
//  GameValues.swift
//  Hedgehog Dash
//
//  Created by Luke on 3/29/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

//All Values which can be chnaged by player. Shop stuff

import Foundation
import SpriteKit

struct Game {
    static var screen:[CGFloat] = [0.0, 0.0];
    static var WallWidth:CGFloat = 0;
    static var WallHeight:CGFloat = 0;
    
    static var Holes_MapData:[CGPoint]!;
    static var scale_value:CGFloat!;
    
    //Dynamic values
    static var Score:Int = 0;
    
    static var is_paused:Bool = false;
    
    static var player:Player!;
    static var actual_speed:CGFloat = 0; //Speed of current player moving (Calculated)
    
    static var levelbar:LevelBar = LevelBar(); //LevelBar Instance, we use this accross scenes so we dont have to make it more than onces
}

struct Level {
    static var world:Int = 0;
    static var level:Int = 0;
    
    static var levelscompleted = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
    static var levelsunlocked = [[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
    
    static var SceneSpeed:CGFloat = 1.0;
    
    static var GameOver:Bool = false;
    
    static var Hearts:Int = 3;
    static var hearts_array:[SKSpriteNode] = []; //This stores the heart icons so we can change them when the player is hurt
    
    //Enemies to Allow
    static var Avalible_Spikes:Int = 4;
    static var Avalible_Wolves:Bool = true;
    static var Avalible_Cannons:Int = 4;
    
    static var AlreadyWallObjectThere:[CGRect] = []; //An arary which stores data about where cannons have already been spawned
    
    //Powerups
    static var Shield_Powerup:Bool = false;
    static var _2X_Powerup:Bool = false;
    static var Clock_Powerup:Bool = false;
    static var Magnet_Powerup:Bool = false;
    
    static var Shield_Time:CGFloat = 5.0;
    static var _2X_Time:CGFloat = 5.0;
    static var Clock_Time:CGFloat = 5.0;
    static var Magnet_Time:CGFloat = 5.0;
    
    static var Multiplier:CGFloat = 0;
    static var MultiplierNextBuff:CGFloat = 5;
}

struct Currency
{
    static var Diamonds:Int = 0;
    static var Coins:Int = 0;
    static var Keys:Int = 0;
    
    static var PlayerLevel:Int = 1;
    static var Exp:Int = 0;
    static var ExpNeeded:Int = 1000;
}

struct Upgardes
{
    static var MaxHearts:Int = 3;
    static var Player_Magnet_Value:Float = 300;
}

struct Scenes {
   static var skView:SKView!;
   static var audio:AudioManager = AudioManager();
    
   static var GAME_SCENE:SKScene? = nil;
   static var GAME_MENU_SCENE:SKScene? = nil;
   static var WORLD_MENU_SCENE:SKScene? = nil;
   static var LEVEL_SELECTION_SCENE:SKScene? = nil;
}

struct Math {
    static let Pi = CGFloat(M_PI)
    
    static var DegreesToRadians:CGFloat = 0;
    static var RadiansToDegrees:CGFloat = 0;
}

public extension CGFloat {
    public static func random(lower: CGFloat, upper: CGFloat) -> CGFloat {
        let r:CGFloat = CGFloat(arc4random() % 10)/10;
        return (CGFloat(r) * (upper - lower)) + lower
    }
}