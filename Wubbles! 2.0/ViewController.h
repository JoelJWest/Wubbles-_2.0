//
//  ViewController.h
//  Wubbles! 2.0
//

//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ClassicScene.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"
#import <Social/Social.h>

@protocol resetScene <NSObject>

-(void)resetScene;

@end




float delayTime;
BOOL useGoogleAds;

@interface ViewController : UIViewController <ClassicSceneDelegation, ADBannerViewDelegate, UIActionSheetDelegate> //THIS CLASS HAS METHODS THAT CAN BE CALLED BY ClassicScene
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
    SKView *skView;
    IBOutlet ADBannerView *iAd;
    GADBannerView *googleBanner;
    IBOutlet UIButton *adButton;
    
    IBOutlet UIButton *share;
    IBOutlet UIButton *playAgain;
    
    id delegate;
    
    UISwipeGestureRecognizer *swipeRight;
    

}

@property id <resetScene> delegate;

-(IBAction)classicButton:(id)sender;
-(IBAction)menuButton:(id)sender;
-(IBAction)adButtonPressed:(id)sender;

-(IBAction)share:(id)sender;
-(IBAction)playAgain:(id)sender;


@end
