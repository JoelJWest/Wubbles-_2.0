//
//  ReverseScene.h
//  Wubbles! 2.0
//
//  Created by Joel J. West on 9/30/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Wubbles! 2.0-Bridging-Header.h"



@protocol ReverseSceneDelegation <NSObject>

-(void)startGame;
-(void)endGame;
-(void)enableButtons;
-(void)resetGame;

@end

BOOL gameRunning;
float offSet;
float movement;
float totalScore;
float fallingScore;
float positionScore;
float speed;
float acceleration;
int tempScore;
int topScore;
int awardedScore;
int score;
int temp;
float numOfLinks;
int zoneNumber;
int zonePicker;
BOOL replaceBar1;
BOOL replaceBar2;
BOOL replaceBar3;
BOOL replaceBar4;
@interface ReverseScene : SKScene <SKPhysicsContactDelegate>
{
    SKSpriteNode *instructionsBackground;
    SKLabelNode *highScoreIntro;
    SKSpriteNode *wubbles;
    SKLabelNode *tap;
    SKSpriteNode *topHand;
    SKSpriteNode *bottomHand;
    SKSpriteNode *menuBackGround;
    SKLabelNode *menuLabel;
    CMMotionManager *motionManager;
    SKSpriteNode *background1;
    SKSpriteNode *background2;
    SKSpriteNode *parachute;
    SKPhysicsBody *bottomBoundry;
    SKPhysicsBody *topBoundry;
    
    id deglegate;
    
    
    SKAction *moveUp;
    SKAction *fadeOut;
    SKAction *increaseSpeed;
    
    SKSpriteNode *currentScoreBackground;
    SKLabelNode *currentScoreLabel;
    SKAction *bringInCurrentScore;
    
    SKSpriteNode *gameOverBackground;
    SKLabelNode *gameOverLabel1;
    SKLabelNode *gameOverLabel2;
    SKLabelNode *newHighScore;
    SKLabelNode *bestLabel;
  
    SKLabelNode *yourScore;
    
    SKCropNode *cropping2;
    SKEmitterNode *textEffect;
    
    NSTimer *accelerateTimer;
    NSTimer *changeScoreTimer;
    NSTimer *accelerateScoreTimer;
    
    NSTimer *updateScoreTimer1;
    NSTimer *updateScoreTimer2;
    
    SKNode *completeChain1;
    SKNode *completeChain2;
    SKNode *completeChain3;
    SKNode *completeChain4;
    SKNode *completeChain5;
    SKNode *completeChain6;
    
    SKNode *bottomLink1;
    SKNode *bottomLink2;
    SKNode *bottomLink3;
    SKNode *bottomLink4;
    SKNode *bottomLink5;
    SKNode *bottomLink6;
    
    SKAction *move;
    SKSpriteNode *leftBar1;
    SKSpriteNode *leftBar2;
    SKSpriteNode *leftBar3;
    SKSpriteNode *leftBar4;
    SKSpriteNode *rightBar1;
    SKSpriteNode *rightBar2;
    SKSpriteNode *rightBar3;
    SKSpriteNode *rightBar4;
        
    
}

@property id  <ReverseSceneDelegation> delegate;


@end
