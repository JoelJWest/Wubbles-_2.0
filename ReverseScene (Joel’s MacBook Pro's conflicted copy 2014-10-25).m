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


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        
        self.physicsWorld.contactDelegate = self;
        
     

        
        [self addBackground];
        [self addMenuButton];
           [self addRopes];
        [self addParachute];
        [self addInstructions];
     
        [self addWubbles];
        [self addHands];
        [self addMotionManager];
        [self addBoundries];
        [self addCurrentScore];
        [self addEndingScreen];
        offSet = [[NSUserDefaults standardUserDefaults] floatForKey:@"OffSet"];
        
        temp = 1000;
     
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
    parachute = [SKSpriteNode spriteNodeWithImageNamed:@"parachute.png"];
    parachute.position = CGPointMake(160, self.size.height + 17);
    parachute.size = CGSizeMake(290, 147);
    parachute.alpha = 1;
    [self addChild:parachute];
    
    
}

-(void)addInstructions{
    
    NSString *scoreBorder =@"openingborder.png";
    instructionsBackground = [SKSpriteNode spriteNodeWithImageNamed:scoreBorder];
    instructionsBackground.size = CGSizeMake(320, 200);
    instructionsBackground.position = CGPointMake(160, 422);
    instructionsBackground.alpha = 1;
    
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
    tap.position = CGPointMake(160, 150);
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
    
    [self addChild:topBoundryNode];
    [self addChild:bottomBoundryNode];
    
}

-(void)addRopes{
    
    
    [self addRope:CGPointMake(22, 518) endPosition:CGPointMake(150, 290)];
    
    
}

-(void) addRopeJointItems:(CGPoint)leftStartPosition
       countJointElements:(int)countJointElements
                     game:(SKScene*)game {
    
    int itemJointWidth = 25;
    
    //Left Physics Anchor
    SKSpriteNode * leftAnchor = [SKSpriteNode spriteNodeWithImageNamed:@"Ruler.png"];
    leftAnchor.position = CGPointMake(leftStartPosition.x, leftStartPosition.y);
    leftAnchor.size = CGSizeMake(1, 1);
    leftAnchor.zPosition = 2;
    leftAnchor.physicsBody = [SKPhysicsBody
                              bodyWithRectangleOfSize:
                              leftAnchor.size];
    leftAnchor.physicsBody.affectedByGravity = false;
    leftAnchor.physicsBody.mass = 99999999999;
    [game addChild:leftAnchor];
    
    
    //add RopeElements
    for (int i=0; i<countJointElements; i++) {
        
        SKSpriteNode * item = [SKSpriteNode spriteNodeWithImageNamed:@"suspensionrope.png"];
        item.name = [NSString stringWithFormat:@"ropeitem_%d", i];
        item.position = CGPointMake(leftStartPosition.x + (i*itemJointWidth) + itemJointWidth/2, leftStartPosition.y+60);
        item.size = CGSizeMake(itemJointWidth + 5, 5);
        item.zPosition = 2;
        item.physicsBody = [SKPhysicsBody
                            bodyWithRectangleOfSize:
                            item.size];
        item.physicsBody.categoryBitMask = kNilOptions;
        [game addChild:item];
        
        //Add Joint to the element before
        SKPhysicsBody* bodyA;
        if (i == 0) {
            bodyA = leftAnchor.physicsBody;
        } else {
            bodyA = [game childNodeWithName:[NSString stringWithFormat:@"ropeitem_%d", i-1]].physicsBody;
        }
        
        SKPhysicsJointPin* joint = [SKPhysicsJointPin jointWithBodyA:bodyA bodyB:item.physicsBody anchor:CGPointMake((item.position.x - item.size.width/2) + 5, item.position.y)];
        [game.physicsWorld addJoint:joint];
    }
    
    //Right Physics Anchor
    SKSpriteNode * rightAnchor = [SKSpriteNode spriteNodeWithImageNamed:@"dummypixel_transparent.png"];
    rightAnchor.position = CGPointMake((leftStartPosition.x + (countJointElements*itemJointWidth)),
                                       leftStartPosition.y+60);
    rightAnchor.size = CGSizeMake(1, 1);
    rightAnchor.zPosition = 2;
    rightAnchor.physicsBody = [SKPhysicsBody
                               bodyWithRectangleOfSize:
                               rightAnchor.size];
    rightAnchor.physicsBody.affectedByGravity = false;
    rightAnchor.physicsBody.mass = 99999999999;
    [game addChild:rightAnchor];
    
    //Add the Last Joint
    SKPhysicsJointPin* jointLast = [SKPhysicsJointPin jointWithBodyA:[game childNodeWithName:[NSString stringWithFormat:@"ropeitem_%d", countJointElements - 1]].physicsBody
                                                               bodyB:rightAnchor.physicsBody
                                                              anchor:rightAnchor.position];
    [game.physicsWorld addJoint:jointLast];
    
}

#pragma Run Game

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [wubbles.physicsBody applyImpulse:CGVectorMake(0, 10)];
    
    if (gameRunning == NO){
        
        [self runGame];
        
    }
    
}

-(void)runGame{
    
    // [self cleanUp];
    [motionManager startDeviceMotionUpdates];
    
    SKNode *bottomNode = [self childNodeWithName:[NSString stringWithFormat:@"linkItem%d", numOfLinks - 1]];
    bottomNode.physicsBody.affectedByGravity = YES;
    
    tap.hidden = YES;
    [self.delegate startGame];
    [background1 runAction:moveUp];
    [background2 runAction:moveUp];
    [instructionsBackground runAction:moveUp];
    [parachute runAction:moveUp];
    [menuBackGround runAction:fadeOut];
    
    
    wubbles.physicsBody.dynamic = YES;
    [wubbles.physicsBody applyImpulse:CGVectorMake(0, 10)];
    
    [currentScoreBackground runAction:bringInCurrentScore];
    
    
    gameRunning = YES;
    //updateScore = YES;
    //-32
    
    //[self addPipes];
    
    //    [leftBar1 runAction:move1 completion:^{ [self replaceBar:leftBar1]; }];
    //    [leftBar2 runAction:move2 completion:^{ [self replaceBar:leftBar2]; }];
    //    [leftBar3 runAction:move3 completion:^{ [self replaceBar:leftBar3]; }];
    //    [leftBar4 runAction:move4 completion:^{ [self replaceBar:leftBar4]; }];
    
    speed = 0;
    acceleration = 0;
    tempScore = 10000;
    
    accelerateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(acclerate) userInfo:nil repeats:YES];
    
    
    changeScoreTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(changeSpeed) userInfo:nil repeats:YES];
    
    accelerateScoreTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                             target:self selector:@selector(updateScore) userInfo:nil repeats:YES];
}

-(void)changeSpeed{
    
    float position = (wubbles.position.y - 200)/100;
    speed = speed + .01;
    score = 1000 - (int)speed + position;
    
    if (score < tempScore){
        
        currentScoreLabel.text = [NSString stringWithFormat:@"%d Feet",score];
        tempScore = score;
        
    }
    
    
}

-(void)updateScore{
    
    speed = speed + acceleration;
    acceleration = acceleration + .01;
    
}

-(void)acclerate{
    
    [parachute runAction:increaseSpeed];
    [menuBackGround runAction:increaseSpeed];
    [background1 runAction:increaseSpeed];
    [background2 runAction:increaseSpeed];
    
}

-(void)update:(CFTimeInterval)currentTime {
    
    [self updateWubblesPosition];
    
//    rightBar1.position = CGPointMake(leftBar1.position.x+330, leftBar1.position.y);
//    rightBar2.position = CGPointMake(leftBar2.position.x+330, leftBar2.position.y);
//    rightBar3.position = CGPointMake(leftBar3.position.x+330, leftBar3.position.y);
//    rightBar4.position = CGPointMake(leftBar4.position.x+330, leftBar4.position.y);
    
    
//    if (updateScore == YES){
//        
//        [self updateScore];
//    }
    
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
    
    if (wubbles.position.y < 200){
        
        wubbles.position = CGPointMake(wubbles.position.x, 200);
    }
}

- (void)updateWubblesPosition{
    
    float rotation = 0;
    
    
    if (offSet < -1.75){
        
        if (motionManager.deviceMotion.attitude.roll > 1.75) {
            
            rotation = -((motionManager.deviceMotion.attitude.roll - 3.14)-(offSet+3.14)) ;
            
        }
        else if (motionManager.deviceMotion.attitude.roll < -1.75){
            
            rotation = -((motionManager.deviceMotion.attitude.roll + 3.14)-(offSet+3.14));
            
        }
    }
    else if (offSet > 1.75){
        
        if (motionManager.deviceMotion.attitude.roll > 1.75) {
            
            rotation = -((motionManager.deviceMotion.attitude.roll - 3.14)-(offSet-3.14)) ;
            
        }
        else if (motionManager.deviceMotion.attitude.roll < -1.75){
            
            rotation = -((motionManager.deviceMotion.attitude.roll + 3.14)-(offSet-3.14));
            
        }
    }
    else{
        
        rotation = motionManager.deviceMotion.attitude.roll - offSet;
    }
    
    
    
    movement = rotation * 6.37;
    
    if (gameRunning == NO){
        
        movement = 0;
    }
    
    
    SKAction *moveWubbles = [SKAction moveByX:movement y:0 duration:1/60];
    
    
    
    
    
    
    
    float rotateAmount = -motionManager.deviceMotion.attitude.roll + offSet;
    float rotateAmountAbs = abs(rotateAmount);
    
    if ((offSet < -1.75) || (offSet > 1.75)){
        
        
        if (motionManager.deviceMotion.attitude.roll > 0) {
            
            rotateAmount = -(3.14-motionManager.deviceMotion.attitude.roll);
            rotateAmountAbs = abs(rotateAmount);
            
            
        }
        else if (motionManager.deviceMotion.attitude.roll <= 0){
            
            rotateAmount = (-3.14-motionManager.deviceMotion.attitude.roll);
            rotateAmount = -rotateAmount;
            rotateAmountAbs = abs(rotateAmount);
            
        }
        
        
    }
}

-(void)addCurrentScore{
    
    currentScoreBackground = [SKSpriteNode spriteNodeWithImageNamed:@"openingborder.png"];
    currentScoreBackground.position = CGPointMake(160, -155);
    currentScoreBackground.size = CGSizeMake(320, 80);
    currentScoreBackground.zPosition = 1;
    [self addChild:currentScoreBackground];
    
    currentScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    currentScoreLabel.position = CGPointMake(0,-12);
    currentScoreLabel.fontSize = 42;
    currentScoreLabel.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
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
    
    
    [self endingPlayerAnimation];
    [self.delegate endGame];
    [self stopAnimation];
    [self gameOverAnimation];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"Reverse" forKey:@"mode"];
    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"awardedScore"];
    
    [self bringInEndingScreen];
    
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
    newHighScore.text =[NSString stringWithFormat:@"NEW HIGH SCORE"];
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
    yourScore.text = @"0 ft";
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
    if (awardedScore > topScore){
        
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
        
        NSString *label = [NSString stringWithFormat:@""];
        label = [NSString stringWithFormat:@"%i ft",temp];
        yourScore.text = label;
        
        
        
        
        
        if (temp == awardedScore){
            
            [updateScoreTimer1 invalidate];
            [updateScoreTimer2 invalidate];
            
        }
        if ((temp < topScore)&& (temp <= awardedScore)){
            
            newHighScore.hidden = NO;
            [updateScoreTimer1 invalidate];
            [updateScoreTimer2 invalidate];
            
//            [self setScore];
//            [self updateInstructions];
        }
        
    }
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
        
//        [self removePipes];
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

-(void)addRope:(CGPoint)startPosition endPosition:(CGPoint)endPosition


{
    
    //First Anchor
    SKSpriteNode *startAnchor = [SKSpriteNode spriteNodeWithImageNamed:@"Chain.png"];
    startAnchor.position = CGPointMake(startPosition.x, startPosition.y);
    startAnchor.size = CGSizeMake(5, 5);
    startAnchor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: startAnchor.size];
    startAnchor.physicsBody.affectedByGravity = false;
    startAnchor.physicsBody.mass = 99999999999;
    [self addChild:startAnchor];
    
    
    //Calculate Number of Links
    int xDist = endPosition.x - startPosition.x;
    int yDist = endPosition.y - startPosition.y;
    int hDist = sqrt((xDist * xDist) + (yDist * yDist));
    numOfLinks = hDist / 5;
    
    int xDistIndiv = xDist / numOfLinks;
    int yDistIndiv = yDist / numOfLinks;
    
    SKPhysicsJointLimit *limit;
    
    //add RopeElements
    for (int i=0; i < numOfLinks; i++)
    {
        
        SKSpriteNode *link = [SKSpriteNode spriteNodeWithImageNamed:@"Chain.png"];
        
        if (i == numOfLinks - 1){
        
        link.name = [NSString stringWithFormat:@"linkItem%d", i];
        link.position = CGPointMake((endPosition.x),(endPosition.y));
        link.size = CGSizeMake(5, 5);
        link.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:link.size];
        link.physicsBody.mass = 9;
        link.physicsBody.affectedByGravity = NO;
        [self addChild:link];
            
        }
        
        else{
        link.name = [NSString stringWithFormat:@"linkItem%d", i];
        link.position = CGPointMake((startPosition.x + (i * xDistIndiv)), (startPosition.y + (i * yDistIndiv)));
        link.size = CGSizeMake(5, 5);
        link.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:link.size];
        link.physicsBody.affectedByGravity = YES;
        [self addChild:link];
            
        }
        
        
        //Add Joint to the element before
        SKPhysicsBody *lastBody;
        if (i == 0){
            lastBody = startAnchor.physicsBody;
        }
        else{
            lastBody = [self childNodeWithName:[NSString stringWithFormat:@"linkItem%d", i-1]].physicsBody;
        }
        
        limit = [SKPhysicsJointLimit jointWithBodyA:lastBody
                                              bodyB:link.physicsBody
                                              anchorA:CGPointMake(lastBody.node.position.x, lastBody.node.position.y)
                                              anchorB:CGPointMake(link.position.x, link.position.y)];
        
        limit.maxLength = (hDist / numOfLinks);
        
        
        [self.physicsWorld addJoint:limit];
    
    }
    

    
}

@end
