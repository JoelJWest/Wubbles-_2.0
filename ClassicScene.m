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
static const uint32_t rulerCategory = 0x1 << 2;
static const uint32_t shieldIconCategory = 0x1 << 3;
static const uint32_t shieldedCategory = 0x1 << 4;
static const uint32_t rocketCatergory = 0x1 << 5;
static const uint32_t crossHairCategory = 0x1 << 6;
static const uint32_t arrowCategory = 0x1 << 7;

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
@synthesize rotateLeft = rotateLeft;
@synthesize rotateRight = rotateRight;
@synthesize rotateCenter = rotateCenter;
@synthesize moveLeft = moveLeft;
@synthesize moveRight = moveRight;



#pragma Initilization Methods

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.physicsWorld.contactDelegate = self;
    
        virticleMovementFromScrolling = 0;
        currentScoreValue = 0;
        awardedScore = 0;
        topScore = 0;
        temp = 0;
        gameRunning = NO;
        updateScore = NO;
        respondToMotionSensor = NO;
        zoneNumber = 1;
        addMenuBackground = YES;
        height = self.size.height;
        counter = 1;
        
        [self setScore];
        [self addBackground];
        [self addInstructions];
        [self updateInstructions];
        [self addCurrentScore];
        [self addBoundries];
        [self addMoveDownAnimation];
        [self addWubbles];
        [self addHands];
        [self addMenuButton];
        [self addEndingScreen];
       
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self]; // USED TO RELEASE SELF WHEN VIEW IS RELOADED
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetScene) name:@"ResetGame" object:nil];
        
        //USED TO ADD TEST OBJECTS
        //[self addTestObjects];
        
        offSet = [[NSUserDefaults standardUserDefaults] floatForKey:@"OffSet"];
        
        moveLeft = [SKAction moveToX:(wubbles.position.x-1) duration:1/60];
        moveRight = [SKAction moveToX:(wubbles.position.x+1) duration:1/60];
        
        motionManager = [[CMMotionManager alloc] init];
    
    }
    return self;
}

-(void)addPipes{
    
    
    int randomX = arc4random()%160;
    randomX = randomX - 80;
    move = [SKAction moveByX:0 y:750 duration:7.5];
    
    SKAction *moveUp1 = [SKAction moveByX:0 y:(-100) duration:1];
    moveUp = [SKAction repeatActionForever:moveUp1];
    

    SKTexture *leftBarTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"greenbarleft.png"]];
    SKTexture *rightBarTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"greenbarright.png"]];
    
    leftBar1 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarleft.png"];
    leftBar1.physicsBody = [SKPhysicsBody bodyWithTexture:leftBarTexture size:CGSizeMake(leftBar1.size.width,leftBar1.size.height)];
    leftBar1.physicsBody.dynamic = NO;
    leftBar1.physicsBody.categoryBitMask = obsticleCategory;
    leftBar1.position = CGPointMake(randomX, height + 110);
    leftBar1.zPosition = 0;
    
    randomX = arc4random()%160;
    randomX = randomX - 80;
    leftBar2 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarleft.png"];
    leftBar2.physicsBody = [SKPhysicsBody bodyWithTexture:leftBarTexture size:CGSizeMake(leftBar2.size.width,leftBar2.size.height)];
    leftBar2.physicsBody.dynamic = NO;
    leftBar2.physicsBody.categoryBitMask = obsticleCategory;
    leftBar2.position = CGPointMake(randomX, height +300);
    leftBar2.zPosition = 0;
    
    randomX = arc4random()%160;
    randomX = randomX - 80;
    leftBar3 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarleft.png"];
    leftBar3.physicsBody = [SKPhysicsBody bodyWithTexture:leftBarTexture size:CGSizeMake(leftBar3.size.width,leftBar3.size.height)];
    leftBar3.physicsBody.dynamic = NO;
    leftBar3.physicsBody.categoryBitMask = obsticleCategory;
    leftBar3.position = CGPointMake(randomX, height +490);
    leftBar3.zPosition = 0;
    
    randomX = arc4random()%160;
    randomX = randomX - 80;
    leftBar4 = [SKSpriteNode spriteNodeWithImageNamed:@"greenbarleft.png"];
    leftBar4.physicsBody = [SKPhysicsBody bodyWithTexture:leftBarTexture size:CGSizeMake(leftBar4.size.width,leftBar4.size.height)];
    leftBar4.physicsBody.dynamic = NO;
    leftBar4.physicsBody.categoryBitMask = obsticleCategory;
    leftBar4.position = CGPointMake(randomX, height +680);
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

-(void)addInstructions{
    
    NSString *scoreBorder =@"openingborder.png";
    instructionsBackground = [SKSpriteNode spriteNodeWithImageNamed:scoreBorder];
    instructionsBackground.size = CGSizeMake(320, 200);
    instructionsBackground.position = CGPointMake(160, 422);
    instructionsBackground.alpha = 1;
    instructions.position = CGPointMake(160, 458);
    [self addChild:instructionsBackground];
    
    SKLabelNode *gameTitle = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    gameTitle.text =@"Arcade";
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
    highScoreIntro.fontSize = 35;
    highScoreIntro.position = CGPointMake(0, -78);
    highScoreIntro.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
    [instructionsBackground addChild:highScoreIntro];
    
}

-(void)addCurrentScore{
    
    currentScoreBackground = [SKSpriteNode spriteNodeWithImageNamed:@"openingborder.png"];
    currentScoreBackground.position = CGPointMake(160, 703);
    currentScoreBackground.size = CGSizeMake(320, 80);
    currentScoreBackground.zPosition = 1;
    [self addChild:currentScoreBackground];
    
    currentScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
    currentScoreLabel.position = CGPointMake(0,-12);
    currentScoreLabel.fontSize = 42;
    currentScoreLabel.fontColor = [SKColor colorWithRed:.23 green:.69 blue:.45 alpha:1];
    [currentScoreBackground addChild: currentScoreLabel];
    
    bringInCurrentScore = [SKAction moveByX:0 y:-200 duration:2];
    
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

-(void)addMoveDownAnimation{
    
    int moveDownSpeed = -100;
    
    SKAction *moveDownInit = [SKAction moveByX:0 y:moveDownSpeed duration:1];
    moveDown = [SKAction repeatActionForever:moveDownInit];
    
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
      wubbles.position = CGPointMake(160, 110);
      wubbles.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
      wubbles.physicsBody.mass = .01;
      wubbles.physicsBody.linearDamping =8;
      wubbles.physicsBody.dynamic=NO;
      wubbles.physicsBody.categoryBitMask = playerCategory;
      wubbles.physicsBody.contactTestBitMask = obsticleCategory | rulerCategory | shieldIconCategory | rocketCatergory;
      wubbles.zPosition = 99;
    
     [self addChild:wubbles];
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

-(void)addMotionSensor{
 

    
    
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


#pragma Game Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [wubbles.physicsBody applyImpulse:CGVectorMake(0, 10)];
    
    if (gameRunning == NO){
        
        [self runGame];
        
    }
    
}

-(void)runGame{
    
    [self cleanUp];
    [motionManager startDeviceMotionUpdates];
    motionManager.deviceMotionUpdateInterval = 1/60;
    
    
    tap.hidden = YES;
    [self.delegate startGame];
    [background1 runAction:moveDown];
    [background2 runAction:moveDown];
    [instructionsBackground runAction:moveDown];
    [hill runAction:moveDown];
    [menuBackGround runAction:moveDown];
    [currentScoreBackground runAction:bringInCurrentScore];
    
    wubbles.physicsBody.dynamic = YES;
    [wubbles.physicsBody applyImpulse:CGVectorMake(0, 10)];
    
    virticleMovmentFromScrollingTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseScore) userInfo:nil repeats:YES];
    
    gameRunning = YES;
    updateScore = YES;
    
    
    
    [self addPipes];
    
    [leftBar1 runAction:moveUp];
    [leftBar2 runAction:moveUp];
    [leftBar3 runAction:moveUp];
    [leftBar4 runAction:moveUp];
    
    itemTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(placeItem) userInfo:nil repeats:YES];
  
    }

-(void)placeItem{
    
    int randomItem = arc4random()%100;
    randomItem = randomItem + 1;
    
    int randomPosition = arc4random()%320;
    randomPosition = randomPosition + 1;
    
    [rulerNode removeFromParent];
    [shieldNode removeFromParent];
    
     randomItem = 100;
    
    if (randomItem <33){
        
    
        rulerNode = [SKSpriteNode spriteNodeWithImageNamed:@"Ruler.png"];
        SKTexture *rulerNodeTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"Ruler.png"]];
        rulerNode.size = CGSizeMake(30, 10);
        rulerNode.position = CGPointMake(randomPosition, 600);
        rulerNode.physicsBody = [SKPhysicsBody bodyWithTexture:rulerNodeTexture size:CGSizeMake(30, 10)];
        rulerNode.physicsBody.categoryBitMask = rulerCategory;
        rulerNode.physicsBody.contactTestBitMask = playerCategory;
        rulerNode.physicsBody.collisionBitMask = 0;
        rulerNode.physicsBody.mass = .01;
        rulerNode.physicsBody.linearDamping = 10;
        rulerNode.zRotation = .5;
        rulerNode.name = @"Ruler";
        [self addChild:rulerNode];
        
    }
    else if ((randomItem >= 33)&&(randomItem <= 66)){
    
        shieldIconNode = [SKSpriteNode spriteNodeWithImageNamed:@"shildIcon.png"];
        SKTexture *shieldNodeTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"shieldicon.png"]];
        shieldIconNode.size = CGSizeMake(20, 30);
        shieldIconNode.position = CGPointMake(randomPosition, 600);
        shieldIconNode.physicsBody = [SKPhysicsBody bodyWithTexture:shieldNodeTexture size:CGSizeMake(20, 30)];
        shieldIconNode.physicsBody.categoryBitMask = shieldIconCategory;
        shieldIconNode.physicsBody.contactTestBitMask = playerCategory;
        shieldIconNode.physicsBody.collisionBitMask = 0;
        shieldIconNode.physicsBody.mass = .01;
        shieldIconNode.physicsBody.linearDamping = 10;
        shieldIconNode.name = @"Shield";
        [self addChild:shieldIconNode];
    
        
    }
    else if ((randomItem > 66)&&(randomItem <= 90)) {
        
        rocketNode = [SKSpriteNode spriteNodeWithImageNamed:@"rocket.png"];
        SKTexture *rocketNodeTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"rocket.png"]];
        rocketNode.size = CGSizeMake(20, 30);
        rocketNode.position = CGPointMake(randomPosition, 600);
        rocketNode.zRotation = -.55;
        rocketNode.physicsBody = [SKPhysicsBody bodyWithTexture:rocketNodeTexture size:CGSizeMake(20, 30)];
        rocketNode.physicsBody.categoryBitMask = rocketCatergory;
        rocketNode.physicsBody.contactTestBitMask = playerCategory;
        rocketNode.physicsBody.collisionBitMask = 0;
        rocketNode.physicsBody.mass = .01;
        rocketNode.physicsBody.linearDamping = 10;
        rocketNode.name = @"Rocket";
        [self addChild:rocketNode];
        
    }
    else if (randomItem > 90){
        
        crossHairIcon = [SKSpriteNode spriteNodeWithImageNamed:@"crosshariIcon.png"];
        crossHairIcon.size = CGSizeMake(25, 25);
        crossHairIcon.position = CGPointMake(randomPosition, 600);
        crossHairIcon.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:12.5];
        crossHairIcon.physicsBody.categoryBitMask = crossHairCategory;
        crossHairIcon.physicsBody.contactTestBitMask = playerCategory;
        crossHairIcon.physicsBody.collisionBitMask = 0;
        crossHairIcon.physicsBody.mass = .01;
        crossHairIcon.physicsBody.linearDamping = 10;
        crossHairIcon.name = @"Crosshair";
        [self addChild:crossHairIcon];
        
        
        
        }
}

-(void)startShooting{
    
    [self addArrow:CGPointMake(160,0)];
    
    countArrows = 1;
    shoot = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shoot) userInfo:nil repeats:YES];
    

}

-(void)shoot{
    
    int randomX = arc4random()%320;
    randomX += 1;
    countArrows += 1;
    
    SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:.2];
    
    [arrow runAction:fadeOut completion:^{
    [arrow removeFromParent];
    arrow = nil;
    
        if (countArrows <= 10){
            UIBezierPath* polygonPath = UIBezierPath.bezierPath;
            [polygonPath moveToPoint: CGPointMake(0.5, -3)];
            [polygonPath addLineToPoint: CGPointMake(2.67, 4.5)];
            [polygonPath addLineToPoint: CGPointMake(-1.67, 4.5)];
    
            arrow = [SKNode node];
            arrow.position = CGPointMake(randomX, 0);
            arrow.zPosition = 99;
            arrow.name = @"Arrow";
    
            arrowTail = [SKSpriteNode spriteNodeWithImageNamed:@"arrowBottom.png"];
            arrowTail.size = CGSizeMake(5, 30);
            arrowTail.position = CGPointMake(0, 0);
            arrowTail.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 30)];
            arrowTail.physicsBody.mass = .1;
            arrowTail.physicsBody.affectedByGravity = NO;
            arrowTail.physicsBody.linearDamping = 10;
            arrowTail.zPosition = 99;
    
            arrowHead = [SKSpriteNode spriteNodeWithImageNamed:@"arrowTop1.png"];
            arrowHead.size = CGSizeMake(5, 10);
            arrowHead.zRotation = 3.14159;
            arrowHead.position = CGPointMake(0, 20);
            arrowHead.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:polygonPath.CGPath];
            arrowHead.physicsBody.mass = .1;
            arrowHead.physicsBody.linearDamping = 8;
            arrowHead.physicsBody.affectedByGravity = NO;
            arrowHead.zPosition = 99;
    
            [arrow addChild:arrowTail];
            [arrow addChild:arrowHead];
            [self addChild:arrow];
    
    
    
            SKPhysicsJointFixed *arrowJoint = [SKPhysicsJointFixed jointWithBodyA:arrowTail.physicsBody bodyB:arrowHead.physicsBody anchor:CGPointMake(arrowTail.position.x, arrowTail.position.y + 35)];
    
            [self.physicsWorld addJoint:arrowJoint];
    
            double rotation = atan2((wubbles.position.y - arrow.position.y),(wubbles.position.x - arrow.position.x));
            arrow.zRotation = -((3.14159 / 2 ) - rotation);
    
            [self shootArrow];
            
        }
        else{
            
            [shoot invalidate];
            
        }
    }];
}

#pragma gameOver

-(void)gameOver{
    
    [itemTimer invalidate];
    
    [wubbles removeFromParent];
    [motionManager stopDeviceMotionUpdates];
    movement = 0;
    
    updateScore = NO;
    [virticleMovmentFromScrollingTimer invalidate];
    
    [self endingPlayerAnimation];
    [self.delegate endGame];
    [self stopAnimation];
    [self gameOverAnimation];
    

    [[NSUserDefaults standardUserDefaults] setValue:@"Arcade" forKey:@"mode"];
    [[NSUserDefaults standardUserDefaults] setInteger:awardedScore forKey:@"awardedScore"];
    
        [self bringInEndingScreen];
    
}

-(void)removePipes{
    
    SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:1];
    
    [leftBar1 runAction:fadeOut completion:^{[leftBar1 removeFromParent];}];
    [leftBar2 runAction:fadeOut completion:^{[leftBar2 removeFromParent];}];
    [leftBar3 runAction:fadeOut completion:^{[leftBar3 removeFromParent];}];
    [leftBar4 runAction:fadeOut completion:^{[leftBar4 removeFromParent];}];
    
    [rightBar1 runAction:fadeOut completion:^{[rightBar1 removeFromParent];}];
    [rightBar2 runAction:fadeOut completion:^{[rightBar2 removeFromParent];}];
    [rightBar3 runAction:fadeOut completion:^{[rightBar3 removeFromParent];}];
    [rightBar4 runAction:fadeOut completion:^{[rightBar4 removeFromParent];}];
    
    
    [self enumerateChildNodesWithName:@"Ruler" usingBlock:^(SKNode *node, BOOL *stop) {
        [node runAction:fadeOut completion:^{
            [node removeFromParent];
        }];
    }];
    
    [self enumerateChildNodesWithName:@"Shield" usingBlock:^(SKNode *node, BOOL *stop) {
        [node runAction:fadeOut completion:^{
            [node removeFromParent];
        }];
    }];
    [self enumerateChildNodesWithName:@"Rocket" usingBlock:^(SKNode *node, BOOL *stop) {
        [node runAction:fadeOut completion:^{
            [node removeFromParent];
        }];
    }];
    [self enumerateChildNodesWithName:@"Arrow" usingBlock:^(SKNode *node, BOOL *stop) {
        [node runAction:fadeOut completion:^{
            [node removeFromParent];
        }];
    }];
    [self enumerateChildNodesWithName:@"Crosshair" usingBlock:^(SKNode *node, BOOL *stop) {
        [node runAction:fadeOut completion:^{
            [node removeFromParent];
        }];
    }];
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
    
    SKAction *endingWubblesAction = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:1];
 
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
    [hill removeAllActions];
    [menuBackGround removeAllActions];
    [leftBar1 removeAllActions];
    [leftBar2 removeAllActions];
    [leftBar3 removeAllActions];
    [leftBar4 removeAllActions];
    
    [rightBar1 removeAllActions];
    [rightBar2 removeAllActions];
    [rightBar3 removeAllActions];
    [rightBar4 removeAllActions];
    
    
}

-(void)gameOverAnimation{
    
    SKAction *moveDownFast = [SKAction moveByX:0 y:-600 duration:2];
    [instructionsBackground runAction:moveDownFast];
    [currentScoreBackground runAction:moveDownFast completion:^{
        
        [currentScoreBackground removeFromParent];
        
    }];
    [hill runAction:moveDownFast];
    
    
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
    
    topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"topScoreClassic"];
    awardedScore =[[NSUserDefaults standardUserDefaults] integerForKey:@"awardedScore"];
    
    gameOverBackground.position = CGPointMake(160, 852);
    menuBackGround.position = CGPointMake(gameOverBackground.position.x, gameOverBackground.position.y+237);
   
    menuBackGround.hidden = NO;
    
    SKAction *bringInGameOverScreen1 = [SKAction moveByX:0 y:-568 duration:1.89];
    
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
        
    }];
    [menuBackGround runAction:bringInGameOverScreen1 completion:^{
        
        
    }];
    
    
}

-(void)updateScoreCycle:(int)awardedScore{
    
    
    if (awardedScore <= 30){
    
        updateScoreTimer1 = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateScoreRepeating) userInfo:nil repeats:YES];
        
    }
    else{
        
        num = (float)3/(float)awardedScore;
        updateScoreTimer2 = [NSTimer scheduledTimerWithTimeInterval:num target:self selector:@selector(updateScoreRepeating) userInfo:nil repeats:YES];
        
    }
}

-(void)updateScoreRepeating{
    
    awardedScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"awardedScore"];
    
    if (awardedScore == 0){
        [updateScoreTimer1 invalidate];
        [updateScoreTimer2 invalidate];
      
    }
    else{
        
    temp = temp + 1;
    
        NSString *label = [NSString stringWithFormat:@""];
        label = [NSString stringWithFormat:@"%i ft",temp];
        yourScore.text = label;
            
      
            
       
        
        if (temp == awardedScore){
        
            [updateScoreTimer1 invalidate];
            [updateScoreTimer2 invalidate];
        
            }
        if ((temp > topScore)&& (temp >= awardedScore)){
            
            newHighScore.hidden = NO;
            [updateScoreTimer1 invalidate];
            [updateScoreTimer2 invalidate];
            
                [self setScore];
                [self updateInstructions];
            }
    
    }
}


#pragma contact

-(void)didBeginContact:(SKPhysicsContact *)contact{
    if ((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == obsticleCategory)&&(addMenuBackground == YES)){
        [self gameOver];
        addMenuBackground = NO;
    }
    else if ((contact.bodyA.categoryBitMask == obsticleCategory) && (contact.bodyB.categoryBitMask == playerCategory) && (addMenuBackground == YES)){
        [self gameOver];
        addMenuBackground = NO;
    }
    if ((contact.bodyA.categoryBitMask == rulerCategory) && (contact.bodyB.categoryBitMask == playerCategory)){
        [rulerNode removeFromParent];
        [self changeWubblesSize];
    }
    else if ((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == rulerCategory)){
        [rulerNode removeFromParent];
        [self changeWubblesSize];
    }
    if ((contact.bodyA.categoryBitMask == shieldIconCategory) && (contact.bodyB.categoryBitMask == playerCategory)){
        [shieldIconNode removeFromParent];
        [self shieldWubbles];
    }
    else if ((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == shieldIconCategory)){
        [shieldIconNode removeFromParent];
        [self shieldWubbles];
     
    }
    if ((contact.bodyA.categoryBitMask == rocketCatergory) && (contact.bodyB.categoryBitMask == playerCategory)){
        [rocketNode removeFromParent];
        [self rocketWubbles];
    }
    else if ((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == rocketCatergory)){
        [rocketNode removeFromParent];
        [self rocketWubbles];
        
    }
    if ((contact.bodyA.categoryBitMask == crossHairCategory) && (contact.bodyB.categoryBitMask == playerCategory)){
        [crossHairIcon removeFromParent];
        [self startShooting];
    }
    else if ((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == crossHairCategory)){
        [crossHairIcon removeFromParent];
        [self startShooting];
        
    }
    if ((contact.bodyA.categoryBitMask == arrowCategory) && (contact.bodyB.categoryBitMask == playerCategory)){
        [arrow removeFromParent];
        [shoot invalidate];
        [self gameOver];
    }
    else if ((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == arrowCategory)){
        [arrow removeFromParent];
        [shoot invalidate];
        [self gameOver];
        
    }
}

-(void)rocketWubbles{
    
    wubbles.physicsBody.contactTestBitMask = 0;
    wubbles.physicsBody = nil;
    
    SKAction *moveDownSpecial = [SKAction moveByX:0 y:-200 duration:1];
    SKAction *moveDownSpecialRepeating = [SKAction repeatAction:moveDownSpecial count:5];
    
    rocketEffect =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"]];
    rocketEffect.alpha = 1;
    rocketEffect.position = CGPointMake(0, -30);
    [wubbles addChild:rocketEffect];
    
    [background1 runAction:moveDownSpecialRepeating];
    [background2 runAction:moveDownSpecialRepeating];
    [leftBar1 runAction:moveDownSpecialRepeating];
    [leftBar2 runAction:moveDownSpecialRepeating];
    [leftBar3 runAction:moveDownSpecialRepeating];
    [leftBar4 runAction:moveDownSpecialRepeating];
    counter = 2;
    
    NSTimer *changeBackTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeBack1) userInfo:nil repeats:NO];
    
    
}

-(void)changeBack1{
    counter = 1;
    SKPhysicsBody *newPhysicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
    newPhysicsBody.mass = .01;
    newPhysicsBody.linearDamping = 8;
    newPhysicsBody.dynamic = YES;
    newPhysicsBody.categoryBitMask = playerCategory;
    newPhysicsBody.contactTestBitMask = playerCategory;
    
    [rocketEffect removeFromParent];
  
    wubbles.size = CGSizeMake(40, 40);
    newPhysicsBody.velocity = wubbles.physicsBody.velocity;
    wubbles.physicsBody = newPhysicsBody;
  
    NSTimer *changeBackTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeBack2) userInfo:nil repeats:NO];
    
}

-(void)changeBack2{
    
    wubbles.physicsBody.contactTestBitMask = obsticleCategory | rulerCategory | shieldIconCategory | rocketCatergory;
}

-(void)shieldWubbles{
    
    shieldNode = [SKSpriteNode spriteNodeWithImageNamed:@"shield.png"];
    shieldNode.size = CGSizeMake(1, 1);
    SKAction *turnOn = [SKAction scaleXTo:56 y:56 duration:.5];
    [wubbles addChild:shieldNode];
    [shieldNode runAction:turnOn];
    
    SKPhysicsBody *shieldedBody = [SKPhysicsBody bodyWithCircleOfRadius:28];
    shieldedBody.mass = .01;
    shieldedBody.linearDamping = 8;
    shieldedBody.dynamic = YES;
    shieldedBody.categoryBitMask = shieldedCategory;
    shieldedBody.contactTestBitMask = playerCategory;
    shieldedBody.velocity = wubbles.physicsBody.velocity;
    
    wubbles.physicsBody = shieldedBody;
    NSTimer *changeBackTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeBack) userInfo:nil repeats:NO];

}

-(void)changeWubblesSize{
    
    int change = arc4random()%2;
    if (change <1){
        SKAction *increaseSize = [SKAction resizeToWidth:wubbles.size.width * 1.5 height:wubbles.size.height * 1.5 duration:.5];
        SKPhysicsBody *newPhysicsBody = [SKPhysicsBody bodyWithCircleOfRadius:30];
        newPhysicsBody.mass = .01;
        newPhysicsBody.linearDamping = 8;
        newPhysicsBody.dynamic = YES;
        newPhysicsBody.categoryBitMask = playerCategory;
        newPhysicsBody.contactTestBitMask = obsticleCategory;
        [wubbles runAction:increaseSize completion:^{
            
            newPhysicsBody.velocity = wubbles.physicsBody.velocity;
            wubbles.physicsBody = newPhysicsBody;
            
        }];
        
        NSTimer *changeBackTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeBack) userInfo:nil repeats:NO];
        
    }
    else{
        SKAction *increaseSize = [SKAction resizeToWidth:wubbles.size.width / 1.5 height:wubbles.size.height / 1.5 duration:.5];
        SKPhysicsBody *newPhysicsBody = [SKPhysicsBody bodyWithCircleOfRadius:13.33];
        newPhysicsBody.mass = .01;
        newPhysicsBody.linearDamping = 8;
        newPhysicsBody.dynamic = YES;
        newPhysicsBody.categoryBitMask = playerCategory;
        newPhysicsBody.contactTestBitMask = obsticleCategory;

        [wubbles runAction:increaseSize completion:^{
            newPhysicsBody.velocity = wubbles.physicsBody.velocity;
            wubbles.physicsBody = newPhysicsBody;
        
        }];
        
        NSTimer *changeBackTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeBack) userInfo:nil repeats:NO];
    }
}

-(void)changeBack{
    
    [shieldNode removeFromParent];
    SKAction *fixSize = [SKAction resizeToWidth:40 height:40 duration:.5];
    SKPhysicsBody *newPhysicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
    newPhysicsBody.mass = .01;
    newPhysicsBody.linearDamping = 8;
    newPhysicsBody.dynamic = YES;
    newPhysicsBody.categoryBitMask = playerCategory;
    newPhysicsBody.contactTestBitMask = obsticleCategory | rulerCategory | shieldIconCategory | rocketCatergory;

    [wubbles runAction:fixSize completion:^{
        wubbles.size = CGSizeMake(40, 40);
        newPhysicsBody.velocity = wubbles.physicsBody.velocity;
        wubbles.physicsBody = newPhysicsBody;
    }];
    
    
}

-(void)addArrow:(CGPoint)position{
  
    
    UIBezierPath* polygonPath = UIBezierPath.bezierPath;
    [polygonPath moveToPoint: CGPointMake(0.5, -3)];
    [polygonPath addLineToPoint: CGPointMake(2.67, 4.5)];
    [polygonPath addLineToPoint: CGPointMake(-1.67, 4.5)];
    
    
    arrow = [SKNode node];
    arrow.position = CGPointMake(position.x, position.y);
    arrow.zPosition = 99;
    arrow.name=@"Arrow";
    
    
    arrowTail = [SKSpriteNode spriteNodeWithImageNamed:@"arrowBottom.png"];
    arrowTail.size = CGSizeMake(5, 30);
    arrowTail.position = CGPointMake(0, 0);
    arrowTail.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 30)];
    arrowTail.physicsBody.mass = .1;
    arrowTail.physicsBody.affectedByGravity = NO;
    arrowTail.physicsBody.linearDamping = 10;
    arrowTail.zPosition = 99;
    
    arrowHead = [SKSpriteNode spriteNodeWithImageNamed:@"arrowTop1.png"];
    arrowHead.size = CGSizeMake(5, 10);
    arrowHead.zRotation = 3.14159;
    arrowHead.position = CGPointMake(0, 20);
    arrowHead.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:polygonPath.CGPath];
    arrowHead.physicsBody.mass = .1;
    arrowHead.physicsBody.linearDamping = 8;
    arrowHead.physicsBody.affectedByGravity = NO;
    arrowHead.zPosition = 99;
    
    [arrow addChild:arrowTail];
    [arrow addChild:arrowHead];
    [self addChild:arrow];
   
    
    
    SKPhysicsJointFixed *arrowJoint = [SKPhysicsJointFixed jointWithBodyA:arrowTail.physicsBody bodyB:arrowHead.physicsBody anchor:CGPointMake(arrowTail.position.x, arrowTail.position.y + 35)];

    [self.physicsWorld addJoint:arrowJoint];
    
    double rotation = atan2((wubbles.position.y - arrow.position.y),(wubbles.position.x - arrow.position.x));
    arrow.zRotation = -((3.14159 / 2 ) - rotation);
    
   
    
    [self shootArrow];

    
    
}

-(void)shootArrow{
    
    double rotation = atan2((wubbles.position.y - arrow.position.y),(wubbles.position.x - arrow.position.x));
    arrow.zRotation = -((3.14159 / 2 ) - rotation);
    
    arrowHead.physicsBody.affectedByGravity = YES;
    arrowTail.physicsBody.affectedByGravity = YES;
    int force = 1.2;
    CGVector vector = CGVectorMake((wubbles.position.x - arrow.position.x)* force, (wubbles.position.y - arrow.position.y)*force);
    
    [arrowHead.physicsBody applyImpulse:vector];
    
}

#pragma reset methods

-(void)resetPlacement{
    
   
    hill.position = CGPointMake(160, -476);
    instructionsBackground.position = CGPointMake(160, -146);

    
    
}

-(void)resetAnimation{
    
    SKAction *moveUpFast = [SKAction moveByX:0 y:568 duration:1.89];
    SKAction *moveUpFastPart1 = [SKAction moveByX:0 y:100 duration:.33];
    SKAction *moveUpFastPart2 = [SKAction moveByX:0 y:468 duration:1.55];
    
    
    [hill runAction:moveUpFast];
    [gameOverBackground runAction:moveUpFast completion:^{yourScore.text =@"0 ft";}];
    
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
    
    virticleMovementFromScrolling = 0;
    virticleMovementFromFlapping = 0;
    currentScoreValue = 0;
    awardedScore = 0;
    temp = 0;
    addMenuBackground = YES;
    counter = 1;
}

-(void)addContent{
  
 
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
    [motionManager stopDeviceMotionUpdates];
    motionManager = nil;
    
    
}


#pragma scoring

-(void)update:(CFTimeInterval)currentTime {
    
    [self updateWubblesPosition];
    
    rightBar1.position = CGPointMake(leftBar1.position.x+330, leftBar1.position.y);
    rightBar2.position = CGPointMake(leftBar2.position.x+330, leftBar2.position.y);
    rightBar3.position = CGPointMake(leftBar3.position.x+330, leftBar3.position.y);
    rightBar4.position = CGPointMake(leftBar4.position.x+330, leftBar4.position.y);
    
    
    if (updateScore == YES){
        
        [self updateScore];
    }
    
    if(background1.position.y<-(self.size.height/2)){
        
        background1.position = CGPointMake(background1.position.x, self.size.height + (self.size.height/2));
    }
    else if (background2.position.y<-(self.size.height/2)){
        
        background2.position = CGPointMake(background2.position.x, self.size.height + (self.size.height/2));
    }
    if(wubbles.position.x < -12){
        
        wubbles.position = CGPointMake(372, wubbles.position.y);
    }
    else if (wubbles.position.x > 372){
        
        wubbles.position = CGPointMake(-12, wubbles.position.y);
    }
    
    
    
    if (leftBar1.position.y <= -22){
        
        int shouldMove = arc4random()%4;
        
        if(zoneNumber ==1){
            
            int randomX = arc4random()%54;
            randomX = randomX - 80;
            
            leftBar1.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
            
            float duration = ((leftBar1.position.x + 80)/ 100);
            SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
            SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
            SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
            NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
            SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
        
            [leftBar1 runAction:moveBackAndForth];
            }
        }
        else if (zoneNumber ==2){
            
            int randomX = arc4random()%54;
            randomX = randomX - 25;
            
            leftBar1.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar1.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar1 runAction:moveBackAndForth];
            }
        }
        else{
            
            int randomX = arc4random()%54;
            randomX = randomX + 30;
            
            leftBar1.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar1.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar1 runAction:moveBackAndForth];
            }
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
    else if (leftBar2.position.y <= -22){
        
        int shouldMove = arc4random()%4;
        
        if(zoneNumber ==1){
            
            int randomX = arc4random()%54;
            randomX = randomX - 80;
            
            leftBar2.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar2.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar2 runAction:moveBackAndForth];
            }
        }
        else if (zoneNumber ==2){
            
            int randomX = arc4random()%54;
            randomX = randomX - 25;
            
            leftBar2.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar2.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar2 runAction:moveBackAndForth];
            }
        }
        else{
            
            int randomX = arc4random()%54;
            randomX = randomX + 30;
            
            leftBar2.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar2.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar2 runAction:moveBackAndForth];
            }
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
    else if (leftBar3.position.y <= -22){
        
        int shouldMove = arc4random()%4;
        
        if(zoneNumber ==1){
            
            int randomX = arc4random()%54;
            randomX = randomX - 80;
            
            leftBar3.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar3.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar3 runAction:moveBackAndForth];
            }
        }
        else if (zoneNumber ==2){
            
            int randomX = arc4random()%54;
            randomX = randomX - 25;
            
            leftBar3.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar3.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar3 runAction:moveBackAndForth];
            }
        }
        else{
            
            int randomX = arc4random()%54;
            randomX = randomX + 30;
            
            leftBar3.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar3.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar3 runAction:moveBackAndForth];
            }
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
    else if (leftBar4.position.y <= -22){
        
        int shouldMove = arc4random()%4;
        
        if(zoneNumber ==1){
            
            int randomX = arc4random()%54;
            randomX = randomX - 80;
            
            leftBar4.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar4.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar4 runAction:moveBackAndForth];
            }
        }
        else if (zoneNumber ==2){
            
            int randomX = arc4random()%54;
            randomX = randomX - 25;
            
            leftBar4.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar4.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar4 runAction:moveBackAndForth];
            }
        }
        else{
            
            int randomX = arc4random()%54;
            randomX = randomX + 30;
            
            leftBar4.position = CGPointMake(randomX, height +160);
            
            if (shouldMove == 0){
                
                float duration = ((leftBar4.position.x + 80)/ 100);
                SKAction *move1pipes = [SKAction moveToX:-80 duration:duration];
                SKAction *move2pipes = [SKAction moveByX:160 y:0 duration:1.6];
                SKAction *move3pipes = [SKAction moveByX:-160 y:0 duration:1.6];
                NSArray *movePipesArray = [NSArray arrayWithObjects:move1pipes,move2pipes,move3pipes,move2pipes,move3pipes, nil];
                SKAction *moveBackAndForth = [SKAction sequence:movePipesArray];
                
                [leftBar4 runAction:moveBackAndForth];
            }
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
    
    else {
    
        rotateAmount = -motionManager.deviceMotion.attitude.roll + offSet;
    }
    
    
    
    SKAction *rotate = [SKAction rotateToAngle:rotateAmount duration:((rotateAmountAbs / 1.57)/.5 )];

    
    if (gameRunning == YES){
        
         [wubbles runAction:rotate];
    }
   
    
    
    [wubbles runAction:moveWubbles];
    
    
    
}

-(void)increaseScore{
    
    virticleMovementFromScrolling = virticleMovementFromScrolling + counter;
}

-(void)setScore{
    
    topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"topScoreClassic"];
    
    if (awardedScore > topScore){
        
        [[NSUserDefaults standardUserDefaults] setInteger:awardedScore forKey:@"topScoreClassic"];
        
    }
    
}

-(void)updateScore{
    
    virticleMovementFromFlapping = ((wubbles.position.y - 110)/100);
    currentScoreValue = virticleMovementFromFlapping + virticleMovementFromScrolling;
    NSString *currentUnit =@"Feet";
    
    if (awardedScore != 1){
        
        currentUnit = @"Feet";
    }
    
    else{
        
        currentUnit =@"Foot";
    }
    
    if (currentScoreValue >= awardedScore){
        
        currentScoreLabel.text = [NSString stringWithFormat:@"%i %@", currentScoreValue, currentUnit];
        awardedScore = currentScoreValue;
        
    }
    
    
}

-(void)updateInstructions{
    topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"topScoreClassic"];
    
    highScoreIntro.text =[NSString stringWithFormat:@"High Score: %i", topScore];
    
    
}



@end
