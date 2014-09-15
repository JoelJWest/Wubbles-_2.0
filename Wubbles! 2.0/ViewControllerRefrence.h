//
//  ViewController.h
//  Tilty
//
//  Created by Joel West on 7/24/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//
/*
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <QuartzCore/QuartzCore.h>
#import <iAd/iAd.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>
#import "GADBannerView.h"

BOOL StatusFlapDown;

BOOL gameStillRunning;

BOOL runningOnIpad;

BOOL useGoogleAd;


int backGroundMoveDownSpeed;
int birdMovement;
int randomX;
int birdVirticaleMovment;



int HighScoreNumber;
int scoreNumber;

int topScore1;
int topScore2;
int topScore3;
int topScore4;
int topScore5;
//6-10
int topScore6;
int topScore7;
int topScore8;
int topScore9;
int topScore10;

NSString *myString;

int birdPositionY;
int moveSpeed;

int pickImage;
int pickBackGround;

NSString *imageToUse;
NSString *blinkImage;
NSString *birdLeftImage;
NSString *birdRightImage;
NSString *birdWingsImageDown;
NSString *birdWingsImageUp;
NSString *birdLeftFlapUp;
NSString *birdLeftFlapDown;
NSString *birdRightFlapUp;
NSString *birdRightFlapDown;

NSString *unit;
NSString *liveScoreUnit;

NSString *backGroundImage;
NSString *backGroundImage2;




int height;

int currentPositionScore;
   // ALL CODE THAT FOLLOWS IS FOR THE 2.0 RELEASE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

int xDifferenceObsticale1;
int xDifferenceObsticale2;
int xDifferenceObsticale3;
int xDifferenceObsticale1Right;
int xDifferenceObsticale2Right;
int xDifferenceObsticale3Right;

int yDifferenceObsticale1;
int yDifferenceObsticale2;
int yDifferenceObsticale3;
int yDifferenceObsticale1Right;
int yDifferenceObsticale2Right;
int yDifferenceObsticale3Right;

int totalDifference1;
int totalDifference2;
int totalDifference3;

int totalDifference1Right;
int totalDifference2Right;
int totalDifference3Right;

@interface ViewController : UIViewController <ADBannerViewDelegate>

{
    
    IBOutlet ADBannerView *ad;
    IBOutlet UIImageView *backGround1;
    IBOutlet UIImageView *backGround2;
    IBOutlet UIImageView *bird;
    IBOutlet UIImageView *obsticale;
    IBOutlet UIImageView *obsticaleRight;
    IBOutlet UIImageView *obsticale2;
    IBOutlet UIImageView *obsticale2Right;
    IBOutlet UIImageView *obsticale3;
    IBOutlet UIImageView *obsticale3Right;
    IBOutlet UIImageView *obsticale4;
    IBOutlet UIImageView *obsticale4Right;
    IBOutlet UILabel *instructions;
    IBOutlet UIImageView *trees;
    IBOutlet UIImageView *hand;
    IBOutlet UIImageView *handBottom;
    IBOutlet UILabel *score;
    IBOutlet UIImageView *border;
    IBOutlet UIImageView *scoreBorder;
    IBOutlet UILabel *currentScore;
    
    IBOutlet UIButton *leftButton;
    IBOutlet UIButton *rightButton;
    IBOutlet UIImageView *pointUp;
    IBOutlet UIImageView *pointRight;
    IBOutlet UIImageView *highScoreBorder;
    IBOutlet UILabel *winOrLoseLabel;
    IBOutlet UILabel *share;
    IBOutlet UILabel *playAgain;
    IBOutlet UILabel *highScore1;
    IBOutlet UILabel *highScore2;
    IBOutlet UILabel *highScore3;
    IBOutlet UILabel *highScore4;
    IBOutlet UILabel *highScore5;
    //6-10
    IBOutlet UILabel *highScore6;
    IBOutlet UILabel *highScore7;
    IBOutlet UILabel *highScore8;
    IBOutlet UILabel *highScore9;
    IBOutlet UILabel *highScore10;
    
    
    
    
    
    
    NSTimer *backGroundMovement;
    NSTimer *birdVirticaleMovmentTimer;
    NSTimer *scoreTimer;
    NSTimer *endOfGameTimer;
    NSTimer *startOverTimer;
    NSTimer *birdDirection;
    
    IBOutlet UIButton *startGame;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
    
    
    SLComposeViewController *myPost;
    
    IBOutlet UIImageView *blinkAnimation;
    
   
    AVAudioPlayer *gameOverSound;
    AVAudioPlayer *gameOverSound2;
     AVAudioPlayer *flapUp;
     AVAudioPlayer *flap1;
     AVAudioPlayer *flap2;
     AVAudioPlayer *flap3;
     AVAudioPlayer *flap4;
     AVAudioPlayer *flap5;
     AVAudioPlayer *flap6;
    AVAudioPlayer *flapUpSound;
    
    IBOutlet UIImageView *birdWings;
    
    IBOutlet UILabel *shortYourScore;
    
    IBOutlet UILabel *stupidLabel;
    
    //GOOGLE BANNER
    GADBannerView *googleBanner;
    
    IBOutlet UIImageView *fillerBar;
    
    // ALL CODE THAT FOLLOWS IS FOR THE 2.0 RELEASE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}




-(IBAction)startGame:(id)sender;
-(IBAction)startOver:(id)sender;
-(IBAction)share:(id)sender;

-(void)backGroundMoveDown;
-(void)birdMoving;
-(void)birdVirticleMoving;
-(void)gameOver;
-(void)scoreIncrease;
-(void)ending;
-(void)setBackUp;
-(void)birdAnimation;
-(void)setBirdColor;
-(void)setBackGroundColor;
-(void)animateBird;
-(void)flapUpSound;
-(void)gameOverSound;
-(void)checkForCollisions;
   // ALL CODE THAT FOLLOWS IS FOR THE 2.0 RELEASE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


@end
 */
