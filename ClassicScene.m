//
//  ClassicScene.m
//  Wubbles! 2.0
//
//  Created by Joel West on 8/27/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import "ClassicScene.h"
#import "ViewController.h"
@interface ClassicScene ()



@end

static const uint32_t playerCategory = 0x1;
static const uint32_t obsticleCategory = 0x1 << 1;
static const uint32_t itemCategory = 0x1 << 2;




@implementation ClassicScene
@synthesize delegate = delegate;
@synthesize moveDown = moveDown;
@synthesize background1 = background1;
@synthesize background2 = background2;
@synthesize wubbles = wubbles;
@synthesize topBoundry = topBoundry;
@synthesize bottomBoundry = bottomBoundry;
@synthesize currentScoreBorder = currentScoreBorder;
@synthesize instructionsBackground = instructionsBackground;
@synthesize instructions = instructions;
@synthesize motionManager = motionManager;
@synthesize horizontalMovment = horizontalMovement;
@synthesize highScoreIntro = highScoreIntro;
@synthesize currentScoreBackground = currentScoreBackground;
@synthesize currentScoreLabel = currentScoreLabel;
@synthesize bringInCurrentScore = bringInCurrentScore;
@synthesize hill = hill;
@synthesize tap = tap;
@synthesize topHand = topHand;
@synthesize bottomHand = bottomHand;
@synthesize flash = flash;
@synthesize menuBackGround = menuBackGround;
@synthesize menuLabel = menuLabel;
@synthesize gameOverBackground = gameOverBackground;


#pragma Initilization Methods

BOOL gameRunning;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self;
        
        virticleMovementFromScrolling = 0;
        currentScoreValue = 0;
        
        
        [self updateScore];
        [self addBackground];
        [self addInstructions];
        [self addCurrentScore];
        [self addBoundries];
        [self addMoveDownAnimation];
        [self addWubbles];
        [self addHands];
        [self addMenuButton];
        
        
        //USED TO ADD TEST OBJECTS
        //[self addTestObjects];
        
        
        // BOOL USED TO DECLARE IF THE GAME IS CURRENTLY RUNNING
        gameRunning = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self]; // USED TO RELEASE SELF WHEN VIEW IS RELOADED
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetScene) name:@"ResetGame" object:nil];

    }
    return self;
}

-(void)addTestObjects{
    
    SKSpriteNode *testBox = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(200, 50)];
    testBox.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    SKPhysicsBody *testPhysicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(200, 50) center:CGPointMake(self.size.width/2, self.size.height/2)];
    
    testBox.physicsBody = testPhysicsBody;
    testBox.physicsBody.dynamic = NO;
    
    testBox.physicsBody.categoryBitMask = obsticleCategory;
    
    [self addChild:testBox];
    
    
}

-(void)addMenuButton{
    
    //ADD BACKGROUND OF MENU BUTTON (A TRANSPARANT RECTANGLE)
    menuBackGround = [SKSpriteNode spriteNodeWithImageNamed:@"flatborder.png"];
    menuBackGround.size = CGSizeMake(320, 52);
    menuBackGround.position = CGPointMake(160, 26);
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

-(void)addHands{
    
    tap = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    tap.fontSize = 36;
    tap.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    tap.text = @"Tap!";
    tap.position = CGPointMake(160, 210);
    
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


-(void)addCurrentScore{
    
    currentScoreBackground = [SKSpriteNode spriteNodeWithImageNamed:@"openingborder.png"];
    currentScoreBackground.position = CGPointMake(160, 703);
    currentScoreBackground.size = CGSizeMake(320, 80);
    
    [self addChild:currentScoreBackground];
    
    currentScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    currentScoreLabel.position = CGPointMake(0,-12);
    currentScoreLabel.fontSize = 42;
    currentScoreLabel.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
    
    [currentScoreBackground addChild: currentScoreLabel];
    
    bringInCurrentScore = [SKAction moveByX:0 y:-200 duration:2];
    
}

-(void)removeMotionSensor{
    
    motionManager.accelerometerUpdateInterval = 0;
    
}
-(void)addMotionSensor{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0/800.0;
    NSOperationQueue *queue = [NSOperationQueue currentQueue];
    [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
     {
         CMAcceleration acceleration = accelerometerData.acceleration;
         
         float playerMovement = acceleration.x * 10;
         
         if (acceleration.x < -.33){
             
             wubbles.position = CGPointMake(wubbles.position.x + playerMovement, wubbles.position.y);

         }
         else if (acceleration.x >.33){
             
             wubbles.position = CGPointMake(wubbles.position.x + playerMovement, wubbles.position.y);

         }
         else{
             
             wubbles.position = CGPointMake(wubbles.position.x + playerMovement, wubbles.position.y);
             
         }
     }
     ];
}


-(void)horizontalMovement:(CMAcceleration)accelerometerData{
    
    if(accelerometerData.x < -.66){
        
          wubbles.position = CGPointMake(wubbles.position.x -3, wubbles.position.y);
    }
    else if(accelerometerData.x > .66){
        
          wubbles.position = CGPointMake(wubbles.position.x + 3, wubbles.position.y);
    }
    
}


-(void)addInstructions{
    NSString *scoreBorder =@"openingborder.png";
    instructionsBackground = [SKSpriteNode spriteNodeWithImageNamed:scoreBorder];
    instructionsBackground.size = CGSizeMake(320, 200);
    instructionsBackground.position = CGPointMake(160, 422);
    instructionsBackground.alpha = 1;
    
    

    
    instructions.position = CGPointMake(160, 458);
    
    [self addChild:instructionsBackground];
    
    SKLabelNode *gameTitle = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    gameTitle.text =@"Classic";
    gameTitle.fontSize = 39;
    gameTitle.position = CGPointMake(0, 57);
    gameTitle.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];

    [instructionsBackground addChild:gameTitle];
    
    SKLabelNode *line1 = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    line1.text =@"Keep tapping to fly";
    line1.fontSize = 26;
    line1.position = CGPointMake(0, 25);
    line1.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    
    [instructionsBackground addChild:line1];
    
    SKLabelNode *line2 = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    line2.text =@"Wubbles. Tilt your device";
    line2.fontSize = 26;
    line2.position = CGPointMake(0, -5);
    line2.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    
    [instructionsBackground addChild:line2];
    
    SKLabelNode *line3 = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    line3.text =@"to avoid the obsticles.";
    line3.fontSize = 26;
    line3.position = CGPointMake(0, -35);
    line3.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    
    [instructionsBackground addChild:line3];
    
    highScoreIntro = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    highScoreIntro.text =@"High Score: 300";
    highScoreIntro.fontSize = 35;
    highScoreIntro.position = CGPointMake(0, -78);
    highScoreIntro.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
    
    [instructionsBackground addChild:highScoreIntro];

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

-(void)addBackground{
    
    NSString *backgroundImage1 = @"bluesky.png";
    NSString *backgroundImage2 = @"bluesky2.png";
    
    background1 = [SKSpriteNode spriteNodeWithImageNamed:backgroundImage1];
    background2 = [SKSpriteNode spriteNodeWithImageNamed:backgroundImage2];
    
    background1.position = CGPointMake(self.size.width/2, 0);
    background2.position = CGPointMake(self.size.width/2, self.size.height);
    
    hill = [SKSpriteNode spriteNodeWithImageNamed:@"hill.png"];
    hill.position = CGPointMake(160, 92);
    hill.size = CGSizeMake(320, 229);
    
 
    [self addChild:background1];
    [self addChild:background2];
    [self addChild:hill];
    
}

-(void)addMoveDownAnimation{
    
    int moveDownSpeed = -100;
    
    SKAction *moveDownInit = [SKAction moveByX:0 y:moveDownSpeed duration:1];
    moveDown = [SKAction repeatActionForever:moveDownInit];
    
}

-(void)addWubbles{
    
    NSString *wubblesImage =@"wubblesblue.png";
    wubbles = [SKSpriteNode spriteNodeWithImageNamed:wubblesImage];
    wubbles.size = CGSizeMake(40, 40);
    wubbles.position = CGPointMake(160, 110);
    wubbles.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
    wubbles.physicsBody.mass = .01;
    wubbles.physicsBody.linearDamping =8;
    wubbles.physicsBody.dynamic=NO;
    wubbles.physicsBody.categoryBitMask = playerCategory;
    wubbles.physicsBody.contactTestBitMask = obsticleCategory | itemCategory;
    
    
    [self addChild:wubbles];
}

-(void)runGame{
    
        tap.hidden = YES;
        [self.delegate startGame];
        [self addMotionSensor];
        [background1 runAction:moveDown];
        [background2 runAction:moveDown];
        [instructionsBackground runAction:moveDown];
        [hill runAction:moveDown];
        [menuBackGround runAction:moveDown];
        [currentScoreBackground runAction:bringInCurrentScore];
    
        wubbles.physicsBody.dynamic = YES;
        [wubbles.physicsBody applyImpulse:CGVectorMake(0, 10)];
    
    
       virticleMovmentFromScrolling = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseScore) userInfo:nil repeats:YES];
    
        gameRunning = YES;
    
}

-(void)increaseScore{
    
    virticleMovementFromScrolling = virticleMovementFromScrolling + 1;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [wubbles.physicsBody applyImpulse:CGVectorMake(0, 10)];
    
    if (gameRunning == NO){
        
    [self runGame];
        
    }
    

    
}

-(void)updateScore{
    
    virticleMovementFromFlapping = ((wubbles.position.y - 110)/100);
    currentScoreValue = virticleMovementFromFlapping + virticleMovementFromScrolling;
    
    NSString *currentUnit =@"Feet";
    if (currentScoreValue == 1){
        currentUnit =@"Foot";
    }
    
    if (currentScoreValue == 0){
        
    currentScoreLabel.text =[NSString stringWithFormat:@"%i %@!",currentScoreValue,currentUnit];
    tempScore = currentScoreValue;
        
    }
    else if (currentScoreValue > tempScore){
        
    currentScoreLabel.text =[NSString stringWithFormat:@"%i %@!",currentScoreValue,currentUnit];
    tempScore = currentScoreValue;
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    [self updateScore];

    
    if(background1.position.y<-(self.size.height/2)){
        
        background1.position = CGPointMake(background1.position.x, self.size.height + (self.size.height/2));
    }
    else if (background2.position.y<-(self.size.height/2)){
        
        background2.position = CGPointMake(background2.position.x, self.size.height + (self.size.height/2));
    }
    if(wubbles.position.x < -22){
        
        wubbles.position = CGPointMake(382, wubbles.position.y);
    }
    else if (wubbles.position.x > 382){
        
        wubbles.position = CGPointMake(-22, wubbles.position.y);
    }
    
    
}

-(void)addEndingScreen{
  
    
    
    
    gameOverBackground = [SKSpriteNode spriteNodeWithImageNamed:@"bg.png"];
    gameOverBackground.size = CGSizeMake(300, 289);
    gameOverBackground.position = CGPointMake(160, 852);

    SKAction *bringInEndScreen = [SKAction moveByX:0 y:-568 duration:1.89];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    gameOverLabel.text =@"Game Over";
    gameOverLabel.fontSize = 45;
    gameOverLabel.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    gameOverLabel.position = CGPointMake(0, 90);
    
    SKLabelNode *bestLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    bestLabel.text =@"Best: 200";
    bestLabel.fontSize = 34;
    bestLabel.fontColor = [SKColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    bestLabel.position = CGPointMake(60, -80);
    
    
    [self addChild:gameOverBackground];
    [gameOverBackground addChild:gameOverLabel];
    [gameOverBackground addChild:bestLabel];
    
    
    menuBackGround.position = CGPointMake(gameOverBackground.position.x, gameOverBackground.position.y+237);
    menuBackGround.hidden = NO;
    
    [gameOverBackground runAction:bringInEndScreen];
    [menuBackGround runAction:bringInEndScreen completion:^{
        [self.delegate enableButtons];
    }];

    
    
}
-(void)gameOverAnimation{
    
    SKAction *moveDownFast = [SKAction moveByX:0 y:-600 duration:2];
    [instructionsBackground runAction:moveDownFast];
    [currentScoreBackground runAction:moveDownFast];
    [hill runAction:moveDownFast];
    

    

    
}
-(void)stopAnimation{
    
    [background1 removeAllActions];
    [background2 removeAllActions];
    [currentScoreBackground removeAllActions];
    [instructionsBackground removeAllActions];
    [hill removeAllActions];
    [menuBackGround removeAllActions];
    
}
-(void)gameOver{
    
    [self endingPlayerAnimation];
    [self.delegate endGame];
    
    
    
    [self stopAnimation];
    [self gameOverAnimation];
    [self addEndingScreen];
    [self removeMotionSensor];
    
    wubbles.hidden = YES;
    [virticleMovmentFromScrolling invalidate];
    
    [wubbles removeFromParent];
    
    
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

    
    
    SKAction *endingWubblesAction = [SKAction followPath:bezierPath.CGPath duration:1];
    [endingWubbles runAction:endingWubblesAction];

    
    
}

#pragma contact

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    [self gameOver];
    
}

#pragma reset methods

-(void)resetPlacement{
    
   
    hill.position = CGPointMake(160, -476);
    instructionsBackground.position = CGPointMake(160, -146);

    
    
}

-(void)resetAnimation{
    
    SKAction *moveUpFast = [SKAction moveByX:0 y:568 duration:1.89];
    
    [hill runAction:moveUpFast];
    [instructionsBackground runAction:moveUpFast completion:^{
        
        [self cleanUp];
        [self addContent];
        
        [self.delegate resetGame];
        
    }];
    [menuBackGround runAction:moveUpFast];
    [gameOverBackground runAction:moveUpFast];
    
    
    SKAction *moveUpFastPart1 = [SKAction moveByX:0 y:100 duration:.33];
    SKAction *moveUpFastPart2 = [SKAction moveByX:0 y:468 duration:1.55];
    
    [menuBackGround runAction:moveUpFastPart1 completion:^{
        
        [menuBackGround removeFromParent];
        [self addMenuButton];
         menuBackGround.position = CGPointMake(160, -442);
        [menuBackGround runAction:moveUpFastPart2];
    }];
    
    
    
}

-(void)cleanUp{
    
    virticleMovementFromScrolling = 0;
    currentScoreValue = 0;
    gameRunning = NO;
    
    
}

-(void)addContent{
  
 
    [self updateScore];
    [self addCurrentScore];
    [self addWubbles];
    [self addHands];

  

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
}
@end
