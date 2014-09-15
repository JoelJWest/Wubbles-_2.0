//
//  ClassicScene.h
//  Wubbles! 2.0
//
//  Created by Joel West on 8/27/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>



@protocol ClassicSceneDelegation <NSObject>
//ADD ANY METHODS THAT ARE CALLED BY ClassicScene BUT IMPLIMENTED BY ViewController
-(void)startGame;
-(void)endGame;
-(void)enableButtons;
-(void)resetGame;

@end

float virticleMovementFromScrolling;
float virticleMovementFromFlapping;
int currentScoreValue;
int tempScore;

@interface ClassicScene : SKScene <SKPhysicsContactDelegate>
{
    id delegate;
    
    NSTimer *virticleMovmentFromScrolling;
}

@property id  <ClassicSceneDelegation> delegate;

@property SKAction *moveDown;
@property SKSpriteNode *background1;
@property SKSpriteNode *background2;
@property SKSpriteNode *wubbles;
@property SKPhysicsBody *topBoundry;
@property SKPhysicsBody *bottomBoundry;
@property SKSpriteNode *currentScoreBorder;
@property SKSpriteNode *instructionsBackground;
@property SKLabelNode *instructions;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property int horizontalMovment;
@property SKLabelNode *highScoreIntro;
@property SKSpriteNode *currentScoreBackground;
@property SKLabelNode *currentScoreLabel;
@property SKAction *bringInCurrentScore;
@property SKSpriteNode *hill;
@property SKLabelNode *tap;
@property SKSpriteNode *topHand;
@property SKSpriteNode *bottomHand;
@property SKAction *flash;
@property SKSpriteNode *menuBackGround;
@property SKLabelNode *menuLabel;
@property SKSpriteNode *gameOverBackground;


@end
