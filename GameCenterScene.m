//
//  GameCenterScene.m
//  Wubbles! 2.0
//
//  Created by Joel J. West on 9/30/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import "GameCenterScene.h"

@implementation GameCenterScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
      
        
        
        
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"bluesky.png"];
        background.position = CGPointMake(160, self.size.height/2-14);
        [self addChild:background];
 
        
        [self addMenuButton];
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
-(void)update:(CFTimeInterval)currentTime {
    
}

-(void)addMenuButton{
    
    //ADD BACKGROUND OF MENU BUTTON (A TRANSPARANT RECTANGLE)
    SKSpriteNode *menuBackGround = [SKSpriteNode spriteNodeWithImageNamed:@"flatborder.png"];
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
    SKLabelNode *menuLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial Rounded MT Bold"];
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
@end
