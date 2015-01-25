//
//  ViewController.h
//  Wubbles! 2.0
//

//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ClassicScene.h"
#import "SimpleScene.h"
#import "ReverseScene.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"
#import <Social/Social.h>
#import <GameKit/GameKit.h>
#import "GameCenterScene.h"
#import <CoreMotion/CoreMotion.h>


@protocol resetScene <NSObject>

-(void)resetScene;

@end



float delayTime;
double testOffSet;



BOOL useGoogleAds;

@interface ViewController : UIViewController <ClassicSceneDelegation,SimpleSceneDelegateion, ReverseSceneDelegation, ADBannerViewDelegate, UIActionSheetDelegate, GKGameCenterControllerDelegate, UITableViewDelegate, UITableViewDelegate> //THIS CLASS HAS METHODS THAT CAN BE CALLED BY ClassicScene
{
    IBOutlet UIView *initialBackground;
    IBOutlet UIButton *classic;
    IBOutlet UIButton *simple;
    IBOutlet UIButton *reverse;
    IBOutlet UIButton *fast;
    IBOutlet UIButton *settings;
    IBOutlet UIButton *about;
    IBOutlet UIButton *menu;
    IBOutlet UIImageView *homeImage;
    
    
    
    IBOutlet ADBannerView *iAd;
    GADBannerView *googleBanner;
    IBOutlet UIButton *adButton;
    
    IBOutlet UIButton *share;
    IBOutlet UIButton *playAgain;
    
    id delegate;
    
    UISwipeGestureRecognizer *swipeRight;
    
    SKView *classicSceneView;
    SKView *gameCenterSceneView;
    SKView *reverseSceneView;
    SKView *simpleSceneView;
    
    IBOutlet UIView *leaderBoardView;
    IBOutlet UIView *settingsView;
    IBOutlet UIView *aboutView;
    
    IBOutlet UISwitch *backgroundMusicSwitch;
    IBOutlet UISwitch *soundEffectSwitch;
    
    IBOutlet UITableView *leaderboardTableView;
    
    IBOutlet UILabel *calibrateTest;
    
    
    CMMotionManager *callibrateManager;
    CMAttitude *refrenceAttitude;
    
}

@property id <resetScene> delegate;

-(IBAction)classicButton:(id)sender;
-(IBAction)menuButton:(id)sender;
-(IBAction)gameCenterButton:(id)sender;
-(IBAction)simpleButton:(id)sender;
-(IBAction)reverseButton:(id)sender;
-(IBAction)settingsButton:(id)sender;
-(IBAction)aboutButton:(id)sender;




-(IBAction)adButtonPressed:(id)sender;
-(IBAction)share:(id)sender;
-(IBAction)playAgain:(id)sender;

-(IBAction)rate:(id)sender;
-(IBAction)callibrate:(id)sender;


@end
