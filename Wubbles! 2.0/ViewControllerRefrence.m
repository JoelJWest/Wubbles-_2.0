//
//  ViewController.m
//  Tilty
//
//  Created by Joel West on 7/24/14.
//  Copyright (c) 2014 WestSutdios. All rights reserved.
//
/*
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController





#pragma mark - Repeating Via Timer Methods


-(void)birdMoving{
    
    bird.center = CGPointMake(bird.center.x + birdMovement, bird.center.y);
    
    if (bird.center.x < -20){
        
        bird.center = CGPointMake( 339, bird.center.y);
    }
    else if (bird.center.x >339){
        
        bird.center = CGPointMake( -20, bird.center.y);
    }
    bird.center = CGPointMake(bird.center.x, bird.center.y + birdVirticaleMovment);
    
    
    
    
}

-(void)backGroundMoveDown{
    
        
    if (height == 480){
        backGround2.center = CGPointMake(backGround2.center.x, backGround2.center.y + backGroundMoveDownSpeed);
        backGround1.center = CGPointMake(backGround1.center.x, backGround1.center.y + backGroundMoveDownSpeed);
        if (backGround2.center.y == 240){
            
            backGround1.center = CGPointMake(backGround1.center.x, -255);
            
        }
        
        if (backGround1.center.y == 240){
            
            backGround2.center = CGPointMake(backGround2.center.x, -255);
            
        }
        else{
            
        }
        
        
        
        
    }
    
    
    else{
        
        
        backGround2.center = CGPointMake(backGround2.center.x, backGround2.center.y + backGroundMoveDownSpeed);
        backGround1.center = CGPointMake(backGround1.center.x, backGround1.center.y + backGroundMoveDownSpeed);
        if (backGround2.center.y == 284){
            
            backGround1.center = CGPointMake(backGround1.center.x, -294);
            
        }
        
        if (backGround1.center.y == 284){
            
            backGround2.center = CGPointMake(backGround2.center.x, -294);
            
        }
        else{
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    if (obsticale.center.y > 582){
        randomX = arc4random() %230;
        randomX = randomX - 115;
        
        
        obsticale.center = CGPointMake(randomX, -14);
    }
    else{
        
        obsticale.center = CGPointMake(obsticale.center.x, obsticale.center.y +backGroundMoveDownSpeed);
    }
    if (obsticale2.center.y > 582){
        randomX = arc4random() %230;
        randomX = randomX - 115;
        
        
        obsticale2.center = CGPointMake(randomX, -14);
    }
    else{
        
        obsticale2.center = CGPointMake(obsticale2.center.x, obsticale2.center.y +backGroundMoveDownSpeed);
    }
    
    if (obsticale3.center.y > 582){
        randomX = arc4random() %230;
        randomX = randomX - 115;
        
        
        obsticale3.center = CGPointMake(randomX, -14);
    }
    else{
        
        obsticale3.center = CGPointMake(obsticale3.center.x, obsticale3.center.y +backGroundMoveDownSpeed);
    }
    if (obsticale4.center.y > 582){
        randomX = arc4random() %230;
        randomX = randomX - 115;
        
        
        obsticale4.center = CGPointMake(randomX, -14);
    }
    else{
        
        obsticale4.center = CGPointMake(obsticale4.center.x, obsticale4.center.y +backGroundMoveDownSpeed);
    }
    
    [self birdMoving];
    
    instructions.center = CGPointMake(instructions.center.x, instructions.center.y + backGroundMoveDownSpeed);
    trees.center = CGPointMake(trees.center.x, trees.center.y +backGroundMoveDownSpeed);
    border.center = CGPointMake(border.center.x, border.center.y + backGroundMoveDownSpeed);
    score.center = CGPointMake(score.center.x, score.center.y +backGroundMoveDownSpeed);
    
    obsticaleRight.center = CGPointMake (obsticale.center.x +330, obsticale.center.y);
    obsticale2Right.center = CGPointMake (obsticale2.center.x +330, obsticale2.center.y);
    obsticale3Right.center = CGPointMake (obsticale3.center.x +330, obsticale3.center.y);
    obsticale4Right.center = CGPointMake (obsticale4.center.x +330, obsticale4.center.y);
    
    
    
    currentScore.center = CGPointMake(currentScore.center.x, currentScore.center.y + backGroundMoveDownSpeed);
    scoreBorder.center = CGPointMake(scoreBorder.center.x, currentScore.center.y + backGroundMoveDownSpeed);
    
    if (currentScore.center.y > 59){
        
        currentScore.center = CGPointMake(currentScore.center.x, 60);
    }
    
    
    
     OLD METHOD OF COLLISION DETECTION
    
    if (CGRectIntersectsRect (bird.frame, obsticale.frame)){
        
        [self gameOver];
        
    }
    if (CGRectIntersectsRect (bird.frame, obsticale2.frame)){
        
        [self gameOver];
        
    }
    if (CGRectIntersectsRect (bird.frame, obsticale3.frame)){
        
        [self gameOver];
        
    }
    if (CGRectIntersectsRect (bird.frame, obsticaleRight.frame)){
        
        [self gameOver];
        
    }
    if (CGRectIntersectsRect (bird.frame, obsticale2Right.frame)){
        
        [self gameOver];
        
    }
    if (CGRectIntersectsRect (bird.frame, obsticale3Right.frame)){
        
        [self gameOver];
        
    }
    
 
    
    [self checkForCollisions];
    if (bird.center.y < -150){
        
        [self gameOver];
    }
    if (bird.center.y > 700){
        
        [self gameOver];
    }
    
    
    
    
    if (bird.hidden == NO){
        birdWings.center = CGPointMake(bird.center.x, bird.center.y);
    }
    
    
    
    if(birdVirticaleMovment > 0){
        
        StatusFlapDown = NO;
    }
    
    if(birdVirticaleMovment <0){
        
        StatusFlapDown = YES;
    }
    
    
    
    
    
    
    
    
    
    
}

-(void)checkForCollisions{
    
    
    xDifferenceObsticale1 = abs((bird.center.x- (obsticale.center.x+103)));
    yDifferenceObsticale1 = abs((bird.center.y-obsticale.center.y));
    
    totalDifference1 = sqrt((xDifferenceObsticale1*xDifferenceObsticale1)+(yDifferenceObsticale1*yDifferenceObsticale1));
    
    if ((bird.center.x<obsticale.center.x+103) && (bird.center.y < obsticale.center.y + 37) && (bird.center.y > obsticale.center.y -37)){
        
        [self gameOver];
    }
    else if(totalDifference1 <36
            ){
        
        [self gameOver];
    }
    else{
        
        //game Still Going
    }
    xDifferenceObsticale2 = abs((bird.center.x- (obsticale2.center.x+103)));
    yDifferenceObsticale2 = abs((bird.center.y-obsticale2.center.y));
    
    totalDifference2 = sqrt((xDifferenceObsticale2*xDifferenceObsticale2)+(yDifferenceObsticale2*yDifferenceObsticale2));
    
    if ((bird.center.x<obsticale2.center.x+103) && (bird.center.y < obsticale2.center.y + 37) && (bird.center.y > obsticale2.center.y -37)){
        
        [self gameOver];
    }
    else if(totalDifference2 <36
            ){
        
        [self gameOver];
    }
    else{
        
        //game Still Going
    }
    
    xDifferenceObsticale3 = abs((bird.center.x- (obsticale3.center.x+103)));
    yDifferenceObsticale3 = abs((bird.center.y-obsticale3.center.y));
    
    totalDifference3 = sqrt((xDifferenceObsticale3*xDifferenceObsticale3)+(yDifferenceObsticale3*yDifferenceObsticale3));
    
    if ((bird.center.x<obsticale3.center.x+103) && (bird.center.y < obsticale3.center.y + 37) && (bird.center.y > obsticale3.center.y -37)){
        
        [self gameOver];
    }
    else if(totalDifference3 <36
            ){
        
        [self gameOver];
    }
    else{
        
        //game Still Going
    }
    
    
    
    
    
    xDifferenceObsticale1Right = abs((bird.center.x- (obsticaleRight.center.x-103)));
    yDifferenceObsticale1Right = abs((bird.center.y-obsticaleRight.center.y));
    
    totalDifference1Right = sqrt((xDifferenceObsticale1Right*xDifferenceObsticale1Right)+(yDifferenceObsticale1Right*yDifferenceObsticale1Right));
    
    if ((bird.center.x>obsticaleRight.center.x-103) && (bird.center.y < obsticaleRight.center.y + 37) && (bird.center.y > obsticaleRight.center.y -37)){
        
        [self gameOver];
    }
    else if(totalDifference1Right <36
            ){
        
        [self gameOver];
    }
    else{
        
        //game Still Going
    }
    xDifferenceObsticale2Right = abs((bird.center.x- (obsticale2Right.center.x-103)));
    yDifferenceObsticale2Right = abs((bird.center.y-obsticale2Right.center.y));
    
    totalDifference2Right = sqrt((xDifferenceObsticale2Right*xDifferenceObsticale2Right)+(yDifferenceObsticale2Right*yDifferenceObsticale2Right));
    
    if ((bird.center.x>obsticale2Right.center.x-103) && (bird.center.y < obsticale2Right.center.y + 37) && (bird.center.y > obsticale2Right.center.y -37)){
        
        [self gameOver];
    }
    else if(totalDifference2Right <36
            ){
        
        [self gameOver];
    }
    else{
        
        //game Still Going
    }
    xDifferenceObsticale3Right = abs((bird.center.x- (obsticale3Right.center.x-103)));
    yDifferenceObsticale3Right = abs((bird.center.y-obsticale3Right.center.y));
    
    totalDifference3Right = sqrt((xDifferenceObsticale3Right*xDifferenceObsticale3Right)+(yDifferenceObsticale3Right*yDifferenceObsticale3Right));
    
    if ((bird.center.x>obsticale3Right.center.x-103) && (bird.center.y < obsticale3Right.center.y + 37) && (bird.center.y > obsticale3Right.center.y -37)){
        
        [self gameOver];
    }
    else if(totalDifference3Right <36
            ){
        
        [self gameOver];
    }
    else{
        
        //game Still Going
    }
}

-(void)birdVirticleMoving{
    
    birdVirticaleMovment = birdVirticaleMovment + 1;
    
    if (birdVirticaleMovment >3){
        birdVirticaleMovment = 3;
        
        
    }
    
}

-(void)scoreIncrease{
    
    moveSpeed = moveSpeed + backGroundMoveDownSpeed;
    
    
    
    birdPositionY = 458 - bird.center.y;
    birdPositionY = birdPositionY / 100;
    currentPositionScore = (moveSpeed/3) + birdPositionY;
    if(currentPositionScore > scoreNumber){
        
        scoreNumber = currentPositionScore;
    }
    
    if (scoreNumber > currentScore.text.integerValue)
    {
        if(scoreNumber ==1){
            liveScoreUnit = [NSString stringWithFormat:@"Foot!"];
        }
        else{
            liveScoreUnit = [NSString stringWithFormat:@"Feet!"];
        }
        currentScore.text = [NSString stringWithFormat:@"%i %@", scoreNumber, liveScoreUnit];
        
    }
    if(scoreNumber < 0){
        scoreNumber = 0;
    }
}



#pragma mark - User Interaction Methods


-(IBAction)startGame:(id)sender{
    gameStillRunning = YES;
    scoreNumber = 0;
    hand.hidden = YES;
    handBottom.hidden = YES;
    startGame.hidden = YES;
    backGroundMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(backGroundMoveDown) userInfo:nil repeats:YES];
    birdVirticaleMovmentTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(birdVirticleMoving) userInfo:nil repeats:YES];
    scoreTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(scoreIncrease) userInfo:nil repeats:YES];
    
    
    
    
    
    
    
    queue = [NSOperationQueue currentQueue];
    [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
     {
         CMAcceleration acceleration = accelerometerData.acceleration;
         
         birdMovement = acceleration.x * 10;
         
         if (birdMovement < -.33){
             bird.image = [UIImage imageNamed:birdLeftImage];
             
             if(StatusFlapDown == YES){
                 
                 birdWings.image = [UIImage imageNamed:birdLeftFlapDown];
             }
             else{
                 birdWings.image = [UIImage imageNamed:birdLeftFlapUp];
             }
         }
         else if (birdMovement >.33) {
             bird.image = [UIImage imageNamed:birdRightImage];
             
             
             
             if(StatusFlapDown == YES){
                 
                 birdWings.image = [UIImage imageNamed:birdRightFlapDown];
             }
             else{
                 birdWings.image = [UIImage imageNamed:birdRightFlapUp];
             }
         }
         else{
             
             bird.image = [UIImage imageNamed:imageToUse];
             
             if(StatusFlapDown == YES){
                 
                 birdWings.image = [UIImage imageNamed:birdWingsImageDown];
             }
             else{
                 birdWings.image = [UIImage imageNamed:birdWingsImageUp];
             }
         }
         
         
     }
     ];
    
    
    
    [startOverTimer invalidate];
    
    
    blinkAnimation.hidden = YES;
    
    
}

-(IBAction)share:(id)sender{
    
    myString = [NSString stringWithFormat:@"I just scored %i on Wubbles! My best is %i, can you beat that? https://itunes.apple.com/us/app/wubbles!/id905823698?ls=1&mt=8", (int) scoreNumber, (int) topScore1];
    myPost = [[SLComposeViewController alloc]init];
    myPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [myPost setInitialText:myString];
    [self presentViewController:myPost animated:YES completion:NULL];
    
}

-(IBAction)startOver:(id)sender{
    
    
    shortYourScore.hidden = YES;
    [endOfGameTimer invalidate];
    score.text = [NSString stringWithFormat:@"High Score: %i", HighScoreNumber];
    
    
    obsticale.center = CGPointMake(obsticale.center.x, -20);
    obsticale2.center = CGPointMake(obsticale2.center.x, -224);
    obsticale3.center = CGPointMake(obsticale3.center.x, -420);
    obsticaleRight.center = CGPointMake(obsticale.center.x + 330, obsticale.center.y);
    obsticale2Right.center = CGPointMake(obsticale2.center.x + 330, obsticale2.center.y);
    obsticale3Right.center = CGPointMake(obsticale3.center.x + 330, obsticale3.center.y);
    
    
    
    
    ad.hidden = YES;
    googleBanner.hidden = YES;
    fillerBar.hidden = YES;
    scoreNumber = 0;
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    
    
    
    
    
    border.center = CGPointMake(border.center.x, border.center.y -3);
    instructions.center = CGPointMake(instructions.center.x, border.center.y -20);
    score.center = CGPointMake(score.center.x, border.center.y -81);
    trees.hidden = NO;
    trees.center = CGPointMake(border.center.x, border.center.y +336);
    
    border.center = CGPointMake(160, 700);
    border.hidden = NO;
    instructions.hidden = NO;
    score.hidden = NO;
    
    score.text = [NSString stringWithFormat:@"High Score: %i", HighScoreNumber];
    
    hand.animationImages = [NSArray arrayWithObjects:
                            
                            [UIImage imageNamed:@"handdown.png"],
                            [UIImage imageNamed:@"handempty.png"],
                            nil];
    [hand setAnimationRepeatCount:0];
    hand.animationDuration = .9;
    [hand startAnimating];
    
    handBottom.animationImages = [NSArray arrayWithObjects:
                                  
                                  [UIImage imageNamed:@"handup.png"],
                                  [UIImage imageNamed:@"handempty.png"],
                                  nil];
    [handBottom setAnimationRepeatCount:0];
    handBottom.animationDuration = .9;
    [handBottom startAnimating];
    
    
    
    
    
    
    birdVirticaleMovment = 1;
    randomX = 3;
    backGroundMoveDownSpeed = 1;
    
    
    
    bird.layer.cornerRadius = bird.frame.size.width / 2;
    bird.clipsToBounds = YES;
    
    
    obsticale.layer.cornerRadius = 17;
    obsticale.clipsToBounds = YES;
    obsticale2.layer.cornerRadius = 17;
    obsticale2.clipsToBounds = YES;
    obsticale3.layer.cornerRadius = 17;
    obsticale3.clipsToBounds = YES;
    obsticaleRight.layer.cornerRadius = 17;
    obsticaleRight.clipsToBounds = YES;
    obsticale2Right.layer.cornerRadius = 17;
    obsticale2Right.clipsToBounds = YES;
    obsticale3Right.layer.cornerRadius = 17;
    obsticale3Right.clipsToBounds = YES;
    
    //gameStillRunning = YES;
    
    
    
    startOverTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(setBackUp) userInfo:nil repeats:YES];
    if (height == 480){ //short screen place bird at 375
        
        bird.center = CGPointMake(160,375);
    }
    else{
        
        bird.center = CGPointMake(160,458);H
    }
    
    moveSpeed = 0;
    currentScore.text = [NSString stringWithFormat:@"%i Feet!", 0];
    
    [self setBirdColor];
    [self animateBird];
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (gameStillRunning == YES){
        birdVirticaleMovment = -5;
        
        [self flapUpSound];
        
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //  birdWings.image = [UIImage imageNamed:birdWingsImageUp];
    //StatusFlapDown = NO;
}



#pragma mark - Reset Methods


-(void)gameOver{
    
    [scoreTimer invalidate];
    
    [self birdAnimation];
    
    [self gameOverSound];
    
    [birdVirticaleMovmentTimer invalidate];
    [backGroundMovement invalidate];
    
    NSLog(@"Game Over");
    gameStillRunning = NO;
    
    topScore1 = HighScoreNumber;
    
    if (scoreNumber > HighScoreNumber){
        
        [[NSUserDefaults standardUserDefaults] setInteger:scoreNumber forKey:@"HighScoreSaved"];
        
        score.text = [NSString stringWithFormat:@"High Score: %i", HighScoreNumber];
        winOrLoseLabel.text = [NSString stringWithFormat:@"New High Score!"];
    }
    else{
        winOrLoseLabel.text = [NSString stringWithFormat:@"GAME OVER!"];
    }
    
    highScore1.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore2.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore3.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore4.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore5.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore6.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore7.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore8.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore9.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    highScore10.textColor =[UIColor colorWithRed:.36 green:.35 blue:.35 alpha:1];
    
    
    
    
    topScore1 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore1Saved"];
    topScore2 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore2Saved"];
    topScore3 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore3Saved"];
    topScore4 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore4Saved"];
    topScore5 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore5Saved"];
    topScore6 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore6Saved"];
    topScore7 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore7Saved"];
    topScore8 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore8Saved"];
    topScore9 = [[NSUserDefaults standardUserDefaults]  integerForKey:@"topScore9Saved"];
    topScore10 = [[NSUserDefaults standardUserDefaults] integerForKey:@"topScore10Saved"];
    
    
    
    if (scoreNumber > topScore1){
        topScore10 = topScore9;
        topScore9 = topScore8;
        topScore8 = topScore7;
        topScore7 = topScore6;
        topScore6 = topScore5;
        topScore5 = topScore4;
        topScore4 = topScore3;
        topScore3 = topScore2;
        topScore2 = topScore1;
        topScore1 = scoreNumber;
        highScore1.textColor =[UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
    }
    else if (scoreNumber > topScore2){
        topScore10 = topScore9;
        topScore9 = topScore8;
        topScore8 = topScore7;
        topScore7 = topScore6;
        topScore6 = topScore5;
        topScore5 = topScore4;
        topScore4 = topScore3;
        topScore3 = topScore2;
        topScore2 = scoreNumber;
        highScore2.textColor =[UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
    }
    else if (scoreNumber > topScore3){
        topScore10 = topScore9;
        topScore9 = topScore8;
        topScore8 = topScore7;
        topScore7 = topScore6;
        topScore6 = topScore5;
        topScore5 = topScore4;
        topScore4 = topScore3;
        topScore3 = scoreNumber;
        highScore3.textColor =[UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
        
        
    }
    else if (scoreNumber > topScore4){
        topScore10 = topScore9;
        topScore9 = topScore8;
        topScore8 = topScore7;
        topScore7 = topScore6;
        topScore6 = topScore5;
        topScore5 = topScore4;
        topScore4 = scoreNumber;
        highScore4.textColor =[UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
        
        
    }
    else if (scoreNumber > topScore5){
        topScore10 = topScore9;
        topScore9 = topScore8;
        topScore8 = topScore7;
        topScore7 = topScore6;
        topScore6 = topScore5;
        topScore5 = scoreNumber;
        highScore5.textColor =[UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
        
        
        
    }
    else if (scoreNumber >topScore6){
        topScore10 = topScore9;
        topScore9 = topScore8;
        topScore8 = topScore7;
        topScore7 = topScore6;
        topScore6 = scoreNumber;
        highScore6.textColor = [UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
    }
    else if (scoreNumber >topScore7){
        topScore10 = topScore9;
        topScore9 = topScore8;
        topScore8 = topScore7;
        topScore7 = scoreNumber;
        highScore7.textColor = [UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
    }
    else if (scoreNumber >topScore8){
        topScore10 = topScore9;
        topScore9 = topScore8;
        topScore8 = scoreNumber;
        highScore8.textColor = [UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
    }
    else if (scoreNumber >topScore9){
        topScore10 = topScore9;
        topScore9 = scoreNumber;
        highScore9.textColor = [UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
    }
    else if (scoreNumber >topScore10){
        
        topScore10 = scoreNumber;
        highScore10.textColor = [UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1];
        
        
    }
    
    
    
    if (((scoreNumber < topScore10) && (height == 480)) && (highScore10.textColor != [UIColor colorWithRed:(.99) green:(.34) blue:(.37) alpha:1])){
        shortYourScore.text = [NSString stringWithFormat:@"Your Score: %i", scoreNumber];
        shortYourScore.hidden = NO;
    }
    else if((scoreNumber == 0) && (topScore10 == 0) && (height == 480)){
        shortYourScore.text = [NSString stringWithFormat:@"Your Score Was %i", scoreNumber];
        shortYourScore.hidden = NO;
        //  highScore10.hidden = YES;
    }
    else{
        shortYourScore.hidden = YES;
    }
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:topScore1 forKey:@"topScore1Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore2 forKey:@"topScore2Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore3 forKey:@"topScore3Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore4 forKey:@"topScore4Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore5 forKey:@"topScore5Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore6 forKey:@"topScore6Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore7 forKey:@"topScore7Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore8 forKey:@"topScore8Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore9 forKey:@"topScore9Saved"];
    [[NSUserDefaults standardUserDefaults] setInteger:topScore10 forKey:@"topScore10Saved"];
    
    if (topScore1 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore1 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    highScore1.text = [NSString stringWithFormat:@"1. %i %@", topScore1, unit];
    if (topScore2 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore2 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore2.text = [NSString stringWithFormat:@"2. %i %@", topScore2, unit];
    if (topScore3 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore3 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore3.text = [NSString stringWithFormat:@"3. %i %@", topScore3, unit];
    if (topScore4 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore4 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore4.text = [NSString stringWithFormat:@"4. %i %@", topScore4, unit];
    if (topScore5 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore5 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore5.text = [NSString stringWithFormat:@"5. %i %@", topScore5, unit];
    if (topScore6 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore6 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore6.text = [NSString stringWithFormat:@"6. %i %@", topScore6, unit];
    if (topScore7 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore7 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore7.text = [NSString stringWithFormat:@"7. %i %@", topScore7, unit];
    if (topScore8 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore8 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore8.text = [NSString stringWithFormat:@"8. %i %@", topScore8, unit];
    if (topScore9 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore9 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore9.text = [NSString stringWithFormat:@"9. %i %@", topScore9, unit];
    if (topScore10 >1){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else if (topScore10 == 0){
        unit = [NSString stringWithFormat:@"Feet!"];
    }
    else{
        unit = [NSString stringWithFormat:@"Foot!"];
    }
    
    
    highScore10.text = [NSString stringWithFormat:@"10. %i %@", topScore10, unit];
    
    endOfGameTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(ending) userInfo:nil repeats:YES];
    
    
    ad.hidden = NO;
    if (useGoogleAd == YES){
        googleBanner.hidden = NO;
        fillerBar.hidden = NO;
    }
    rightButton.userInteractionEnabled = NO;
}


-(void)ending{
    //stupidLabel.center = CGPointMake(highScore10.center.x, highScore10.center.y);
    scoreBorder.center = CGPointMake(scoreBorder.center.x, scoreBorder.center.y +2);
    currentScore.center = CGPointMake(currentScore.center.x, currentScore.center.y +2);
    
    if (scoreBorder.center.y > 518){
        
        scoreBorder.center = CGPointMake(scoreBorder.center.x, 518);
        rightButton.userInteractionEnabled = YES;
    }
    if (currentScore.center.y > 518){
        
        currentScore.center = CGPointMake(currentScore.center.x, 518);
    }
    
    
    if (border.center.y < 700){
        
        border.center = CGPointMake(border.center.x, border.center.y +2);
    }
    else{
        border.hidden = YES;
    }
    if (score.center.y < 700){
        
        score.center = CGPointMake(score.center.x, score.center.y +2);
    }
    else{
        score.hidden = YES;
    }
    if (instructions.center.y < 700){
        
        instructions.center = CGPointMake(instructions.center.x, instructions.center.y +2);
    }
    else{
        instructions.hidden = YES;
    }
    
    leftButton.center = CGPointMake(leftButton.center.x, currentScore.center.y - 124);
    rightButton.center = CGPointMake(rightButton.center.x, currentScore.center.y - 124);
    pointRight.center = CGPointMake(rightButton.center.x, rightButton.center.y);
    pointUp.center = CGPointMake(leftButton.center.x, leftButton.center.y);
    highScoreBorder.center = CGPointMake(currentScore.center.x, currentScore.center.y - 306);
    if (height == 480){
        
        winOrLoseLabel.center = CGPointMake(currentScore.center.x, currentScore.center.y - 395);
    }
    else{
    winOrLoseLabel.center = CGPointMake(currentScore.center.x, currentScore.center.y - 390);
    }
    share.center = CGPointMake(leftButton.center.x, currentScore.center.y - 72);
    playAgain.center = CGPointMake(rightButton.center.x, currentScore.center.y - 72);
    
    if (height == 480) { // final scores for short phone
        highScore5.center = CGPointMake(120, currentScore.center.y - 235 -5);
        highScore4.center = CGPointMake(120, currentScore.center.y - 235 - 31-5);
        highScore3.center = CGPointMake(120, currentScore.center.y - 235 - 62-5);
        highScore2.center = CGPointMake(120, currentScore.center.y - 235 - 93-5);
        highScore1.center = CGPointMake(120, currentScore.center.y - 235 - 124-5);
        highScore10.center = CGPointMake(230, currentScore.center.y - 235 -5);
        highScore9.center = CGPointMake(230, currentScore.center.y - 235 - 31-5);
        highScore8.center = CGPointMake(230, currentScore.center.y - 235 - 62-5);
        highScore7.center = CGPointMake(230, currentScore.center.y - 235 - 93-5);
        highScore6.center = CGPointMake(230, currentScore.center.y - 235 - 124-5);
        shortYourScore.center = CGPointMake(160, currentScore.center.y -235 + 22);
    }
    else{
        
        highScore5.center = CGPointMake(120, currentScore.center.y - 225 );
        highScore4.center = CGPointMake(120, currentScore.center.y - 225 - 31);
        highScore3.center = CGPointMake(120, currentScore.center.y - 225 - 62);
        highScore2.center = CGPointMake(120, currentScore.center.y - 225 - 93);
        highScore1.center = CGPointMake(120, currentScore.center.y - 225 - 124);
        highScore10.center = CGPointMake(230, currentScore.center.y - 225 );
        highScore9.center = CGPointMake(230, currentScore.center.y - 225 - 31);
        highScore8.center = CGPointMake(230, currentScore.center.y - 225 - 62);
        highScore7.center = CGPointMake(230, currentScore.center.y - 225 - 93);
        highScore6.center = CGPointMake(230, currentScore.center.y - 225 - 124);
        
    }
}



#pragma mark - Set Up Methods


-(void)birdAnimation{
    
    
    //create path for bird to travel through
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath,NULL,bird.center.x,bird.center.y);
    CGPathAddCurveToPoint(thePath,NULL, bird.center.x, bird.center.y, bird.center.x+50, bird.center.y-140, bird.center.x + 25, 700);
    
    
    
    
    
    
    
    
    //create layer for bird image
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(bird.center.x- 25 , bird.center.y-25, 40, 40);
    layer.cornerRadius = 20;
    layer.contents = (id) [UIImage imageNamed:blinkImage].CGImage;
    layer.masksToBounds = YES;
    [self.view.layer addSublayer:layer];
    
    
    //create animation for bird
    CAKeyframeAnimation * theAnimation;
    theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path=thePath;
    
    theAnimation.duration=.55;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fillMode =kCAFillModeForwards;
    
    [layer addAnimation:theAnimation forKey:@"position"];
    
    
    
    
    
    
    
    birdWings.hidden = YES;
    bird.hidden = YES;
    
    
    
    
}

-(void)animateBird{
    
    blinkAnimation.animationImages = [NSArray arrayWithObjects:
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:blinkImage],
                                      [UIImage imageNamed:blinkImage],
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:imageToUse],
                                      [UIImage imageNamed:imageToUse],
                                      nil];
    [blinkAnimation setAnimationRepeatCount: 0];
    blinkAnimation.animationDuration = 5;
    [blinkAnimation startAnimating];
    
    
}

-(void)setBirdColor{
    
    pickImage = arc4random() %5;
    pickImage = pickImage +1;
    //pickImage = 5; //FORCING TO REMAIN BLUE FOR TESTING PURPOSES
    
    if (pickImage == 1) {
        imageToUse = [NSString stringWithFormat:@"orange.png"];
        blinkImage = [NSString stringWithFormat:@"orangesquint.png"];
        birdLeftImage = [NSString stringWithFormat:@"orangeleft.png"];
        birdRightImage = [NSString stringWithFormat:@"orangeright.png"];
        birdWingsImageDown= [NSString stringWithFormat:@"orangearmsflapdown.png"];
        birdWingsImageUp = [NSString stringWithFormat:@"orangearmsflapup.png"];
        birdLeftFlapDown = [NSString stringWithFormat:@"orangearmsflapdownleft.png"];
        birdLeftFlapUp = [NSString stringWithFormat:@"orangearmsflapupleft.png"];
        birdRightFlapDown = [NSString stringWithFormat:@"orangearmsflapdownright.png"];
        birdRightFlapUp = [NSString stringWithFormat:@"orangearmsflapupright.png"];
    }
    else if (pickImage == 2){
        imageToUse = [NSString stringWithFormat:@"red.png"];
        blinkImage = [NSString stringWithFormat:@"redsquint.png"];
        birdLeftImage = [NSString stringWithFormat:@"redleft.png"];
        birdRightImage = [NSString stringWithFormat:@"redright.png"];
        birdWingsImageDown= [NSString stringWithFormat:@"redarmsflapdown.png"];
        birdWingsImageUp = [NSString stringWithFormat:@"redarmsflapup.png"];
        birdLeftFlapDown = [NSString stringWithFormat:@"redarmsflapdownleft.png"];
        birdLeftFlapUp = [NSString stringWithFormat:@"redarmsflapupleft.png"];
        birdRightFlapDown = [NSString stringWithFormat:@"redarmsflapdownright.png"];
        birdRightFlapUp = [NSString stringWithFormat:@"redarmsflapupright.png"];
    }
    else if (pickImage == 3) {
        imageToUse = [NSString stringWithFormat:@"green.png"];
        blinkImage = [NSString stringWithFormat:@"greensquint.png"];
        birdLeftImage = [NSString stringWithFormat:@"greenleft.png"];
        birdRightImage = [NSString stringWithFormat:@"greenright.png"];
        birdWingsImageDown= [NSString stringWithFormat:@"greenarmsflapdown.png"];
        birdWingsImageUp = [NSString stringWithFormat:@"greenarmsflapup.png"];
        birdLeftFlapDown = [NSString stringWithFormat:@"greenarmsflapdownleft.png"];
        birdLeftFlapUp = [NSString stringWithFormat:@"greenarmsflapupleft.png"];
        birdRightFlapDown = [NSString stringWithFormat:@"greenarmsflapdownright.png"];
        birdRightFlapUp = [NSString stringWithFormat:@"greenarmsflapupright.png"];
    }
    else if (pickImage == 4){
        imageToUse = [NSString stringWithFormat:@"yellow.png"];
        blinkImage = [NSString stringWithFormat:@"yellowsquint.png"];
        birdLeftImage = [NSString stringWithFormat:@"yellowleft.png"];
        birdRightImage = [NSString stringWithFormat:@"yellowright.png"];
        birdWingsImageDown= [NSString stringWithFormat:@"yellowarmsflapdown.png"];
        birdWingsImageUp = [NSString stringWithFormat:@"yellowarmsflapup.png"];
        birdLeftFlapDown = [NSString stringWithFormat:@"yellowarmsflapdownleft.png"];
        birdLeftFlapUp = [NSString stringWithFormat:@"yellowarmsflapupleft.png"];
        birdRightFlapDown = [NSString stringWithFormat:@"yellowarmsflapdownright.png"];
        birdRightFlapUp = [NSString stringWithFormat:@"yellowarmsflapupright.png"];
    }
    else if (pickImage == 5) {
        imageToUse = [NSString stringWithFormat:@"blue.png"];
        blinkImage = [NSString stringWithFormat:@"bluesquint.png"];
        birdLeftImage = [NSString stringWithFormat:@"blueleft.png"];
        birdRightImage = [NSString stringWithFormat:@"blueright.png"];
        birdWingsImageDown= [NSString stringWithFormat:@"blueflapdownarms.png"];
        birdWingsImageUp = [NSString stringWithFormat:@"blueflapuparms.png"];
        birdLeftFlapDown = [NSString stringWithFormat:@"blueflapdownarmsleft.png"];
        birdLeftFlapUp = [NSString stringWithFormat:@"blueflapuparmsleft.png"];
        birdRightFlapDown = [NSString stringWithFormat:@"blueflapdownarmsright.png"];
        birdRightFlapUp = [NSString stringWithFormat:@"blueflapuparmsright.png"];
    }
    
    
    bird.image = [UIImage imageNamed:imageToUse];
    birdWings.image = [UIImage imageNamed: birdWingsImageDown];
}

-(void)setBackGroundColor{
    
    
    if(height == 480){
        
        int pickBackGround = arc4random()%25;
        pickBackGround = pickBackGround +1;
       // pickBackGround = 6;
             
        if (pickBackGround == 1){
            
            backGroundImage = [NSString stringWithFormat:@"pink1.png"];
            backGroundImage2 = [NSString stringWithFormat:@"pink2.png"];
            
        }
        else if (pickBackGround ==2){
            
            backGroundImage = [NSString stringWithFormat:@"purple1.png"];
            backGroundImage2 = [NSString stringWithFormat:@"purple2.png"];
        }
        else if (pickBackGround ==3){
            
            backGroundImage = [NSString stringWithFormat:@"lightsunset.png"];
            backGroundImage2 = [NSString stringWithFormat:@"lightsunset1.png"];
        }
        else if (pickBackGround ==4){
            
            backGroundImage = [NSString stringWithFormat:@"clearblue1.png"];
            backGroundImage2 = [NSString stringWithFormat:@"clearblue2.png"];
        }
        else if (pickBackGround ==5){
            backGroundImage = [NSString stringWithFormat:@"nightsky1.png"];
            backGroundImage2 = [NSString stringWithFormat:@"nightsky2.png"];
            border.alpha = .75;
            [self->startGame setTitleColor:[UIColor colorWithRed:.95 green:.95 blue:.94 alpha:1] forState:UIControlStateNormal];
            [self->startGame setTitleColor:[UIColor colorWithRed:.95 green:.95 blue:.94 alpha:1] forState:UIControlStateSelected];
            share.textColor = [UIColor colorWithRed:.95 green:.95 blue:.94 alpha:1];
            playAgain.textColor = [UIColor colorWithRed:.95 green:.95 blue:.94 alpha:1];

        }
        else{
          
            
            backGroundImage = [NSString stringWithFormat:@"bluesky.png"];
            backGroundImage2 = [NSString stringWithFormat:@"bluesky2.png"];


        }
   
        
    }
  else{
        
      int pickBackGround = arc4random()%25;
      pickBackGround = pickBackGround +1;
     // pickBackGround = 6;
      
      if (pickBackGround == 1){
          
          backGroundImage = [NSString stringWithFormat:@"pink1.png"];
          backGroundImage2 = [NSString stringWithFormat:@"pink2.png"];
          
      }
      else if (pickBackGround ==2){
          
          backGroundImage = [NSString stringWithFormat:@"purple1.png"];
          backGroundImage2 = [NSString stringWithFormat:@"purple2.png"];
      }
      else if (pickBackGround ==3){
          
          backGroundImage = [NSString stringWithFormat:@"lightsunset.png"];
          backGroundImage2 = [NSString stringWithFormat:@"lightsunset1.png"];
      }
      else if (pickBackGround ==4){
          
          backGroundImage = [NSString stringWithFormat:@"clearblue1.png"];
          backGroundImage2 = [NSString stringWithFormat:@"clearblue2.png"];
      }
      else if (pickBackGround ==5){
          backGroundImage = [NSString stringWithFormat:@"nightsky1.png"];
          backGroundImage2 = [NSString stringWithFormat:@"nightsky2.png"];
          border.alpha = .75;
          [self->startGame setTitleColor:[UIColor colorWithRed:.95 green:.95 blue:.94 alpha:1] forState:UIControlStateNormal];
          [self->startGame setTitleColor:[UIColor colorWithRed:.95 green:.95 blue:.94 alpha:1] forState:UIControlStateSelected];
          share.textColor = [UIColor colorWithRed:.95 green:.95 blue:.94 alpha:1];
          playAgain.textColor = [UIColor colorWithRed:.95 green:.95 blue:.94 alpha:1];

      }
      else{
          
          backGroundImage = [NSString stringWithFormat:@"bluesky.png"];
          backGroundImage2 = [NSString stringWithFormat:@"bluesky2.png"];

          
      }
     

    }


    backGround1.image = [UIImage imageNamed:backGroundImage];
    backGround2.image = [UIImage imageNamed:backGroundImage2];
    
    
}

-(void)setBackUp{
    
    if (scoreBorder.center.y > -71){
        scoreBorder.center = CGPointMake(scoreBorder.center.x, scoreBorder.center.y - 3);
        currentScore.center = scoreBorder.center;
        leftButton.center = CGPointMake (leftButton.center.x, leftButton.center.y -3);
        rightButton.center = CGPointMake (rightButton.center.x, rightButton.center.y -3);
        pointUp.center = leftButton.center;
        pointRight.center = rightButton.center;
        share.center = CGPointMake(share.center.x, share.center.y -3);
        playAgain.center = CGPointMake(playAgain.center.x, share.center.y -3);
        highScore1.center = CGPointMake(highScore1.center.x, highScore1.center.y -3);
        highScore2.center = CGPointMake(highScore2.center.x, highScore2.center.y -3);
        highScore3.center = CGPointMake(highScore3.center.x, highScore3.center.y -3);
        highScore4.center = CGPointMake(highScore4.center.x, highScore4.center.y -3);
        highScore5.center = CGPointMake(highScore5.center.x, highScore5.center.y -3);
        highScore6.center = CGPointMake(highScore6.center.x, highScore1.center.y -3);
        highScore7.center = CGPointMake(highScore7.center.x, highScore2.center.y -3);
        highScore8.center = CGPointMake(highScore8.center.x, highScore3.center.y -3);
        highScore9.center = CGPointMake(highScore9.center.x, highScore4.center.y -3);
        highScore10.center = CGPointMake(highScore10.center.x, highScore5.center.y -3);
        
        winOrLoseLabel.center = CGPointMake(winOrLoseLabel.center.x, winOrLoseLabel.center.y -3);
        highScoreBorder.center = CGPointMake(highScoreBorder.center.x, highScoreBorder.center.y -3);
        
        
        
        
    }
    else{
        //stupidLabel.hidden = YES;
        // highScore10.hidden = NO;
    }
    if (height == 480){
        if (border.center.y > 143 -32){
            border.center = CGPointMake(border.center.x, border.center.y -3);
            instructions.center = CGPointMake(instructions.center.x, border.center.y - 25);
            score.center = CGPointMake(score.center.x, border.center.y +47);
            trees.center = CGPointMake(border.center.x, border.center.y +280);
            
            
        }
        if (border.center.y < 143 -32){
            hand.hidden = NO;
            handBottom.hidden = NO;
            startGame.hidden = NO;
            bird.hidden = NO;
            birdWings.center = CGPointMake(bird.center.x, bird.center.y);
            birdWings.hidden = NO;
            blinkAnimation.center = bird.center;
            blinkAnimation.hidden = NO;
            
        }
    }
    else{
        if (border.center.y > 130){
            border.center = CGPointMake(border.center.x, border.center.y -3);
            instructions.center = CGPointMake(instructions.center.x, border.center.y - 20);
            score.center = CGPointMake(score.center.x, border.center.y +47);
            trees.center = CGPointMake(border.center.x, border.center.y +346);
            
            
        }
        else{
            hand.hidden = NO;
            handBottom.hidden = NO;
            startGame.hidden = NO;
            bird.hidden = NO;
            birdWings.center = CGPointMake(bird.center.x, bird.center.y);
            birdWings.hidden = NO;
            blinkAnimation.center = bird.center;
            blinkAnimation.hidden = NO;
            
            
        }
        
    }
}

- (void)viewDidLoad
{
    // stupidLabel.hidden = YES;
    // highScore10.hidden = NO;
    shortYourScore.hidden = YES;
    height = [UIScreen mainScreen].bounds.size.height;
   [self setBackGroundColor];
    [self setBirdColor];
    [self animateBird];
    moveSpeed = 0;
    ad.hidden = YES;
   

    scoreNumber = 0;
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    
    
    
    
    
    score.text = [NSString stringWithFormat:@"High Score: %i",HighScoreNumber];
    
    hand.animationImages = [NSArray arrayWithObjects:
                            
                            [UIImage imageNamed:@"handdown.png"],
                            [UIImage imageNamed:@"handempty.png"],
                            nil];
    [hand setAnimationRepeatCount:0];
    hand.animationDuration = .9;
    [hand startAnimating];
    
    handBottom.animationImages = [NSArray arrayWithObjects:
                                  
                                  [UIImage imageNamed:@"handup.png"],
                                  [UIImage imageNamed:@"handempty.png"],
                                  nil];
    [handBottom setAnimationRepeatCount:0];
    handBottom.animationDuration = .9;
    [handBottom startAnimating];
    
    
    
    
    
    
    
    
    
    birdVirticaleMovment = 1;
    randomX = 3;
    backGroundMoveDownSpeed = 1;
    [super viewDidLoad];
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0/10.0;
    
    
    
    bird.layer.cornerRadius = bird.frame.size.width / 2;
    bird.clipsToBounds = YES;
    
    
    obsticale.layer.cornerRadius = 17;
    obsticale.clipsToBounds = YES;
    obsticale2.layer.cornerRadius = 17;
    obsticale2.clipsToBounds = YES;
    obsticale3.layer.cornerRadius = 17;
    obsticale3.clipsToBounds = YES;
    obsticaleRight.layer.cornerRadius = 17;
    obsticaleRight.clipsToBounds = YES;
    obsticale2Right.layer.cornerRadius = 17;
    obsticale2Right.clipsToBounds = YES;
    obsticale3Right.layer.cornerRadius = 17;
    obsticale3Right.clipsToBounds = YES;
    
    gameStillRunning = NO;
    
    currentScore.text = [NSString stringWithFormat:@" %i Feet!", 0];
    
    
    
    
    //useGoogleAd = NO;
    fillerBar.hidden = YES;
 
   // [self testIadFail]; //ENABLE THIS METHOD TO SIMULATE IAD FAILING
    
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:
                           @"02:24:37.672",
                           @"fb17be3cc00a35e0c961260f6cdba544b2213ae6",
                           @"2af4f7bf51d5d9c1c23533326aa46117f4dc8ab7",
                           nil];
    [googleBanner loadRequest:request];
    
    googleBanner = [[GADBannerView alloc] initWithFrame:CGRectMake(0,20,320,50)];
    googleBanner.adUnitID = @"ca-app-pub-9510642814900036/1581006309";
    googleBanner.rootViewController = self;
    
    [self.view addSubview:googleBanner];
    
    [googleBanner loadRequest:[GADRequest request]];
    googleBanner.hidden = YES;
    rightButton.userInteractionEnabled = YES;
    
    

}



#pragma mark - Sound Methods


-(void)flapUpSound{
    int randomSound = arc4random()%6;
    randomSound =6;
    if(randomSound == 0){
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test2"ofType:@"wav"]];
        NSError *error;
        flapUp = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [flapUp setVolume:1];
        [flapUp prepareToPlay];
        [flapUp play];
    }
    else if(randomSound == 1){
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"squishy2"ofType:@"wav"]];
        NSError *error;
        flapUp = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [flapUp setVolume:.08];
        [flapUp prepareToPlay];
        [flapUp play];
    }
    else if(randomSound == 2){
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"squishy3"ofType:@"wav"]];
        NSError *error;
        flapUp = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [flapUp setVolume:.08];
        [flapUp prepareToPlay];
        [flapUp play];
    }
    else if(randomSound == 3){
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"squishy4"ofType:@"wav"]];
        NSError *error;
        flapUp = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [flapUp setVolume:.08];
        [flapUp prepareToPlay];
        [flapUp play];
    }
    else if(randomSound == 4){
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"squishy5"ofType:@"wav"]];
        NSError *error;
        flapUp = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [flapUp setVolume:.08];
        [flapUp prepareToPlay];
        [flapUp play];
    }
    else if(randomSound == 5){
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"squishy6"ofType:@"wav"]];
        NSError *error;
        flapUp = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [flapUp setVolume:.08];
        [flapUp prepareToPlay];
        [flapUp play];
    


    
}
    NSURL *flapurl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"flapping" ofType:@"wav"]];
    NSError *flaperror;
    flapUpSound = [[AVAudioPlayer alloc] initWithContentsOfURL:flapurl error:&flaperror];
    [flapUpSound setVolume:.00];
    [flapUpSound prepareToPlay];
    [flapUpSound play];
}

-(void)gameOverSound{cm
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"impact"ofType:@"wav"]];
    NSError *error;
    gameOverSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [gameOverSound setVolume:.8];
    [gameOverSound prepareToPlay];
    [gameOverSound play];
    NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"endingSound2"ofType:@"wav"]];
    NSError *error2;
    gameOverSound2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:&error2];
    [gameOverSound2 setVolume:.8];
    [gameOverSound2 prepareToPlay];
    [gameOverSound2 play];
    
}



#pragma mark - Ads Methods both Google and Apple


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{

    if (useGoogleAd == NO){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [banner setAlpha:1];
        [UIView commitAnimations];
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *) error {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
    
    useGoogleAd = YES;
}

-(void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
[self->googleBanner removeFromSuperview];
}

-(void)testIadFail{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    ad.hidden = YES;
    [UIView commitAnimations];
    useGoogleAd = YES;
    
    
}



#pragma mark - 2.0 Release Code
// ALL CODE THAT FOLLOWS IS FOR THE 2.0 RELEASE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!













@end
*/