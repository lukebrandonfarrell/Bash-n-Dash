//
//  GameScene.swift
//  Hedgehog Dash
//
//  Created by Luke on 2/15/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import SpriteKit
import Foundation
import CoreMotion


class GameScene: SKScene, SKPhysicsContactDelegate
{
    
    //Values
    var gamesetup:Bool = false;
    var gamestarted:Bool = false;
    
    var coin_array:[SKSpriteNode] = [];
    var diamond_array:[SKSpriteNode] = [];
    var berry_array:[SKSpriteNode] = [];
    
    var holes_array:[Hole] = [];
    var circlespike_array:[CircleSpike] = [];
    var cannon_array:[Cannon] = [];

    var current_spikes:Int = 0;
    var current_cannons:Int = 0;
    
    //GUI
        var Background:SKSpriteNode!;
        var Circle:SKShapeNode!;
    
        let levelbar:LevelBar = LevelBar();
    
        //Text
        let Ammount_Diamond:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
        let Ammount_Coin:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
        //Icons
        let Icon_Diamond = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Diamond())
        let Icon_Coin = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Coin())
        let Icon_Berry = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Berry())
        let Icon_Powerbars:Powerbars = Powerbars();
    
        let Icon_TaskList:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_TaskList());

        let Button_Pause = SKSpriteNode(texture: Textures.GUI_sheet.Button_Pause())
    
    let Score_Count:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
    var joystick: Joystick!;
    var leftjoystick:SKSpriteNode = SKSpriteNode(imageNamed: "dpad");
    
    //Obsolete
    var SpawnLocation:CGPoint!;
    var SpawnCurrency:Bool = false;
    
    var difficultyTimer:NSTimer!;
   
    //Popups
    var faded_rectangled:SKSpriteNode!;
    
    let Gameover_popup:SKSpriteNode = SKSpriteNode(imageNamed: "Box_GameOver")
    let TaskList_popup:SKSpriteNode = SKSpriteNode(imageNamed: "BoxTasks");
    
    let finalScore:SKLabelNode = SKLabelNode(fontNamed: "CloudyChance-Regular")
    
    let button_playagain:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_PlayAgain0001());
    let button_mainmenu:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_MainMenu0001());
    let button_close:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Button_Close0001());
    
    override init(size: CGSize)
    {
        super.init(size: size);
        
        //Scene Properties
        Game.screen[0] = self.size.width;
        Game.screen[1] = self.size.height;
        
        Game.WallWidth = Game.screen[0]/14;
        Game.WallHeight = Game.screen[1]/8;
        
        self.backgroundColor = UIColor.whiteColor()
        
        Background = SKSpriteNode(imageNamed: "Background_Card");
        Background.size = CGSize(width: self.size.width+10, height: self.size.height+5);
        Background.position = CGPoint(x: (self.size.width/2)-2, y: (self.size.height/2));
        addChild(Background);
        
        Circle = SKShapeNode(circleOfRadius: self.size.width/8)
        Circle.position = CGPointMake(self.size.width/2, self.size.height/2)
        Circle.zPosition = 1
        Circle.lineWidth = 0;
        addChild(Circle)
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(origin: CGPoint(x: size.width/18, y: size.height/10), size: CGSize(width: self.size.width-size.width/9, height: self.size.height-size.height/5)));
        self.physicsBody?.categoryBitMask = PhysicsCategory.col_walls;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.None;
        self.physicsBody?.friction = 0;
        self.physicsBody?.restitution = 0;

        
        //Add GUI
        faded_rectangled = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: self.size.width, height: self.size.height))
        faded_rectangled.alpha = 0;
        faded_rectangled.position = CGPoint(x: self.size.width/2, y: self.size.height/2);
        faded_rectangled.zPosition = 0;
        addChild(faded_rectangled);
        
        //GameOver
            Gameover_popup.position = CGPoint(x: self.size.width/1.9, y: self.size.height/2);
            Gameover_popup.size = CGSize(width: self.size.width/1.1, height: self.size.height/1.2);
            Gameover_popup.alpha = 0;
            Gameover_popup.zPosition = 10;
            
            finalScore.fontSize = 80 * Game.scale_value
            finalScore.fontColor = SKColor.whiteColor();
            finalScore.text = "0";
            finalScore.position = CGPoint(x: -finalScore.frame.width/1.5, y: -finalScore.frame.height/1.1)
            finalScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            finalScore.zPosition = 11;
            Gameover_popup.addChild(finalScore);
        
            button_playagain.setScale(Game.scale_value);
            button_playagain.position = CGPoint(x: (self.size.width/2) + button_playagain.size.width/1.5, y: button_playagain.size.height/1.4);
            button_playagain.alpha = 0;
            button_playagain.zPosition = 11;
            button_playagain.name = "PlayAgain";

            button_mainmenu.setScale(Game.scale_value);
            button_mainmenu.position = CGPoint(x: (self.size.width/2) - button_mainmenu.size.width/1.5, y: button_mainmenu.size.height/1.4);
            button_mainmenu.alpha = 0;
            button_mainmenu.zPosition = 11;
            button_mainmenu.name = "MainMenu";

        
        TaskList_popup.position = CGPoint(x: self.size.width/2, y: self.size.height/1.8);
        TaskList_popup.size = CGSize(width: self.size.width/1.8, height: self.size.height/1.2);
        TaskList_popup.alpha = 0;
        TaskList_popup.zPosition = 0;
        addChild(TaskList_popup);
        
        button_close.setScale(Game.scale_value * 1.4);
        button_close.position = CGPoint(x: TaskList_popup.size.width - button_close.size.width/5, y: button_close.size.height);
        button_close.alpha = 0;
        button_close.zPosition = 0;
        button_close.name = "Close";
        addChild(button_close);
        
        Icon_Diamond.setScale(Game.scale_value);
        Icon_Diamond.position = CGPoint(x: Icon_Diamond.size.width, y: size.height-Icon_Diamond.size.height)
        Icon_Diamond.zPosition = 2;
        addChild(Icon_Diamond)
        
        Icon_Coin.setScale(Game.scale_value);
        Icon_Coin.position = CGPoint(x: Ammount_Diamond.frame.width, y: size.height-Icon_Diamond.size.height)
        Icon_Coin.zPosition = 2;
        addChild(Icon_Coin);
        
        Icon_TaskList.setScale(Game.scale_value);
        Icon_TaskList.position = CGPoint(x: Icon_TaskList.size.width, y: Icon_TaskList.size.height);
        Icon_TaskList.zPosition = 2;
        addChild(Icon_TaskList);
        Icon_TaskList.name = "TaskList";
        
        Ammount_Diamond.zPosition = 1;
        Ammount_Diamond.fontSize = 22 * Game.scale_value
        Ammount_Diamond.fontColor = SKColor.whiteColor()
        Ammount_Diamond.position = CGPoint(x: Icon_Diamond.size.width * 1.8, y: size.height-(Icon_Diamond.size.height*1.2))
        Ammount_Diamond.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        Ammount_Diamond.text = String(Currency.Diamonds);
        Ammount_Diamond.zPosition = 2;
        addChild(Ammount_Diamond);
        
        Ammount_Coin.fontSize = 22 * Game.scale_value
        Ammount_Coin.fontColor = SKColor.whiteColor()
        Ammount_Coin.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        Ammount_Coin.text = String(Currency.Coins);
        Ammount_Coin.zPosition = 2;
        addChild(Ammount_Coin);
        
        Ammount_Coin.position = CGPoint(x: Icon_Coin.position.x + Icon_Coin.size.width/2, y: size.height-(Icon_Diamond.size.height*1.2))

        Button_Pause.setScale(Game.scale_value);
        Button_Pause.position = CGPoint(x: size.width - Button_Pause.size.width, y: size.height - Button_Pause.size.height)
        Button_Pause.name = "Button_Pause"
        addChild(Button_Pause);
        Button_Pause.zPosition = 1;
        
        Score_Count.fontSize = 220 * Game.scale_value/2;
        Score_Count.fontColor = UIColor(netHex:0xD9AA5F);
        Score_Count.alpha = 0.2;
        Score_Count.position = CGPoint(x: Circle.position.x, y: Circle.position.y - Circle.frame.height/6)
        Score_Count.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        Score_Count.text = String(Game.Score);
        addChild(Score_Count);
        Score_Count.zPosition = 1;
        
        //Add Player
        Game.player = MakeScene.MakePlayer();
        Game.player.Setup();
        self.addChild(Game.player);
        
        Icon_Powerbars.Setup();
        Icon_Powerbars.position = CGPoint(x: size.width/2, y: size.height - size.height/11);
        Icon_Powerbars.zPosition = 5;
        self.addChild(Icon_Powerbars);
        
        if(!Game.player.tiltEnabled)
        {
            joystick = Joystick()
            joystick.position = CGPointMake(size.width - 100, 100)
            joystick.zPosition = 10;
            self.addChild(joystick)
            
            
            leftjoystick.position = CGPointMake(100, 100)
            leftjoystick.name = "leftjoystick";
            leftjoystick.zPosition = 10;
            self.addChild(leftjoystick);
        }
        
        //LevelBar
        levelbar.SetUp();
        levelbar.setScale(Game.scale_value * 0.7);
        levelbar.position = CGPoint(x: size.width/2, y: levelbar.thumbnail.size.height/2.2);
        addChild(levelbar)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        Scenes.audio.playMusic("GameMusic");
        MakeScene.setupMap(); //We can pass diffrent map layouts through here
        
        if(Level.world == 0){Background.texture = SKTexture(imageNamed: "Background_Card");
        Circle.fillColor = UIColor(red: 120 / 255.0, green: 70 / 255.0, blue: 34 / 255.0, alpha: 0.3);}
        else if(Level.world == 1){Background.texture = SKTexture(imageNamed: "Background_Wood");
        Circle.fillColor = UIColor(red: 71 / 255.0, green: 46 / 255.0, blue: 25 / 255.0, alpha: 0.3);}
        else if(Level.world == 2){Background.texture = SKTexture(imageNamed: "Background_Overgrown");
        Circle.fillColor = UIColor(red: 71 / 255.0, green: 46 / 255.0, blue: 25 / 255.0, alpha: 0.3);}
        else if(Level.world == 3){Background.texture = SKTexture(imageNamed: "Background_Ice");
        Circle.fillColor = UIColor(red: 30 / 255.0, green: 44 / 255.0, blue: 99 / 255.0, alpha: 0.3);}
        else if(Level.world == 4){Background.texture = SKTexture(imageNamed: "Background_HighTech");
        Circle.fillColor = UIColor(red: 23 / 255.0, green: 32 / 255.0, blue: 43 / 255.0, alpha: 0.3);}
        else if(Level.world == 5){Background.texture = SKTexture(imageNamed: "Background_Haunted");
        Circle.fillColor = UIColor(red: 36 / 255.0, green: 30 / 255.0, blue: 21 / 255.0, alpha: 0.3);}
    }
    
    //Object Creation
    func Spike(){
        let temp_spike = MakeScene.MakeSpike();
        self.addChild(temp_spike);
        current_spikes++;
        circlespike_array.append(temp_spike);
        
        let AppearEmmiter = SKEmitterNode(fileNamed: "Appear.sks")
        AppearEmmiter!.name = "sparkEmmitter"
        AppearEmmiter!.particleZPosition = 3;
        AppearEmmiter!.position = self.position;
        AppearEmmiter!.speed = temp_spike.animSpeed;
        temp_spike.addChild(AppearEmmiter!);
    }
    func CreateCannon(){
        let temp_cannon = MakeScene.MakeCannon();
        self.addChild(temp_cannon);
        cannon_array.append(temp_cannon);
        current_cannons++;
        
        let AppearEmmiter = SKEmitterNode(fileNamed: "Appear.sks")
        AppearEmmiter!.name = "sparkEmmitter"
        AppearEmmiter!.particleZPosition = 3;
        AppearEmmiter!.position = self.position;
        AppearEmmiter!.speed = temp_cannon.animSpeed;
        temp_cannon.addChild(AppearEmmiter!);
    }
    
    func MakeCoin(pos:CGPoint!, quantity:CGFloat!)
    {
        for(var i:CGFloat = 0; i<quantity; i++)
        {
            let coin = SKSpriteNode(imageNamed: "Icon_Coin");
            coin.setScale(Game.scale_value/2);
            coin.physicsBody = SKPhysicsBody(rectangleOfSize: coin.size)
            coin.physicsBody?.categoryBitMask = PhysicsCategory.col_pickup
            coin.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_hole;
            coin.physicsBody?.contactTestBitMask = PhysicsCategory.col_player
            coin.physicsBody?.fieldBitMask = PhysicsCategory.gravity_player;
            coin.physicsBody?.dynamic = true
            coin.physicsBody?.linearDamping = 5;
            coin.physicsBody?.allowsRotation = false;
            
            //Apply Random Force from Position
            coin.zRotation = GameScene.randomBetweenNumbers(-2, secondNum: 2);
            coin.position = pos;
            coin.name = "Coin_Pickup";
            self.addChild(coin);
            coin_array.append(coin);
            
            let random_force_x:CGFloat = GameScene.randomBetweenNumbers(-30, secondNum: 30);
            let random_force_y:CGFloat = GameScene.randomBetweenNumbers(-30, secondNum: 30);
            
            coin.physicsBody?.applyImpulse(CGVector(dx: random_force_x, dy: random_force_y));
        }
    }
    
    func MakeDiamond(pos:CGPoint!, quantity:CGFloat!)
    {
        for(var i:CGFloat = 0; i<quantity; i++)
        {
            let diamond = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Diamond());
            diamond.setScale(Game.scale_value/2);
            diamond.physicsBody = SKPhysicsBody(rectangleOfSize: diamond.size)
            diamond.physicsBody?.categoryBitMask = PhysicsCategory.col_pickup
            diamond.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_hole;
            diamond.physicsBody?.contactTestBitMask = PhysicsCategory.col_player
            diamond.physicsBody?.fieldBitMask = PhysicsCategory.gravity_player;
            diamond.physicsBody?.dynamic = true
            diamond.physicsBody?.linearDamping = 5;
            diamond.physicsBody?.allowsRotation = false;
            
            //Apply Random Force from Position
            diamond.zRotation = GameScene.randomBetweenNumbers(-2, secondNum: 2);
            diamond.zPosition = 2;
            diamond.position = pos;
            diamond.name = "Diamond_Pickup";
            self.addChild(diamond);
            diamond_array.append(diamond);
            
            let random_force_x:CGFloat = GameScene.randomBetweenNumbers(-15 * Game.scale_value, secondNum: 15 * Game.scale_value);
            let random_force_y:CGFloat = GameScene.randomBetweenNumbers(-15 * Game.scale_value, secondNum: 15 * Game.scale_value);
            
            diamond.physicsBody?.applyImpulse(CGVector(dx: random_force_x, dy: random_force_y));
        }
        
    }
    
    func MakeBerry(pos:CGPoint!, quantity:CGFloat!)
    {
        for(var i:CGFloat = 0; i<quantity; i++)
        {
            let berry:SKSpriteNode = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Berry());
            berry.setScale(Game.scale_value/2);
            berry.physicsBody = SKPhysicsBody(circleOfRadius: berry.size.width/2)
            berry.physicsBody?.categoryBitMask = PhysicsCategory.col_pickup
            berry.physicsBody?.collisionBitMask = PhysicsCategory.col_walls | PhysicsCategory.col_hole;
            berry.physicsBody?.contactTestBitMask = PhysicsCategory.col_player
            berry.physicsBody?.fieldBitMask = PhysicsCategory.gravity_player;
            berry.physicsBody?.dynamic = true
            berry.physicsBody?.linearDamping = 3;
            berry.physicsBody?.allowsRotation = false;
            
            //Apply Random Force from Position
            berry.zRotation = GameScene.randomBetweenNumbers(-2, secondNum: 2);
            berry.zPosition = 2;
            berry.position = pos;
            berry.name = "Berry_Pickup";
            self.addChild(berry);
            berry_array.append(berry);
            
            let random_force_x:CGFloat = GameScene.randomBetweenNumbers(-15 * Game.scale_value, secondNum: 15 * Game.scale_value);
            let random_force_y:CGFloat = GameScene.randomBetweenNumbers(-15 * Game.scale_value, secondNum: 15 * Game.scale_value);
            
            berry.physicsBody?.applyImpulse(CGVector(dx: random_force_x, dy: random_force_y));
        }
    }

    
    var playerMoving:Bool = false;
    //Game Logic
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
        }

        if(node.name == "Button_Pause")
        {
            //Pause/Play Game
            if(Game.is_paused)
            {
                Button_Pause.texture = Textures.GUI_sheet.Button_Pause();
                Game.is_paused = false;
                physicsWorld.speed = Level.SceneSpeed;
                self.speed = 1.0;
            }
            else
            {
                Button_Pause.texture = Textures.GUI_sheet.Button_Play();
                Game.is_paused = true;
                physicsWorld.speed = 0;
                self.speed = 0;
            }
            
            for(var b:Int = 0; b < holes_array.count; b++)
            {
                holes_array[b].Pause();
            }
            
            for(var c:Int = 0; c < cannon_array.count; c++)
            {
                cannon_array[c].Pause();
            }

        }
        
        if(node.name == "leftjoystick"){
            playerMoving = true;
        }
        
        if(node.name == "PlayAgain")
        {
            ResetScene();
        }
        
        if(node.name == "MainMenu")
        {
            ResetScene();
            Scenes.skView.presentScene(Scenes.GAME_MENU_SCENE!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: NSTimeInterval(1.0)));
        }
        
        if(node.name == "TaskList")
        {
            faded_rectangled.alpha = 0.8;
            TaskList_popup.alpha = 1;
            button_close.alpha = 1;
            
            faded_rectangled.zPosition = 10;
            TaskList_popup.zPosition = 10;
            button_close.zPosition = 11;
            
            Game.is_paused = true;
            physicsWorld.speed = 0;
            self.speed = 0;
        }
        
        if(node.name == "Close")
        {
            faded_rectangled.alpha = 0;
            TaskList_popup.alpha = 0;
            button_close.alpha = 0;
            
            faded_rectangled.zPosition = 0;
            TaskList_popup.zPosition = 0;
            button_close.zPosition = 0;
            
            Game.is_paused = false;
            physicsWorld.speed = Level.SceneSpeed;
            self.speed = 1.0;
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
        }

        if(node.name == "leftjoystick"){
            playerMoving = false;
            Game.player.playerSpeed = 15;
            Game.player.playerAccel = 0;
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(!gamesetup){
            gamesetup = true;
            
            let temp_hearts:Int = Upgardes.MaxHearts;
            for(var i:Int = 0; i<temp_hearts; i++)
            {
                let Icon_Heart = SKSpriteNode(texture: Textures.GUI_sheet.Icon_Heart())
                Icon_Heart.setScale(Game.scale_value * 1.2);
                Icon_Heart.position = CGPoint(x: (size.width/2) + Icon_Heart.size.width - ((Icon_Heart.size.width * 1.5) * CGFloat(i)), y: size.height-Icon_Heart.size.height);
                addChild(Icon_Heart)
                Icon_Heart.zPosition = 2;
                Level.hearts_array.append(Icon_Heart);
            }
            
            holes_array = MakeScene.MakeHoles(4);
            
            for(var i:Int = 0; i<holes_array.count; i++)
            {
                self.addChild(holes_array[i]);
            }
            
            //Check game and Increase difficulty every secound
            difficultyTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("IncreaseDifficulty"), userInfo: nil, repeats: true)
        }
        
        if(!Level.GameOver && !Game.is_paused)
        {
            Game.player.Update();
            Icon_Powerbars.Update();
            Game.levelbar.Update();
        
            //GUI UPDATES
            Ammount_Diamond.text = String(Currency.Diamonds);
            Ammount_Coin.text = String(Currency.Coins);
            
            Ammount_Coin.position.x = Icon_Coin.position.x + Icon_Coin.size.width * 0.8;
            Icon_Coin.position.x = Ammount_Diamond.position.x + Icon_Coin.size.width * 2;
            
            Score_Count.text = String(Game.Score);
            
            for(var a:Int = 0; a < circlespike_array.count; a++)
            {
                circlespike_array[a].Update();
            }
        
            for(var b:Int = 0; b < holes_array.count; b++)
            {
                holes_array[b].Update();
            }

            for(var c:Int = 0; c < cannon_array.count; c++)
            {
                cannon_array[c].Update();
            }

        
            //Spawn Currency Flag
            if(SpawnCurrency)
            {
                let diamond_spawnAmount:CGFloat = round(Game.actual_speed/10);
                let berry_spawnAmount:CGFloat = round((Game.actual_speed/10));
                
                MakeDiamond(SpawnLocation, quantity: diamond_spawnAmount);
                MakeBerry(SpawnLocation, quantity: berry_spawnAmount);
                SpawnCurrency = false;
                
                Game.Score++; //+ score here because coins only get flaged one per enemy
                
                let powerupChance = random() % 10;
                if(powerupChance == 1){
                    let powerup = MakeScene.MakePowerup(SpawnLocation);
                    self.addChild(powerup);
                }
            }
        
        
            if(!Game.player.tiltEnabled)
            {
                 if joystick.velocity.x != 0 || joystick.velocity.y != 0 {
                    var deg = joystick.angularVelocity * Math.RadiansToDegrees;
                    deg = deg - 180;
                    Game.player.zRotation = deg * Math.DegreesToRadians;
                 }
            }
            
            if(playerMoving)
            {
                var mov = (Game.player.zRotation * Math.RadiansToDegrees) - 90;
                mov = mov * Math.DegreesToRadians;
                Game.player.MoveForward(cos(mov) * 10, ac_y: sin(mov) * 10)
            }
            
            if(Level.Clock_Time <= 0 && Level.Clock_Powerup)
            {
                Level.SceneSpeed = 1.0;
                physicsWorld.speed = Level.SceneSpeed;
                Level.Clock_Powerup = false;
            }
            
            if(Game.Score >= 10){ Score_Count.fontSize = 180 * Game.scale_value/2;}
            if(Game.Score >= 100){ Score_Count.fontSize = 150 * Game.scale_value/2;}
        }
        
        if(Level.Hearts == 0 && !Level.GameOver){
            addChild(Gameover_popup);
            addChild(button_playagain);
            addChild(button_mainmenu);
            
            faded_rectangled.zPosition = 10;
            
            faded_rectangled.runAction(SKAction.fadeAlphaTo(0.8, duration: NSTimeInterval(0.2)))
            Gameover_popup.runAction(SKAction.fadeInWithDuration(NSTimeInterval(0.8)))
            button_playagain.runAction(SKAction.fadeInWithDuration(NSTimeInterval(0.8)))
            button_mainmenu.runAction(SKAction.fadeInWithDuration(NSTimeInterval(0.8)))
            
            finalScore.text = String(Game.Score);
            
            Level.GameOver = true;
        }
    }
    
    func IncreaseDifficulty()
    {
        //Increase Difficulty
        if(!Level.GameOver && !Game.is_paused)
        {
            if(circlespike_array.count < Level.Avalible_Spikes)
            {
                var circlespike_SpawnChance:Int = 40 * (current_spikes + 1);
                
                if(Game.Score < circlespike_SpawnChance){
                    circlespike_SpawnChance = random() % (circlespike_SpawnChance - Game.Score);
                }else{
                    Spike();
                }
                
                if(circlespike_SpawnChance == 1)
                {
                    Spike();
                }
            }
            
            if(cannon_array.count < Level.Avalible_Cannons)
            {
                var cannon_SpawnChance:Int = 50 * (current_cannons + 1);
                
                /*If score is bigger than spawn chance, spawn a cannon because one hasnt been spawned and the game will crash if we dont ->
                                                                    (cannon_SpawnChance(5) - Game.Score(10) = -5(Cant have negative int))*/
                if(Game.Score < cannon_SpawnChance){
                    cannon_SpawnChance = random() % (cannon_SpawnChance - Game.Score);
                }else{
                    CreateCannon();
                }
                
                if(cannon_SpawnChance == 1)
                {
                    CreateCannon();
                }
            }
        }
    }
    
    func ResetScene()
    {
        Gameover_popup.removeFromParent()
        button_playagain.removeFromParent()
        button_mainmenu.removeFromParent()
        
        //difficulty timer
        difficultyTimer.invalidate();
        
        for(var k:Int = 0; k < holes_array.count; k++)
        {
            holes_array[k].removeFromParent();
        }
        
        for(var a:Int = 0; a < circlespike_array.count; a++)
        {
            circlespike_array[a].removeFromParent();
        }
        
        for(var c:Int = 0; c < cannon_array.count; c++)
        {
            cannon_array[c].DeleteTimer();
            cannon_array[c].removeFromParent();
        }
        Level.AlreadyWallObjectThere = [];
        
        holes_array = [];
        circlespike_array = [];
        cannon_array = [];
        
        faded_rectangled.alpha = 0;
        Gameover_popup.alpha = 0;
        button_playagain.alpha = 0;
        
        faded_rectangled.zPosition = 0;
        
        Game.Score = 0;
        Level.Hearts = Upgardes.MaxHearts;
        
        for(var i:Int=0; i < Level.hearts_array.count; i++)
        {
            Level.hearts_array[i].texture = Textures.GUI_sheet.Icon_Heart();
            Level.hearts_array[i].removeFromParent();
        }
        
        Level.hearts_array = [];
        
        Icon_Powerbars.ResetAllBars();
        
        current_spikes = 0;
        current_cannons = 0;
        
        //Set Speed back to normal
        Level.SceneSpeed = 1.0;
        physicsWorld.speed = Level.SceneSpeed;
        
        //Multiplier Bonusses and Powerups
        Game.player.RemoveMultiplierBuffs();
        
        Level.GameOver = false;
        gamesetup = false;
    }
    
    //Scene Collision
    func didBeginContact(contact: SKPhysicsContact) {
        
        // Setup  Collision
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Test Collision
        if ((firstBody.categoryBitMask == PhysicsCategory.col_player) && (secondBody.categoryBitMask == PhysicsCategory.col_spikes)) {
            //player.physicsBody?.applyImpulse(CGVectorMake(secondBody.velocity.dx, secondBody.velocity.dy), atPoint: contact.contactPoint);
            if(!Level.Shield_Powerup){
                Game.player.physicsBody?.applyImpulse(CGVectorMake(-contact.contactNormal.dx * contact.collisionImpulse, -contact.contactNormal.dy * contact.collisionImpulse), atPoint: contact.contactPoint)
            }
            
            Game.player.HurtPlayer();
            
            if(secondBody.node?.name == "cannonball")
            {
                let exp:SKSpriteNode = SKSpriteNode(texture: Textures.Enemies_sheet.Explosion0001());
                exp.setScale(Game.scale_value * 2);
                exp.position = contact.contactPoint;
                addChild(exp)
                exp.runAction(SKAction.animateWithTextures(Textures.Enemies_sheet.Explosion(), timePerFrame: NSTimeInterval(0.05)))
                secondBody.node?.removeFromParent();
                
                let seconds = 1.4
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    exp.removeFromParent();
                })

            }
        }
        
        if ((firstBody.categoryBitMask == PhysicsCategory.col_player) && (secondBody.categoryBitMask == PhysicsCategory.col_hole)) {
            let node:Hole = secondBody.node as! Hole;
            
            if(node.state == 2 && Game.actual_speed < 10 && !node.hit)
            {
                node.hit = true;
                node.WolfBite();
                Game.player.HurtPlayer(true);
                return;
            }
            
            if(!node.hit){
                node.hit = true;
                //secondBody.categoryBitMask = PhysicsCategory.None;
                
                SpawnLocation = node.position;
                SpawnCurrency = true;
                
                node.Hurt();
            }
        }
        
        
        //Coins
        if ((firstBody.categoryBitMask == PhysicsCategory.col_player) && (secondBody.categoryBitMask == PhysicsCategory.col_pickup)) {

            var block:SKAction;
            var move:SKAction;
            var remove:SKAction;
            
            var sequence = [];
            
            var Amount:Int = 1;
            
            if(secondBody.node?.name == "Coin_Pickup")
            {
                block = SKAction.runBlock { () -> Void in
                    Amount = 0;
                    Currency.Coins++;
                }
                move = SKAction.moveTo(Icon_Coin.position, duration: NSTimeInterval(0.5));
                remove = SKAction.removeFromParent();
                
                sequence = [move, block, remove]
                
            } else if(secondBody.node?.name == "Diamond_Pickup") {
                block = SKAction.runBlock { () -> Void in
                    Amount = 0;
                    
                    if(!Level._2X_Powerup){
                        Currency.Diamonds++;
                    }else{
                        Currency.Diamonds += 2;
                    }
                }
                move = SKAction.moveTo(Icon_Diamond.position, duration: NSTimeInterval(0.5));
                remove = SKAction.removeFromParent();
                
                sequence = [move, block, remove]
            }
            else if(secondBody.node?.name == "Berry_Pickup")
            {
                block = SKAction.runBlock { () -> Void in
                    Amount = 1 * Int(Level.Multiplier);
                    if(Amount < 1){Amount == 1}
                    
                    if(!Level._2X_Powerup){
                        Currency.Exp += Amount;
                    }else{
                       //We might use the 2X powerup with the berries in the future
                        Currency.Exp += Amount;
                    }
                }
                move = SKAction.moveTo(CGPoint(x: levelbar.position.x, y: levelbar.position.y), duration: NSTimeInterval(0.5));
                remove = SKAction.removeFromParent();
                
                sequence = [move, block, remove]

            }
            else
            {
                remove = SKAction.removeFromParent();
                sequence = [remove];
            }
            
            if(Level.Shield_Powerup && Level._2X_Powerup && Level.Clock_Powerup && Level.Magnet_Powerup){Icon_Powerbars.bars = 0;}
            if(secondBody.node?.name == "Shield"){
                Game.player.LoadShield();
                Level.Shield_Time = 75.0;
                Icon_Powerbars.shield_bar_bg.position.y = (-Icon_Powerbars.shield_bar_bg.size.height * 3) * CGFloat(Icon_Powerbars.bars);
                Icon_Powerbars.bars++;
            }
            if(secondBody.node?.name == "2X"){
                Level._2X_Powerup = true;
                Level._2X_Time = 75.0;
                Icon_Powerbars._2X_bar_bg.position.y = (-Icon_Powerbars._2X_bar_bg.size.height * 3) * CGFloat(Icon_Powerbars.bars);
                Icon_Powerbars.bars++;
            }
            if(secondBody.node?.name == "Clock"){
                Level.SceneSpeed = 0.5;
                physicsWorld.speed = Level.SceneSpeed;
                Level.Clock_Time = 75.0;
                Level.Clock_Powerup = true;
                Icon_Powerbars.clock_bar_bg.position.y = (-Icon_Powerbars.clock_bar_bg.size.height * 3) * CGFloat(Icon_Powerbars.bars);
                Icon_Powerbars.bars++;
            }
            if(secondBody.node?.name == "Magnet"){
                Game.player.LoadMagnet();
                Level.Magnet_Time = 75.0;
                Icon_Powerbars.magnet_bar_bg.position.y = (-Icon_Powerbars.magnet_bar_bg.size.height * 3) * CGFloat(Icon_Powerbars.bars);
                Icon_Powerbars.bars++;
            }
            
            secondBody.node?.runAction(SKAction.sequence(sequence as! [SKAction]));
        }
    }
    
    //Math
    class func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum))
    }

}

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let col_walls   : UInt32 = 1  // 1
    static let col_player: UInt32 = 2     // 2
    static let col_spikes: UInt32 = 4
    static let col_pickup: UInt32 = 8
    static let col_hole: UInt32 = 16
    
    static let gravity_player: UInt32 = 32
}