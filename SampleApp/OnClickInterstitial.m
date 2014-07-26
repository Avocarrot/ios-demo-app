//
//  OnClickInterstitial.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "OnClickInterstitial.h"

@interface OnClickInterstitial ()
@property AvocarrotInterstitial *myAd;

@end

@implementation OnClickInterstitial
@synthesize spinner;
@synthesize titleLabel;
@synthesize interstitialButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [spinner startAnimating];
    [titleLabel setText:@"An Intersitial Ad is being loaded..."];
    
    [self.interstitialButton.layer setCornerRadius:4.0];
    [self.interstitialButton.layer setBorderWidth:1];
    [self.interstitialButton.layer setShadowOffset: CGSizeMake(0, 1) ];
    [self.interstitialButton.layer setShadowRadius:1];
    [self.interstitialButton.layer setShadowOpacity:0.1];
    [self.interstitialButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.interstitialButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.interstitialButton setBackgroundColor:[UIColor colorWithRed:213/255.0 green:100/255.0 blue:69/255.0 alpha:1]];
    [self.interstitialButton.layer setBorderColor:[[UIColor colorWithRed:213/255.0 green:100/255.0 blue:69/255.0 alpha:1] CGColor]];
    
    // ------------------------------------------------------------------------------------------------
    // Avocarrot
    // Interstitial Ad Integration (with pre-loading)

    self.myAd= [[AvocarrotInterstitial alloc] init];
    [self.myAd setApiKey:@"3dbab458941a2446e2b48ac866b42027f5cac288"];
    [self.myAd setDelegate:self];
    [self.myAd setSandbox:YES];
    [self.myAd loadAdForPlacement:@"activity_triggered_2"];
    [self.myAd setLogger:YES withLevel:@"ALL"];
    
 }

// ------------------------------------------------------------------------------------------------
// Avocarrot - ( Optional )

#pragma mark - AVInterstitialAdDelegate

- (void)adDidLoad
{
    NSLog(@"Ad server did return an ad");

    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^(void){
        [self.titleLabel setText:@"An Interstitial Ad has been loaded"];
        [spinner stopAnimating];
    });
}

- (void)adDidNotLoad:(NSString *)reason
{
    NSLog(@"%@", [NSString stringWithFormat:@"Ad server did not return an ad because: %@",reason]);
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^(void){
        [self.titleLabel setText:@"Ad did not load"];
        [spinner stopAnimating];
    });
}

- (void)adDidFailToLoad:(NSError *)error
{
    NSLog(@"%@", [NSString stringWithFormat:@"Ad server fail to load ad because: %@",[error localizedDescription]]);
    
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^(void){
        [self.titleLabel setText:@"Ad did fail to load"];
        [spinner stopAnimating];
    });
}

- (void)adWillAppear{
    NSLog(@"%@", @"Ad will appear");
}

- (void)adDidAppear{
    NSLog(@"%@", @"Ad has appeared");
}

- (void)adWillDisappear{
    NSLog(@"%@", @"Ad will disappear");
}

- (void)adDidDisappear{
    NSLog(@"%@", @"Ad has disappeared");
}

- (void)userWillLeaveApp{
    NSLog(@"%@", @"User will leave app");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// ------------------------------------------------------------------------------------------------
- (IBAction)show:(UIButton *)sender
{
    // Show pre-loaded Interstial Ad
    [_myAd showAdInViewController:self forPlacement:@"activity_triggered_2   "];
}

@end
