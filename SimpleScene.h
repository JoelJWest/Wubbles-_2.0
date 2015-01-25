//
//  SimpleScene.h
//  Wubbles! 2.0
//
//  Created by Joel West on 8/27/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@protocol SimpleSceneDelegateion <NSObject>
//ADD ANY METHODS THAT ARE CALLED BY ClassicScene BUT IMPLIMENTED BY ViewController
-(void)startGame;
-(void)endGame;
-(void)enableButtons;
-(void)resetGame;
@end


float virticleMovementFromScrolling;
float virticleMovementFromFlapping;
float num;
float movement;

BOOL updateScore;
BOOL gameRunning;
BOOL respondToMotionSensor;
BOOL addMenuBackground;

int topScore;
int previousTopScore;
int currentScoreValue;
int awardedScore;
int temp;
int zonePicker;
int zoneNumber;
@interface SimpleScene : SKScene <SKPhysicsContactDelegate>
{
    
    id delegate;
    
    NSTimer *virticleMovmentFromScrollingTimer;
    NSTimer *updateScoreTimer1;
    NSTimer *updateScoreTimer2;
    
    SKEmitterNode *textEffect;
    
    SKCropNode *cropping2;
    
    SKAction *move;
    SKAction *move1;
    SKAction *move2;
    SKAction *move3;
    SKAction *move4;
    
    SKSpriteNode *leftBar1;
    SKSpriteNode *leftBar2;
    SKSpriteNode *leftBar3;
    SKSpriteNode *leftBar4;
    
    SKSpriteNode *rightBar1;
    SKSpriteNode *rightBar2;
    SKSpriteNode *rightBar3;
    SKSpriteNode *rightBar4;
    
    SKSpriteNode *gameOverBackground;
    SKLabelNode *gameOverLabel1;
    SKLabelNode *gameOverLabel2;
    SKLabelNode *newHighScore;
    SKLabelNode *bestLabel;
    SKLabelNode *yourScore;
    
    SKAction *bringInGameOverScreen;
    
    
}


@property id  <SimpleSceneDelegateion> delegate;
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
@property SKAction *rotateLeft;
@property SKAction *rotateRight;
@property SKAction *rotateCenter;
@property SKAction *moveLeft;
@property SKAction *moveRight;


@end
