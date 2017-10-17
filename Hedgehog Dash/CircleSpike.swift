//
//  CircleSpike.swift
//  Hedgehog Dash
//
//  Created by Luke on 6/21/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

class CircleSpike : Enemy {
    
    var extraMaxAccel:CGFloat = CGFloat(arc4random() % 50)
    
    func Setup()
    {
        //Setup if needed
    }
    
    override func Update()
    {
        super.Update();
        
        let x = self.physicsBody?.velocity.dx;
        let y = self.physicsBody?.velocity.dy;
        let act = round(sqrt(x! * x! + y! * y!));
        if(act < (120 * Game.scale_value) + extraMaxAccel)
        {
            self.physicsBody?.applyImpulse(CGVectorMake(cos(self.zRotation)*act, sin(self.zRotation)*act));
        }

    }
}