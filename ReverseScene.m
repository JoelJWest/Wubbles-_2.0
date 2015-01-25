//
//  ReverseScene.m
//  Wubbles! 2.0
//
//  Created by Joel J. West on 9/30/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import "ReverseScene.h"

@interface ReverseScene()



@end
@implementation ReverseScene

static const uint32_t playerCategory = 0x1;
static const uint32_t obsticleCategory = 0x1 << 1;
static const uint32_t passiceCategory = 0x1 << 2;



-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        
        self.physicsWorld.contactDelegate = self;
        gameRunning = NO;
     
        [[NSNotificationCenter defaultCenter] removeObserver:self]; // USED TO RELEASE SELF WHEN VIEW IS RELOADED
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetScene) name:@"ResetGame" object:nil];
        
        [self addBackground];
        [self addMenuButton];
        
        [self addParachute];
        [self addInstructions];
     
        [self addWubbles];
        [self addHands];
        [self addMotionManager];
        [self addBoundries];
        [self addCurrentScore];
        [self addEndingScreen];
        [self updateInstructions];
        [self addPipes];
        
        offSet = [[NSUserDefaults standardUserDefaults] floatForKey:@"OffSet"];
        zoneNumber = 1;
        temp = 1000;
        topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"TopScoreReverse"];
        if (topScore == 0){
            [[NSUserDefaults standardUserDefaults] setInteger:1000 forKey:@"TopScoreReverse"];
        }
     
    }
    return self;
}

-(void)addMotionManager{
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 1/60;
    
}

-(void)addBackground{
    
    NSString *backgroundImage1 = @"bluesky.png";
    NSString *backgroundImage2 = @"bluesky2.png";
    
    background1 = [SKSpriteNode spriteNodeWithImageNamed:backgroundImage1];
    background2 = [SKSpriteNode spriteNodeWithImageNamed:backgroundImage2];
    
    background1.position = CGPointMake(self.size.width/2, self.size.height/2);
    background2.position = CGPointMake(self.size.width/2, self.size.height*2);
    
    
    [self addChild:background1];
    [self addChild:background2];

    fadeOut = [SKAction fadeAlphaTo:0 duration:1];
    SKAction *moveUp1 = [SKAction moveByX:0 y:(100) duration:1];
    moveUp = [SKAction repeatActionForever:moveUp1];
    
    SKAction *increaseSpeed1 = [SKAction moveByX:0 y:1 duration:1];
    increaseSpeed = [SKAction repeatActionForever:increaseSpeed1];
    
}

-(void)addParachute{
    parachute = [SKSpriteNode spriteNodeWithImageNamed:@"blueparachute2.png"];
    parachute.position = CGPointMake(160, 540);
    parachute.size = CGSizeMake(300, 194);
    parachute.alpha = 1;
    [self addChild:parachute];
    
    [self addRopes];
    
    
}

-(void)addInstructions{
    
    NSString *scoreBorder =@"openingborder.png";
    instructionsBackground = [SKSpriteNode spriteNodeWithImageNamed:scoreBorder];
    instructionsBackground.size = CGSizeMake(320, 200);
    instructionsBackground.position = CGPointMake(160, 422);
    instructionsBackground.alpha = 1;
    instructionsBackground.zPosition = 10;
    
    [self addChild:instructionsBackground];
    
    SKLabelNode *gameTitle = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    gameTitle.text =@"Reverse";
    gameTitle.fontSize = 39;
    gameTitle.position = CGPointMake(0, 57);
    gameTitle.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
    [instructionsBackground addChild:gameTitle];
    
    SKLabelNode *line1 = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    line1.text =@"Tap to release Wubbles.";
    line1.fontSize = 26;
    line1.position = CGPointMake(0, 25);
    line1.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    [instructionsBackground addChild:line1];
    
    SKLabelNode *line2 = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    line2.text =@"Tilt your device to avoid";
    line2.fontSize = 26;
    line2.position = CGPointMake(0, -5);
    line2.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    [instructionsBackground addChild:line2];
    
    SKLabelNode *line3 = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    line3.text =@"obsticles. Tap to Jump!";
    line3.fontSize = 26;
    line3.position = CGPointMake(0, -35);
    line3.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    [instructionsBackground addChild:line3];
    
    highScoreIntro = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    highScoreIntro.fontSize = 35;
    highScoreIntro.position = CGPointMake(0, -78);
    highScoreIntro.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
    [instructionsBackground addChild:highScoreIntro];
    
}

-(void)addWubbles{
    
    NSString *wubblesImage =@"";
    
    int randomWubbles = arc4random()%5;
    
    if (randomWubbles == 0){
        
        wubblesImage =@"wubblesblue.png";
    }
    else if (randomWubbles == 1){
        
        wubblesImage =@"wubblesblue.png";
    }
    else if (randomWubbles == 2){
        
        wubblesImage =@"wubblesblue.png";
    }
    else if (randomWubbles == 3){
        
        wubblesImage =@"wubblesblue.png";
    }
    else{
        
        wubblesImage =@"wubblesblue.png";
    }
    
    wubbles = [SKSpriteNode spriteNodeWithImageNamed:wubblesImage];
    wubbles.size = CGSizeMake(40, 40);
    wubbles.position = CGPointMake(160, 270);
    wubbles.zPosition = 3;
    wubbles.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
    wubbles.physicsBody.mass = .01;
    wubbles.physicsBody.linearDamping =8;
    wubbles.physicsBody.dynamic=NO;
    wubbles.physicsBody.categoryBitMask = playerCategory;
    wubbles.physicsBody.contactTestBitMask = obsticleCategory;
    
    [self addChild:wubbles];
}

-(void)addHands{
    
    tap = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    tap.fontSize = 36;
    tap.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    tap.text = @"Tap!";
    tap.position = CGPointMake(160, 140);
    [self addChild:tap];
    
    topHand = [SKSpriteNode spriteNodeWithImageNamed:@"handdown.png"];
    bottomHand = [SKSpriteNode spriteNodeWithImageNamed:@"handup.png"];
    topHand.size = CGSizeMake(32, 35);
    bottomHand.size = CGSizeMake(32, 35);
    topHand.position = CGPointMake(0, 54);
    bottomHand.position = CGPointMake(0, -34);
    [tap addChild:topHand];
    [tap addChild:bottomHand];
    
    SKAction *fadeOut= [SKAction fadeOutWithDuration:.7];
    SKAction *fadeIn = [SKAction fadeInWithDuration:.7];
    NSArray *fadeInAndOut = [NSArray arrayWithObjects:fadeOut, fadeIn, nil];
    SKAction *fadeInAndOutAction = [SKAction sequence:fadeInAndOut];
    SKAction *fadeRepeating = [SKAction repeatActionForever:fadeInAndOutAction];
    [topHand runAction:fadeRepeating];
    [bottomHand runAction:fadeRepeating];
    
}

-(void)addMenuButton{
    
    //ADD BACKGROUND OF MENU BUTTON (A TRANSPARANT RECTANGLE)
    menuBackGround = [SKSpriteNode spriteNodeWithImageNamed:@"flatborder.png"];
    menuBackGround.size = CGSizeMake(320, 52);
    menuBackGround.position = CGPointMake(160, 26);
    menuBackGround.zPosition = 99;
    [self addChild:menuBackGround];
    
    
    //CREATE ACTION TO MOVE LEFT TO RIGHT, INSTINTLY BACK LEFT, THEN REPEAT
    SKAction *moveRight = [SKAction moveByX:650 y:0 duration:5];
    SKAction *moveBack = [SKAction moveByX:-650 y:0 duration:0];
    NSArray *moveFowardThenBack = [NSArray arrayWithObjects:moveRight, moveBack, nil];
    SKAction *moveFowardThenBackAction = [SKAction sequence:moveFowardThenBack];
    SKAction *moveFowardThenBackActionRepeating = [SKAction repeatActionForever:moveFowardThenBackAction];
    
    
    //ADD A LABEL TO THE MENU BUTTON
    menuLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    menuLabel.text =@"Return to Menu";
    menuLabel.fontSize = 30;
    menuLabel.position = CGPointMake(0, -10);
    menuLabel.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    [menuBackGround addChild:menuLabel];
    
    
    //SET UP MASK EFFECT
    SKSpriteNode *mask = [SKSpriteNode spriteNodeWithImageNamed:@"block.png"]; //IMAGE TO BE PASSED TROUGHT TEXT
    mask.alpha = .8;
    mask.size = CGSizeMake(70,52);
    
    
    SKCropNode *cropping = [SKCropNode node];//ADD CROPPING NODE
    cropping.position = CGPointMake( 0, 0);//SET CROPPING TO NO OFFSET 0,0
    mask.position = CGPointMake(-160, 0);//MOVE MASK TO START OF TEXT
    [menuBackGround addChild: cropping];//ADD CROPPING TO MAIN NODE
    [cropping addChild: mask];//ADD MASK TO CROPPING
    [cropping setMaskNode: menuLabel];//SET CROPPING TO FOLLOW TEXT
    
    
    //MOVE MASK USING PREVIOUSLY CREATED ACTION
    [mask runAction:moveFowardThenBackActionRepeating];
    
}

-(void)addBoundries{
    
    bottomBoundry = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(500,10)];
    topBoundry = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(500,10)];
    
    SKSpriteNode *topBoundryNode =[SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(500,10)];
    SKSpriteNode *bottomBoundryNode =[SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(500,10)];
    
    topBoundryNode.position = CGPointMake(self.size.width/2, self.size.height + 50);
    bottomBoundryNode.position = CGPointMake(self.size.width/2, -50);
    
    topBoundryNode.physicsBody = topBoundry;
    bottomBoundryNode.physicsBody = bottomBoundry;
    
    topBoundryNode.physicsBody.dynamic = NO;
    bottomBoundryNode.physicsBody.dynamic = NO;
    
    topBoundryNode.physicsBody.categoryBitMask = obsticleCategory;
    bottomBoundryNode.physicsBody.categoryBitMask = obsticleCategory;
    
    SKPhysicsBody *limit = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(-40, 150) toPoint:CGPointMake(360, 150)];
    self.physicsBody = limit;
    
    [self addChild:topBoundryNode];
    [self addChild:bottomBoundryNode];
    
}

-(void)addRopes{
    
    
    [self addRope:CGPointMake(15, 490) endPosition:CGPointMake(150, 290) chainNumber:1 opacity:(1)];
    [self addRope:CGPointMake(305, 490) endPosition:CGPointMake(170, 290) chainNumber:2 opacity:(1)];
    [self addRope:CGPointMake(95, 535) endPosition:CGPointMake(155, 290) chainNumber:3 opacity:(1)];
    [self addRope:CGPointMake(225, 535) endPosition:CGPointMake(165, 290) chainNumber:4 opacity:(1)];
    [self addRope:CGPointMake(160, 450) endPosition:CGPointMake(160, 290) chainNumber:5 opacity:(1)];

    
}

-(void)addPipes{

  
    int randomX = arc4random()%160;
    randomX = randomX - 80;
    move = [SKAction moveByX:0 y:750 duration:7.5];
    
    SKTexture *leftBarTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"greenbarleft.png"]];
    SKTexture *rightBarTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"greenbarright.png"]];
    
    leftBar1 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarleft.png"];
    leftBar1.physicsBody = [SKPhysicsBody bodyWithTexture:leftBarTexture size:CGSizeMake(leftBar1.size.width,leftBar1.size.height)];
    leftBar1.physicsBody.dynamic = NO;
    leftBar1.physicsBody.categoryBitMask = obsticleCategory;
    leftBar1.position = CGPointMake(randomX, -110);
    leftBar1.zPosition = 0;
    
    randomX = arc4random()%160;
    randomX = randomX - 80;
    leftBar2 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarleft.png"];
    leftBar2.physicsBody = [SKPhysicsBody bodyWithTexture:leftBarTexture size:CGSizeMake(leftBar2.size.width,leftBar2.size.height)];
    leftBar2.physicsBody.dynamic = NO;
    leftBar2.physicsBody.categoryBitMask = obsticleCategory;
    leftBar2.position = CGPointMake(randomX, -300);
    leftBar2.zPosition = 0;
    
    randomX = arc4random()%160;
    randomX = randomX - 80;
    leftBar3 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarleft.png"];
    leftBar3.physicsBody = [SKPhysicsBody bodyWithTexture:leftBarTexture size:CGSizeMake(leftBar3.size.width,leftBar3.size.height)];
    leftBar3.physicsBody.dynamic = NO;
    leftBar3.physicsBody.categoryBitMask = obsticleCategory;
    leftBar3.position = CGPointMake(randomX, -490);
    leftBar3.zPosition = 0;
    
    randomX = arc4random()%160;
    randomX = randomX - 80;
    leftBar4 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarleft.png"];
    leftBar4.physicsBody = [SKPhysicsBody bodyWithTexture:leftBarTexture size:CGSizeMake(leftBar4.size.width,leftBar4.size.height)];
    leftBar4.physicsBody.dynamic = NO;
    leftBar4.physicsBody.categoryBitMask = obsticleCategory;
    leftBar4.position = CGPointMake(randomX, -680);
    leftBar4.zPosition = 0;
    
    
    
    rightBar1 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarright.png"];
    rightBar1.physicsBody = [SKPhysicsBody bodyWithTexture:rightBarTexture size:CGSizeMake(rightBar1.size.width,rightBar1.size.height)];
    rightBar1.physicsBody.dynamic = NO;
    rightBar1.physicsBody.categoryBitMask = obsticleCategory;
    rightBar1.position = CGPointMake(leftBar1.position.x+330, leftBar1.position.y);
    rightBar1.zPosition = 0;
    
    rightBar2 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarright.png"];
    rightBar2.physicsBody = [SKPhysicsBody bodyWithTexture:rightBarTexture size:CGSizeMake(rightBar2.size.width,rightBar2.size.height)];
    rightBar2.physicsBody.dynamic = NO;
    rightBar2.physicsBody.categoryBitMask = obsticleCategory;
    rightBar2.position = CGPointMake(leftBar2.position.x+330, leftBar2.position.y);
    rightBar2.zPosition = 0;
    
    rightBar3 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarright.png"];
    rightBar3.physicsBody = [SKPhysicsBody bodyWithTexture:rightBarTexture size:CGSizeMake(rightBar3.size.width,rightBar3.size.height)];
    rightBar3.physicsBody.dynamic = NO;
    rightBar3.physicsBody.categoryBitMask = obsticleCategory;
    rightBar3.position = CGPointMake(leftBar3.position.x+330, leftBar3.position.y);
    rightBar3.zPosition = 0;
    
    rightBar4 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarright.png"];
    rightBar4.physicsBody = [SKPhysicsBody bodyWithTexture:rightBarTexture size:CGSizeMake(rightBar4.size.width,rightBar4.size.height)];
    rightBar4.physicsBody.dynamic = NO;
    rightBar4.physicsBody.categoryBitMask = obsticleCategory;
    rightBar4.position = CGPointMake(leftBar4.position.x+330, leftBar4.position.y);
    rightBar4.zPosition = 0;
    
    
    
    [self addChild:leftBar1];
    [self addChild:leftBar2];
    [self addChild:leftBar3];
    [self addChild:leftBar4];
    
    [self addChild:rightBar1];
    [self addChild:rightBar2];
    [self addChild:rightBar3];
    [self addChild:rightBar4];
    
}


#pragma Run Game

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    if (gameRunning == NO){
        
        wubbles.physicsBody.dynamic = YES;
        
        [self runGame];
        
        gameRunning = YES;
        
        
    }
    else{
        
        [wubbles.physicsBody applyImpulse:CGVectorMake(0, 10)];
    }
    
}

-(void)runGame{
    
    SKAction *moveUpShort = [SKAction moveByX:0 y:300 duration:2.8];
    
    
    completeChain1 = [self childNodeWithName:@"ChainNumber1"];
    completeChain2 = [self childNodeWithName:@"ChainNumber2"];
    completeChain3 = [self childNodeWithName:@"ChainNumber3"];
    completeChain4 = [self childNodeWithName:@"ChainNumber4"];
    completeChain5 = [self childNodeWithName:@"ChainNumber5"];
    
    [completeChain1 runAction:moveUpShort completion:^{
                                                   
        [completeChain1 removeAllChildren];
        [completeChain1 removeFromParent];
        completeChain1 = nil;}];
    
    [completeChain2 runAction:moveUpShort completion:^{
        
        [completeChain2 removeAllChildren];
        [completeChain2 removeFromParent];
        completeChain2 = nil;}];
    
    [completeChain3 runAction:moveUpShort completion:^{
        
        [completeChain3 removeAllChildren];
        [completeChain3 removeFromParent];
        completeChain3 = nil;}];
    
    [completeChain4 runAction:moveUpShort completion:^{
        
        [completeChain4 removeAllChildren];
        [completeChain4 removeFromParent];
        completeChain4  = nil;}];
    
    [completeChain5 runAction:moveUpShort completion:^{
        
        [completeChain5 removeAllChildren];
        [completeChain5 removeFromParent];
        completeChain5 = nil;}];
   
    
    
    bottomLink1 = [completeChain1 childNodeWithName:[NSString stringWithFormat:@"bottomLink%i",1]];
    bottomLink1.physicsBody.affectedByGravity = YES;
    bottomLink1.physicsBody.dynamic = YES;
    
    bottomLink2 = [completeChain2 childNodeWithName:[NSString stringWithFormat:@"bottomLink%i",2]];
    bottomLink2.physicsBody.affectedByGravity = YES;
    bottomLink2.physicsBody.dynamic = YES;
    
    bottomLink3 = [completeChain3 childNodeWithName:[NSString stringWithFormat:@"bottomLink%i",3]];
    bottomLink3.physicsBody.affectedByGravity = YES;
    bottomLink3.physicsBody.dynamic = YES;
    
    bottomLink4 = [completeChain4 childNodeWithName:[NSString stringWithFormat:@"bottomLink%i",4]];
    bottomLink4.physicsBody.affectedByGravity = YES;
    bottomLink4.physicsBody.dynamic = YES;
    
    bottomLink5 = [completeChain5 childNodeWithName:[NSString stringWithFormat:@"bottomLink%i",5]];
    bottomLink5.physicsBody.affectedByGravity = YES;
    bottomLink5.physicsBody.dynamic = YES;
//
    // [self cleanUp];
    [motionManager startDeviceMotionUpdates];
    
    
    
    tap.hidden = YES;
    [self.delegate startGame];
    [background1 runAction:moveUp];
    [background2 runAction:moveUp];
    [instructionsBackground runAction:moveUp];
    [parachute runAction:moveUp];
    [menuBackGround runAction:fadeOut];
    

    
    [currentScoreBackground runAction:bringInCurrentScore];
    
    
    gameRunning = YES;
    
    
    [leftBar1 runAction:moveUp];
    [leftBar2 runAction:moveUp];
    [leftBar3 runAction:moveUp];
    [leftBar4 runAction:moveUp];
    
    speed = 0;
    acceleration = 0;
    tempScore = 1000;
    temp = 1000;
    
    accelerateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(acclerate) userInfo:nil repeats:YES];
    
    
    changeScoreTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(changeSpeed) userInfo:nil repeats:YES];
    
    accelerateScoreTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                             target:self selector:@selector(updateScore) userInfo:nil repeats:YES];
}

-(void)changeSpeed{
    
    float position = (wubbles.position.y - 150)/100;
    
    speed = speed + .01;
    
    score = 1000 - (int)speed + position;
    
    
    if (score >= 1000){
        score = 1000;
    }
    
    if (score < tempScore){
        
        currentScoreLabel.text = [NSString stringWithFormat:@"%d Feet",score];
        tempScore = score;
        
        
    }
    if (score <= 0){
        score = 0;
        tempScore = 0;
        [self gameOver];
    }
    
    
}

-(void)updateScore{
   // acceleration = acceleration + .01;
    speed = speed * 1.01;
    
    
}

-(void)acclerate{
    
    [parachute runAction:increaseSpeed];
    [menuBackGround runAction:increaseSpeed];
    [background1 runAction:increaseSpeed];
    [background2 runAction:increaseSpeed];
    [leftBar1 runAction:increaseSpeed];
    [leftBar2 runAction:increaseSpeed];
    [leftBar3 runAction:increaseSpeed];
    [leftBar4 runAction:increaseSpeed];
    [rightBar1 runAction:increaseSpeed];
    [rightBar2 runAction:increaseSpeed];
    [rightBar3 runAction:increaseSpeed];
    [rightBar4 runAction:increaseSpeed];

}

-(void)update:(CFTimeInterval)currentTime {
    
    [self updateWubblesPosition];
    
    rightBar1.position = CGPointMake(leftBar1.position.x+330, leftBar1.position.y);
    rightBar2.position = CGPointMake(leftBar2.position.x+330, leftBar2.position.y);
    rightBar3.position = CGPointMake(leftBar3.position.x+330, leftBar3.position.y);
    rightBar4.position = CGPointMake(leftBar4.position.x+330, leftBar4.position.y);
    
    
    if(background1.position.y > (self.size.height +(self.size.height/2))){
        
        background1.position = CGPointMake(background1.position.x, (0 -self.size.height/2));
    }
    else if(background2.position.y > (self.size.height +(self.size.height/2))){
        
        background2.position = CGPointMake(background2.position.x,  (0 -self.size.height/2));
    }
    if(wubbles.position.x < -12){
        
        wubbles.position = CGPointMake(372, wubbles.position.y);
    }
    else if (wubbles.position.x > 372){
        
        wubbles.position = CGPointMake(-12, wubbles.position.y);
    }
    
    
    
    
    
    
    
    
    
    
    
    if (leftBar1.position.y >= 590){
        
        if(zoneNumber ==1){
            
            int randomX = arc4random()%54;
            randomX = randomX - 80;
            
            leftBar1.position = CGPointMake(randomX, -160);
            
        }
        else if (zoneNumber ==2){
            
            int randomX = arc4random()%54;
            randomX = randomX - 25;
            
            leftBar1.position = CGPointMake(randomX, -160);
            
        }
        else{
            
            int randomX = arc4random()%54;
            randomX = randomX + 30;
            
            leftBar1.position = CGPointMake(randomX, -160);
            
        }
        
        
        zonePicker = arc4random()%10;
        zonePicker = zonePicker +1;
        
        if (zoneNumber == 1){
            
            if (zonePicker < 5){
                
                zoneNumber = 2;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 3;
            }
            else{
                
                zoneNumber = 1;
            }
        }
        else if (zoneNumber == 2){
            
            if (zonePicker < 5){
                
                zoneNumber = 1;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 3;
            }
            else{
                
                zoneNumber = 2;
            }
            
        }
        else{
            
            if (zonePicker < 5){
                
                zoneNumber = 1;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 2;
            }
            else{
                
                zoneNumber = 3;
            }
        }

    
        
    }
    else if (leftBar2.position.y >= 590){
        
        if(zoneNumber ==1){
            
            int randomX = arc4random()%54;
            randomX = randomX - 80;
            
            leftBar2.position = CGPointMake(randomX, -160);
            
        }
        else if (zoneNumber ==2){
            
            int randomX = arc4random()%54;
            randomX = randomX - 25;
            
            leftBar2.position = CGPointMake(randomX, -160);
            
        }
        else{
            
            int randomX = arc4random()%54;
            randomX = randomX + 30;
            
            leftBar2.position = CGPointMake(randomX, -160);
            
        }
        
        
        zonePicker = arc4random()%10;
        zonePicker = zonePicker +1;
        
        if (zoneNumber == 1){
            
            if (zonePicker < 5){
                
                zoneNumber = 2;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 3;
            }
            else{
                
                zoneNumber = 1;
            }
        }
        else if (zoneNumber == 2){
            
            if (zonePicker < 5){
                
                zoneNumber = 1;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 3;
            }
            else{
                
                zoneNumber = 2;
            }
            
        }
        else{
            
            if (zonePicker < 5){
                
                zoneNumber = 1;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 2;
            }
            else{
                
                zoneNumber = 3;
            }
        }
      
    }
    else if (leftBar3.position.y >= 590){
       
        if(zoneNumber ==1){
            
            int randomX = arc4random()%54;
            randomX = randomX - 80;
            
            leftBar3.position = CGPointMake(randomX, -160);
            
        }
        else if (zoneNumber ==2){
            
            int randomX = arc4random()%54;
            randomX = randomX - 25;
            
            leftBar3.position = CGPointMake(randomX, -160);
            
        }
        else{
            
            int randomX = arc4random()%54;
            randomX = randomX + 30;
            
            leftBar3.position = CGPointMake(randomX, -160);
            
        }
        
        
        zonePicker = arc4random()%10;
        zonePicker = zonePicker +1;
        
        if (zoneNumber == 1){
            
            if (zonePicker < 5){
                
                zoneNumber = 2;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 3;
            }
            else{
                
                zoneNumber = 1;
            }
        }
        else if (zoneNumber == 2){
            
            if (zonePicker < 5){
                
                zoneNumber = 1;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 3;
            }
            else{
                
                zoneNumber = 2;
            }
            
        }
        else{
            
            if (zonePicker < 5){
                
                zoneNumber = 1;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 2;
            }
            else{
                
                zoneNumber = 3;
            }
        }
       
       
    }
    else if (leftBar4.position.y >= 590){
        
        if(zoneNumber ==1){
            
            int randomX = arc4random()%54;
            randomX = randomX - 80;
            
            leftBar4.position = CGPointMake(randomX, -160);
            
        }
        else if (zoneNumber ==2){
            
            int randomX = arc4random()%54;
            randomX = randomX - 25;
            
            leftBar4.position = CGPointMake(randomX, -160);
            
        }
        else{
            
            int randomX = arc4random()%54;
            randomX = randomX + 30;
            
            leftBar4.position = CGPointMake(randomX, -160);
            
        }
        
        
        zonePicker = arc4random()%10;
        zonePicker = zonePicker +1;
        
        if (zoneNumber == 1){
            
            if (zonePicker < 5){
                
                zoneNumber = 2;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 3;
            }
            else{
                
                zoneNumber = 1;
            }
        }
        else if (zoneNumber == 2){
            
            if (zonePicker < 5){
                
                zoneNumber = 1;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 3;
            }
            else{
                
                zoneNumber = 2;
            }
            
        }
        else{
            
            if (zonePicker < 5){
                
                zoneNumber = 1;
            }
            else if (zonePicker < 10){
                
                zoneNumber = 2;
            }
            else{
                
                zoneNumber = 3;
            }
        }
       
       
    }
    

}

-(void)updateWubblesPosition{
    
    
    movement = (motionManager.deviceMotion.attitude.roll - offSet) * 6.37;
    
    if (gameRunning == NO){
        
        movement = 0;
    }
    
    SKAction *moveWubbles = [SKAction moveByX:movement y:0 duration:1/60];
    
    
    
    
    float rotateAmount = -motionManager.deviceMotion.attitude.roll + offSet;
    float rotateAmountAbs = abs(rotateAmount);
    
    SKAction *rotate = [SKAction rotateToAngle:rotateAmount duration:((rotateAmountAbs / 1.57)/.5 )];
    
    if (gameRunning == YES){
        
        [wubbles runAction:rotate];
    }
    
    
    
    [wubbles runAction:moveWubbles];
    
    
}

-(void)addCurrentScore{
    
    currentScoreBackground = [SKSpriteNode spriteNodeWithImageNamed:@"openingborder.png"];
    currentScoreBackground.position = CGPointMake(160, -160);
    currentScoreBackground.size = CGSizeMake(320, 80);
    currentScoreBackground.zPosition = 1;
    [self addChild:currentScoreBackground];
    
    currentScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    currentScoreLabel.position = CGPointMake(0,-12);
    currentScoreLabel.fontSize = 42;
    currentScoreLabel.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
    currentScoreLabel.text = @"1000 Feet";
    [currentScoreBackground addChild: currentScoreLabel];
    
    bringInCurrentScore = [SKAction moveByX:0 y:200 duration:2];
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    if ((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == obsticleCategory)){
        [self gameOver];
    
    }
    else if ((contact.bodyA.categoryBitMask == obsticleCategory) && (contact.bodyB.categoryBitMask == playerCategory)){
        [self gameOver];
      
    }
}


#pragma Game Over

-(void)gameOver{
    
    [accelerateTimer invalidate];
    [changeScoreTimer invalidate];
    [accelerateScoreTimer invalidate];
    
    
    [wubbles removeFromParent];
    [motionManager stopDeviceMotionUpdates];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"Reverse" forKey:@"mode"];
    [[NSUserDefaults standardUserDefaults] setInteger:tempScore forKey:@"awardedScore"];
    
    [self endingPlayerAnimation];
    [self.delegate endGame];
    [self stopAnimation];
    [self gameOverAnimation];
    
    [self bringInEndingScreen];
    
}

-(void)removePipes{
    
    SKAction *fadeOut2 = [SKAction fadeAlphaTo:0 duration:1];
    
    [leftBar1 runAction:fadeOut2 completion:^{[leftBar1 removeFromParent];}];
    [leftBar2 runAction:fadeOut2 completion:^{[leftBar2 removeFromParent];}];
    [leftBar3 runAction:fadeOut2 completion:^{[leftBar3 removeFromParent];}];
    [leftBar4 runAction:fadeOut2 completion:^{[leftBar4 removeFromParent];}];
    
    [rightBar1 runAction:fadeOut2 completion:^{[rightBar1 removeFromParent];}];
    [rightBar2 runAction:fadeOut2 completion:^{[rightBar2 removeFromParent];}];
    [rightBar3 runAction:fadeOut2 completion:^{[rightBar3 removeFromParent];}];
    [rightBar4 runAction:fadeOut2 completion:^{[rightBar4 removeFromParent];}];
    
    
}

-(void)addEndingScreen{
    
    
    gameOverBackground = [SKSpriteNode spriteNodeWithImageNamed:@"bg.png"];
    gameOverBackground.size = CGSizeMake(300, 289);
    gameOverBackground.position = CGPointMake(160, 852);
    gameOverBackground.zPosition = 99;
    
    
    gameOverLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    gameOverLabel1.text =@"You Win!";
    gameOverLabel1.fontSize = 45;
    gameOverLabel1.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    gameOverLabel1.position = CGPointMake(0, 90);
    
    
    gameOverLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    gameOverLabel2.text =@"Game Over!";
    gameOverLabel2.fontSize = 45;
    gameOverLabel2.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    gameOverLabel2.position = CGPointMake(0, 90);
    
    
    
    newHighScore = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    newHighScore.text =[NSString stringWithFormat:@"NEW BEST SCORE"];
    newHighScore.fontSize = 30;
    newHighScore.fontColor = [SKColor colorWithRed:.43 green:.78 blue:.90 alpha:.9];
    newHighScore.position = CGPointMake(0, -70);
    
    
    
    bestLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    bestLabel.text =[NSString stringWithFormat:@"Best: 0"];
    bestLabel.fontSize = 34;
    bestLabel.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    bestLabel.position = CGPointMake(60, -80);
    
    
    
    yourScore = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    yourScore.fontSize = 85;
    yourScore.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
    yourScore.text = @"1000 ft";
    yourScore.position = CGPointMake(0, -15);
    
    
    
    [self addChild:gameOverBackground];
    [gameOverBackground addChild:bestLabel];
    [gameOverBackground addChild:gameOverLabel1];
    [gameOverBackground addChild:gameOverLabel2];
    [gameOverBackground addChild:yourScore];
    
    
    
    
    
    
    textEffect =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Text Effect" ofType:@"sks"]];
    cropping2 = [SKCropNode node];//ADD CROPPING NODE
    cropping2.position = CGPointMake(0,0);
    textEffect.position= CGPointMake(newHighScore.position.x, newHighScore.position.y);
    
    [gameOverBackground addChild: cropping2];//ADD CROPPING TO MAIN NODE
    [cropping2 addChild: textEffect];//ADD MASK TO CROPPING
    [cropping2 setMaskNode: newHighScore];//SET CROPPING TO FOLLOW TEXT
    
    
}

-(void)bringInEndingScreen{
    
    topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"TopScoreReverse"];
    awardedScore =[[NSUserDefaults standardUserDefaults] integerForKey:@"awardedScore"];
    
    gameOverBackground.position = CGPointMake(160, -285);
    menuBackGround.position = CGPointMake(gameOverBackground.position.x, self.size.height - 46);
    
    menuBackGround.hidden = NO;
    
    SKAction *bringInGameOverScreen1 = [SKAction moveByX:0 y:+568 duration:1.89];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:.5];
    
    if (awardedScore < topScore){
        
        gameOverLabel1.hidden = NO;
        gameOverLabel2.hidden = YES;
        newHighScore.hidden = YES;
        bestLabel.hidden = YES;
        
    }
    else{
        
        gameOverLabel1.hidden = YES;
        gameOverLabel2.hidden = NO;
        newHighScore.hidden = YES;
        bestLabel.hidden = NO;
        bestLabel.text =[NSString stringWithFormat:@"Best: %i",topScore];
    }
    
    
    
    [gameOverBackground runAction:bringInGameOverScreen1 completion:^{
        
        [self.delegate enableButtons];
        [self updateScoreCycle:awardedScore];
        
        [menuBackGround runAction:fadeIn completion:^{
            
            
        }];

    
    }];
    
  
    
    
    
}

-(void)updateScoreCycle:(int)awardedScore{
    
    
    if (awardedScore >= 970){
        
        updateScoreTimer1 = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateScoreRepeating) userInfo:nil repeats:YES];
        
    }
    else{
        
       float  num = (float)3/(1000-(float)awardedScore);
        updateScoreTimer2 = [NSTimer scheduledTimerWithTimeInterval:num target:self selector:@selector(updateScoreRepeating) userInfo:nil repeats:YES];
        
    }
}

-(void)updateScoreRepeating{
    
    awardedScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"awardedScore"];
    
    if (awardedScore == 1000){
        [updateScoreTimer1 invalidate];
        [updateScoreTimer2 invalidate];
        
    }
    else{
        
        temp = temp - 1;
        
        
        NSString *label = [NSString stringWithFormat:@"%i ft",temp];
        yourScore.text = label;
        
        
        
        
        
        if (temp == awardedScore){
            
            [updateScoreTimer1 invalidate];
            [updateScoreTimer2 invalidate];
            
        }
        if ((temp < topScore) && (temp <= awardedScore)){
            
            newHighScore.hidden = NO;
            [updateScoreTimer1 invalidate];
            [updateScoreTimer2 invalidate];
            
            [self setScore];
            [self updateInstructions];
        }
        
    }
}

-(void)setScore{
    
    topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"TopScoreReverse"];
    
    if (awardedScore < topScore){
        
        [[NSUserDefaults standardUserDefaults] setInteger:awardedScore forKey:@"TopScoreReverse"];
        
    }
    
}

-(void)updateInstructions{
    topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"TopScoreReverse"];
    
    highScoreIntro.text =[NSString stringWithFormat:@"Best Score: %i", topScore];
    
    
}

-(void)endingPlayerAnimation{
    
    SKSpriteNode *endingWubbles = [SKSpriteNode spriteNodeWithImageNamed:@"wubblesblue.png"];
    endingWubbles.size = wubbles.size;
    endingWubbles.position = wubbles.position;
    
    [wubbles removeFromParent];
    [self addChild:endingWubbles];
    
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(0.5, 0.67)];
    [bezierPath addCurveToPoint: CGPointMake(16.66, 58.5) controlPoint1: CGPointMake(0.5, 0.67) controlPoint2: CGPointMake(0.99, 58.5)];
    [bezierPath addCurveToPoint: CGPointMake(94.5, -634.5) controlPoint1: CGPointMake(32.32, 58.5) controlPoint2: CGPointMake(48.48, -28.74)];
    
    SKAction *endingWubblesAction = [SKAction followPath:bezierPath.CGPath duration:2];
    [endingWubbles runAction:endingWubblesAction completion:^{
        
    [self removePipes];
    [endingWubbles removeFromParent];
        
    }];
    
}

-(void)stopAnimation{
    
    [background1 removeAllActions];
    [background2 removeAllActions];
    [currentScoreBackground removeAllActions];
    [instructionsBackground removeAllActions];
    [menuBackGround removeAllActions];
    
//    [leftBar1 removeAllActions];
//    [leftBar2 removeAllActions];
//    [leftBar3 removeAllActions];
//    [leftBar4 removeAllActions];
//    
//    [rightBar1 removeAllActions];
//    [rightBar2 removeAllActions];
//    [rightBar3 removeAllActions];
//    [rightBar4 removeAllActions];
    
    
}

-(void)gameOverAnimation{
    
    SKAction *moveUpFast = [SKAction moveByX:0 y:+600 duration:2];
    [instructionsBackground runAction:moveUpFast];
    [currentScoreBackground runAction:moveUpFast completion:^{
        
        [currentScoreBackground removeFromParent];
        
    }];

    
    
}

-(void)addRope:(CGPoint)startPosition endPosition:(CGPoint)endPosition chainNumber:(int)chainNumber opacity:(float)opacity{
    
    SKNode *completeChain = [SKNode node];
    completeChain.name = [NSString stringWithFormat:@"ChainNumber%i",chainNumber];
    [self addChild:completeChain];
    
    //First Anchor
    SKSpriteNode *startAnchor = [SKSpriteNode spriteNodeWithImageNamed:@"chainClosed.png"];
    startAnchor.position = CGPointMake(startPosition.x, startPosition.y);
    startAnchor.size = CGSizeMake(12, 12);
    startAnchor.alpha = opacity;
    startAnchor.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:3];
    startAnchor.physicsBody.affectedByGravity = NO;
    startAnchor.physicsBody.dynamic = NO;
    [completeChain addChild:startAnchor];
    
    
    //Calculate Number of Links
    float xDist = endPosition.x - startPosition.x;
    float yDist = endPosition.y - startPosition.y;
    float hDist = sqrt((xDist * xDist) + (yDist * yDist));
    numOfLinks = (int)(hDist / 6);
    
    float xDistIndiv = xDist / numOfLinks;
    float yDistIndiv = yDist / numOfLinks;;
    
    
    
    //add RopeElements
    for (int i=0; i < numOfLinks; i++)
    {
        
        
        SKSpriteNode *link = [SKSpriteNode spriteNodeWithImageNamed:@"chainClosedbrown.png"];
        
        if (i == numOfLinks - 1){
        
            link.name = [NSString stringWithFormat:@"bottomLink%i", chainNumber];
            link.position = CGPointMake((endPosition.x),(endPosition.y));
            link.size = CGSizeMake(7, 7);
            link.alpha = opacity;
            link.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:2.25];
            link.physicsBody.affectedByGravity = NO;
            link.physicsBody.dynamic = NO;
            link.physicsBody.linearDamping = 3;
            [completeChain addChild:link];
            
        }
        
        else{
            link.name = [NSString stringWithFormat:@"linkItem%d", i];
            link.position = CGPointMake((startPosition.x + (i * xDistIndiv)), (startPosition.y + (i * yDistIndiv)));
            link.size = CGSizeMake(7, 7);
            link.alpha = opacity;
            link.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:2.25];
            link.physicsBody.affectedByGravity = YES;
            link.physicsBody.dynamic = YES;
            link.physicsBody.linearDamping = 3;
            [completeChain addChild:link];
            
        }
        
        
        
        
        //Add Joint to the element before
        SKPhysicsBody *lastBody;
        if (i == 0){
            lastBody = startAnchor.physicsBody;
        }
        else{
            lastBody = [completeChain childNodeWithName:[NSString stringWithFormat:@"linkItem%d", i-1]].physicsBody;
        }
        
        SKPhysicsJointLimit *limit;
        
        limit = [SKPhysicsJointLimit jointWithBodyA:lastBody
                                              bodyB:link.physicsBody
                                              anchorA:CGPointMake(lastBody.node.position.x, lastBody.node.position.y)
                                              anchorB:CGPointMake(link.position.x, link.position.y)];
        
        
        
        limit.maxLength = 4.5;
        
        
        [self.physicsWorld addJoint:limit];
        
    }
    

    
}


#pragma reset methods

-(void)resetPlacement{
    
    
    instructionsBackground.position = CGPointMake(160, -146);
    
    
    
}

-(void)resetAnimation{
    
    SKAction *moveUpFast = [SKAction moveByX:0 y:568 duration:1.89];
    SKAction *moveUpFastPart1 = [SKAction moveByX:0 y:100 duration:.33];
    SKAction *moveUpFastPart2 = [SKAction moveByX:0 y:468 duration:1.55];
    
    
    
    [gameOverBackground runAction:moveUpFast completion:^{yourScore.text =@"1000 ft";}];
    
    [menuBackGround runAction:moveUpFastPart1 completion:^{
        
        [menuBackGround removeFromParent];
        [self addMenuButton];
        menuBackGround.position = CGPointMake(160, -442);
        [menuBackGround runAction:moveUpFastPart2 completion:^{
            
            
        }
         ];
    }];
    
    [instructionsBackground runAction:moveUpFast completion:^{
        
        [self addContent];
        gameRunning = NO;
        
        [self.delegate resetGame];
        
    }];
    
    
    
    
}

-(void)cleanUp{
    
    
    awardedScore = 1000;
    temp = 1000;
 
}

-(void)addContent{
    
    
    [self addCurrentScore];
    [self addWubbles];
    [self addHands];
    [self addParachute];
    [self addPipes];
    
    
    
}


#pragma delegate methods

-(void)resetScene{
    
    
    
    [self resetPlacement];
    [self resetAnimation];
    
    
    
}

-(void)addTestObject{
    
    SKSpriteNode *testNode = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(320, 40)];
    testNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    [self addChild:testNode];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self]; // USED TO RELEASE SELF WHEN VIEW IS RELOADED
    [motionManager stopDeviceMotionUpdates];
    motionManager = nil;
    gameRunning = NO;
    
    
}

@end
