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

@interface ViewController ()


// A flag indicating whether the Game Center features can be used after a user has been authenticated.
@property (nonatomic) BOOL gameCenterEnabled;

// This property stores the default leaderboard's identifier.
@property (nonatomic, strong) NSString *leaderboardIdentifier;



@end


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
  
    
    initialBackground.hidden =NO;
    leaderBoardView.hidden = YES;
    settingsView.hidden = YES;
    aboutView.hidden = YES;
    
    delayTime = .3;
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];
    
    
    leaderBoardView.hidden = NO;
    
    // Configure the view.
    gameCenterSceneView = (SKView *)self.view;
    gameCenterSceneView.showsFPS = NO;
    gameCenterSceneView.showsNodeCount = NO;
    gameCenterSceneView.showsPhysics = NO;
    
    // Create and configure the scene.
    GameCenterScene *cgs = [GameCenterScene sceneWithSize:gameCenterSceneView.bounds.size];
    cgs.scaleMode = SKSceneScaleModeAspectFill;
    
    
    // Present the scene.
    [gameCenterSceneView presentScene:cgs];
 
    
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
    
    leaderBoardView.hidden = YES;
    
    [backgroundMusicSwitch addTarget:self action:@selector(changeSwitchBackground:) forControlEvents:UIControlEventValueChanged];
    [soundEffectSwitch addTarget:self action:@selector(changeSwitchEffect:) forControlEvents:UIControlEventValueChanged];
    
    [self setSwitches];

    [self addTestArray];
}

-(void)viewDidAppear:(BOOL)animated{

    

}



#pragma UI Button Methods (IBAction)

-(IBAction)classicButton:(id)sender{
    
    [self cleanAllViews];
    
    initialBackground.hidden = YES;
    leaderBoardView.hidden = YES;
    settingsView.hidden = YES;
    aboutView.hidden = YES;
    
    delayTime = .3;
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];
    
    // Configure the view.
    classicSceneView = (SKView *)self.view;
    classicSceneView.showsFPS = NO;
    classicSceneView.showsNodeCount = NO;
    classicSceneView.showsPhysics = NO;
    
    // Create and configure the scene.
    ClassicScene *classicScene = [ClassicScene sceneWithSize:classicSceneView.bounds.size];
    classicScene.scaleMode = SKSceneScaleModeAspectFill;
    
    classicScene.delegate = self;
    
    // Present the scene.
    [classicSceneView presentScene:classicScene];
    
    
    
  

}

-(IBAction)simpleButton:(id)sender{
      [self cleanAllViews];
    initialBackground.hidden = YES;
    leaderBoardView.hidden = YES;
    settingsView.hidden = YES;
    aboutView.hidden = YES;
    delayTime = .3;
    
    
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];
    
    // Configure the view.
    simpleSceneView  = (SKView *)self.view;
    simpleSceneView.showsFPS = YES;
    simpleSceneView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SimpleScene *simpleScene = [SimpleScene sceneWithSize:simpleSceneView.bounds.size];
    simpleScene.scaleMode = SKSceneScaleModeAspectFill;
    simpleScene.delegate = self;
    
    // Present the scene.
    [simpleSceneView presentScene:simpleScene];
    
    
}

-(IBAction)reverseButton:(id)sender{
      [self cleanAllViews];
    initialBackground.hidden = YES;
    leaderBoardView.hidden = YES;
    settingsView.hidden = YES;
    aboutView.hidden = YES;
    delayTime = .3;
    
    
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];
    
    // Configure the view.
    reverseSceneView  = (SKView *)self.view;
    reverseSceneView.showsFPS = YES;
    reverseSceneView.showsNodeCount = YES;
    reverseSceneView.showsPhysics = NO;
    
    // Create and configure the scene.
    ReverseScene *reverseScene = [ReverseScene sceneWithSize:reverseSceneView.bounds.size];
    reverseScene.scaleMode = SKSceneScaleModeAspectFill;
    reverseScene.delegate = self;
    
    // Present the scene.
    [reverseSceneView presentScene:reverseScene];
    
    
}

-(IBAction)gameCenterButton:(id)sender{
 
      [self cleanAllViews];
    initialBackground.hidden = YES;
    leaderBoardView.hidden = NO;
    settingsView.hidden = YES;
    aboutView.hidden = YES;
    
    delayTime = .3;
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];

  

    
    // Configure the view.
    gameCenterSceneView = (SKView *)self.view;
    gameCenterSceneView.showsFPS = NO;
    gameCenterSceneView.showsNodeCount = NO;
    gameCenterSceneView.showsPhysics = NO;
    
    // Create and configure the scene.
    GameCenterScene *cgs = [GameCenterScene sceneWithSize:gameCenterSceneView.bounds.size];
    cgs.scaleMode = SKSceneScaleModeAspectFill;
    
    
    // Present the scene.
    [gameCenterSceneView presentScene:cgs];
}

-(IBAction)settingsButton:(id)sender{
      [self cleanAllViews];
    initialBackground.hidden = YES;
    leaderBoardView.hidden = YES;
    settingsView.hidden = NO;
    aboutView.hidden = YES;
    
    delayTime = .3;
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];
    
    
    leaderBoardView.hidden = NO;
    
    // Configure the view.
    gameCenterSceneView = (SKView *)self.view;
    gameCenterSceneView.showsFPS = NO;
    gameCenterSceneView.showsNodeCount = NO;
    gameCenterSceneView.showsPhysics = NO;
    
    // Create and configure the scene.
    GameCenterScene *cgs = [GameCenterScene sceneWithSize:gameCenterSceneView.bounds.size];
    cgs.scaleMode = SKSceneScaleModeAspectFill;
    
    
    // Present the scene.
    [gameCenterSceneView presentScene:cgs];
    
    callibrateManager = [[CMMotionManager alloc] init];
    callibrateManager.deviceMotionUpdateInterval = 1/60;
    [callibrateManager startDeviceMotionUpdates];

}

-(IBAction)callibrate:(id)sender{
  
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Hold your deivce in the positioin in which you wish to play and press callibrate. This setting will reset when Wubbles is restarted."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Callibrate"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [self callibrate];
                             
                         }];
    
    
    [alert addAction:ok];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
   
}

-(void)callibrate{
    
      refrenceAttitude = callibrateManager.deviceMotion.attitude;
//    
//
//    
      calibrateTest.text = [NSString stringWithFormat:@"%f", callibrateManager.deviceMotion.attitude.roll];
      calibrateTest.hidden = YES;
//    
    [[NSUserDefaults standardUserDefaults] setFloat:callibrateManager.deviceMotion.attitude.roll forKey:@"OffSet"];
    
    

}

-(IBAction)aboutButton:(id)sender{
    [self cleanAllViews];
    initialBackground.hidden = YES;
    leaderBoardView.hidden = YES;
    settingsView.hidden = YES;
    aboutView.hidden = NO;
    
    delayTime = .3;
    [self menuExitAnimation:classic];
    [self menuExitAnimation:simple];
    [self menuExitAnimation:reverse];
    [self menuExitAnimation:fast];
    [self menuExitAnimation:settings];
    [self menuExitAnimation:about];
    
    
    leaderBoardView.hidden = NO;
    
    // Configure the view.
    gameCenterSceneView = (SKView *)self.view;
    gameCenterSceneView.showsFPS = NO;
    gameCenterSceneView.showsNodeCount = NO;
    gameCenterSceneView.showsPhysics = NO;
    
    // Create and configure the scene.
    GameCenterScene *cgs = [GameCenterScene sceneWithSize:gameCenterSceneView.bounds.size];
    cgs.scaleMode = SKSceneScaleModeAspectFill;
    
    
    // Present the scene.
    [gameCenterSceneView presentScene:cgs];
    
    
}

-(IBAction)rate:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/wubbles!/id905823698?ls=1&mt=8"]];
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
    
    callibrateManager = nil;
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
    
    callibrateManager = nil;
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




#pragma Share / Play Again Buttons

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
    
    NSString *mode = [[NSUserDefaults standardUserDefaults] valueForKey:@"mode"];
    int topScore = 1;
    int awardedScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"awardedScore"];
    
    
    if ([mode  isEqual: @"Arcade"]){
        
        topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"topScoreClassic"];
    }
    else if ([mode  isEqual: @"Reverse"]){
        
        topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"TopScoreReverse"];
    }
    else if ([mode  isEqual: @"Classic"]){
        
        topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"TopScoreSimple"];
    }
    
    NSString *postContent = [NSString stringWithFormat:@"I just scored %ift on Wubbles %@, my best is %i! Can you beat that? https://itunes.apple.com/us/app/wubbles!/id905823698?ls=1&mt=8",awardedScore, mode, topScore];
    SLComposeViewController *facebookPost = [[SLComposeViewController alloc]init];
    facebookPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookPost setInitialText:postContent];
    [self presentViewController:facebookPost animated:YES completion:NULL];
    
}

-(void)postOnTwitter{
    
    NSString *mode = [[NSUserDefaults standardUserDefaults] valueForKey:@"mode"];
    int topScore = 1;
    int awardedScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"awardedScore"];
    
    
    if ([mode  isEqual: @"Arcade"]){
        
        topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"topScoreClassic"];
    }
    else if ([mode  isEqual: @"Reverse"]){
        
        topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"TopScoreReverse"];
    }
    else if ([mode  isEqual: @"Classic"]){
        
        topScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"TopScoreSimple"];
    }
    
    NSString *postContent = [NSString stringWithFormat:@"I just scored %ift on Wubbles %@, my best is %i! Can you beat that? https://itunes.apple.com/us/app/wubbles!/id905823698?ls=1&mt=8",awardedScore, mode, topScore];
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

-(void)cleanAllViews{
    
   
}


#pragma Advertisement Methods

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


#pragma Game Center

-(void)authenticateLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                _gameCenterEnabled = YES;
                
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        _leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            }
            
            else{
                _gameCenterEnabled = NO;
            }
        }
    };
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    //cell.textLabel.text = [scorePlace objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)addTestArray{
    
    
    
}
#pragma settings

- (void)changeSwitchBackground:(id)backgroundSwitch{
    if([backgroundMusicSwitch isOn]){
        NSLog(@"Switch is ON");
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PlayBackgroundMusic"];
    }
    else{
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PlayBackgroundMusic"];

        NSLog(@"Switch is OFF");
    }
}

- (void)changeSwitchEffect:(id)effectSwitch{
    if([effectSwitch isOn]){
        
        NSLog(@"Switch is ON");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PlaySoundEffects"];
    }
    else{
        
        NSLog(@"Switch is OFF");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PlaySoundEffects"];
    }
}

-(void)setSwitches{
    
    bool playBackgroundMusic;
    playBackgroundMusic = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayBackgroundMusic"];
    
    if (playBackgroundMusic == true){
        
        [backgroundMusicSwitch setOn:YES];
    }
    else{
        
        [backgroundMusicSwitch setOn:NO];
    }
    
    bool playSoundEffects;
    playSoundEffects = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlaySoundEffects"];
    
    if (playSoundEffects == true){
        
        [soundEffectSwitch setOn:YES];
    }
    else{
        
        [soundEffectSwitch setOn:NO];
    }
                         
}
@end
