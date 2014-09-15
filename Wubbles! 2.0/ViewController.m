//
//  ViewController.m
//  Wubbles! 2.0
//
//  Created by Joel West on 8/27/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//

#import "ViewController.h"
#import "ClassicScene.h"
#import "SimpleScene.h"
@implementation ViewController




#pragma Methods That are Called By Classic Scene

-(void)startGame{
    
    menu.hidden = YES;
    share.hidden = YES;
    playAgain.hidden = YES;
    swipeRight.enabled = NO;
    
}

-(void)endGame{
    menu.center = CGPointMake(160, 47);
    
   
    
    if(useGoogleAds == YES){
        
    googleBanner.hidden = NO;
    adButton.hidden = NO;
        
    }
    else{
        
    iAd.hidden = NO;
    adButton.hidden = NO;
    }
    
}

-(void)enableButtons{
    
    menu.hidden = NO;
    share.hidden = NO;
    playAgain.hidden = NO;
    swipeRight.enabled = YES;
}

-(void)resetGame{
    
    menu.hidden = NO;
    swipeRight.enabled = YES;
}

#pragma Initilizatin Methods

-(void)viewDidLoad{
    
    iAd.hidden = YES;
    googleBanner.hidden = YES;
    adButton.hidden = YES;
    share.hidden = YES;
    playAgain.hidden = YES;
    
    
    classic.center = CGPointMake(-160,classic.center.y);
    simple.center = CGPointMake(-160,simple.center.y);
    reverse.center = CGPointMake(-160,reverse.center.y);
    fast.center = CGPointMake(-160,fast.center.y);
    settings.center = CGPointMake(-160,settings.center.y);
    about.center = CGPointMake(-160,about.center.y);
    
    delayTime = .3;
    
    [self menuIntroductionAnimation:classic];
    [self menuIntroductionAnimation:simple];
    [self menuIntroductionAnimation:reverse];
    [self menuIntroductionAnimation:fast];
    [self menuIntroductionAnimation:settings];
    [self menuIntroductionAnimation:about];
    
    [self addGoogleAds];
    iAd.hidden = YES;
    googleBanner.hidden = YES;
    adButton.hidden = YES;
    
    //[self testiAdFail];
    useGoogleAds = NO;
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuButton)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:swipeRight];
    swipeRight.enabled = NO;
    
    
}

-(void)viewDidAppear:(BOOL)animated{

    

}



#pragma Button Methods (IBAction)

-(IBAction)classicButton:(id)sender{
    initialBackground.hidden = YES;
    
    delayTime = .3;
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];
    
    // Configure the view.
    skView = (SKView *)self.view;
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    
    
    // Create and configure the scene.
    ClassicScene *classicScene = [ClassicScene sceneWithSize:skView.bounds.size];
    classicScene.scaleMode = SKSceneScaleModeAspectFill;
    
    classicScene.delegate = self;
    
    // Present the scene.
    [skView presentScene:classicScene];
    
    
    
  

}

-(IBAction)simpleButton:(id)sender{
    initialBackground.hidden = YES;
    
    delayTime = .3;
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [SimpleScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    
    
    // Present the scene.
    [skView presentScene:scene];
    
    
}

-(IBAction)menuButton:(id)sender{
    
    classic.center = CGPointMake(-160,classic.center.y);
    simple.center = CGPointMake(-160,simple.center.y);
    reverse.center = CGPointMake(-160,reverse.center.y);
    fast.center = CGPointMake(-160,fast.center.y);
    settings.center = CGPointMake(-160,settings.center.y);
    about.center = CGPointMake(-160,about.center.y);
    
    delayTime = .3;
    
    iAd.hidden = YES;
    googleBanner.hidden = YES;
    adButton.hidden = YES;
    share.hidden = YES;
    playAgain.hidden = YES;
    
    [self menuIntroductionAnimation:classic];
    [self menuIntroductionAnimation:simple];
    [self menuIntroductionAnimation:reverse];
    [self menuIntroductionAnimation:fast];
    [self menuIntroductionAnimation:settings];
    [self menuIntroductionAnimation:about];
    
    swipeRight.enabled = NO;
    
}


-(void)menuButton{
    
    classic.center = CGPointMake(-160,classic.center.y);
    simple.center = CGPointMake(-160,simple.center.y);
    reverse.center = CGPointMake(-160,reverse.center.y);
    fast.center = CGPointMake(-160,fast.center.y);
    settings.center = CGPointMake(-160,settings.center.y);
    about.center = CGPointMake(-160,about.center.y);
    
    delayTime = .3;
    
    iAd.hidden = YES;
    googleBanner.hidden = YES;
    adButton.hidden = YES;
    share.hidden = YES;
    playAgain.hidden = YES;
    
    [self menuIntroductionAnimation:classic];
    [self menuIntroductionAnimation:simple];
    [self menuIntroductionAnimation:reverse];
    [self menuIntroductionAnimation:fast];
    [self menuIntroductionAnimation:settings];
    [self menuIntroductionAnimation:about];
    
    swipeRight.enabled = NO;
}

#pragma Animation Methods

-(void)menuExitAnimation:(UIButton *)button{
    menu.hidden = NO;
    [UIView animateWithDuration:delayTime animations:^{
        [button setCenter:CGPointMake(-160,button.center.y)];
    }
     ];
    
    delayTime = delayTime +.1;
    
    swipeRight.enabled = YES;
    
}
-(void)menuIntroductionAnimation:(UIButton *)button{
    menu.hidden = YES;
    menu.center = CGPointMake(160, 542);
    homeImage.center = CGPointMake(26,542);
    
    
    [UIView animateWithDuration:delayTime animations:^{
        [button setCenter:CGPointMake(160,button.center.y)];
        }
    ];
    
    delayTime = delayTime +.1;
    

}

-(IBAction)share:(id)sender{
    
    NSString *shareOn = @"Share On"; //Action Sheet Title
    NSString *facebook = @"Facebook";
    NSString *twiter = @"Twitter";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:shareOn
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:facebook, twiter, nil];
    [actionSheet showInView:self.view];
    
}

-(IBAction)playAgain:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetGame" object:self];
    iAd.hidden = YES;
    googleBanner.hidden = YES;
    adButton.hidden = YES;
    menu.hidden = YES;
    share.hidden = YES;
    playAgain.hidden = YES;
    
    
    
    
    menu.center = CGPointMake(160, 542);
   
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0){
        
        [self postOnFacebook];
        
    }
    else if (buttonIndex == 1){
        
        [self postOnTwitter];
        
    }
}



-(void)postOnFacebook{
    
    NSString *postContent = [NSString stringWithFormat:@"Post Will Go Here"];
    SLComposeViewController *facebookPost = [[SLComposeViewController alloc]init];
    facebookPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookPost setInitialText:postContent];
    [self presentViewController:facebookPost animated:YES completion:NULL];
    
}

-(void)postOnTwitter{
    
    NSString *postContent = [NSString stringWithFormat:@"Post Will Go Here"];
    SLComposeViewController *twitterPost = [[SLComposeViewController alloc]init];
    twitterPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterPost setInitialText:postContent];
    [self presentViewController:twitterPost animated:YES completion:NULL];
}


#pragma Utility Methods

- (BOOL)shouldAutorotate
{
    return NO;
}


- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
    
    useGoogleAds = NO;
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
    adButton.hidden =YES;
    
    useGoogleAds = YES;
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    
  
}

-(void)testiAdFail{
    
    iAd.hidden = YES;
    
    useGoogleAds = YES;
}

-(void)addGoogleAds{
    
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:
                           @"02:24:37.672",
                           @"fb17be3cc00a35e0c961260f6cdba544b2213ae6",
                           @"2af4f7bf51d5d9c1c23533326aa46117f4dc8ab7",
                           nil];
    [googleBanner loadRequest:request];
    
    googleBanner = [[GADBannerView alloc] initWithFrame:CGRectMake(0,518,320,50)];
    googleBanner.adUnitID = @"ca-app-pub-9510642814900036/1581006309";
    googleBanner.rootViewController = self;
    
    [self.view insertSubview:googleBanner atIndex:1];
    
    [googleBanner loadRequest:[GADRequest request]];
    googleBanner.hidden = YES;
}

-(void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    [self->googleBanner removeFromSuperview];
    adButton.hidden = YES;
 }

-(void)adButtonPressed:(id)sender{
    
    googleBanner.hidden = YES;
    iAd.hidden = YES;
    adButton.hidden = YES;
    
    
}

@end
