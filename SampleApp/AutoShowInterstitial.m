//
//  AutoShowInterstitial.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "AutoShowInterstitial.h"

@interface AutoShowInterstitial ()

@end

@implementation AutoShowInterstitial
@synthesize spinner;
@synthesize titleLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [spinner startAnimating];
    [titleLabel setText:@"An Intersitial Ad is being loaded..."];

    // ------------------------------------------------------------------------------------------------
    // Avocarrot
    // Interstitial Ad Integration
    
     AvocarrotInterstitial *myAd = [[AvocarrotInterstitial alloc] init];
    [myAd setApiKey:@"3dbab458941a2446e2b48ac866b42027f5cac288"];
    [myAd setDelegate:self];
    [myAd setSandbox:YES];
    [myAd setLogger:YES withLevel:@"ALL"];
    [myAd showAdInViewController:self forPlacement:@"activity_triggered_1"];
}

// ------------------------------------------------------------------------------------------------
// Avocarrot - ( Optional )

#pragma mark - AVInterstitialAdDelegate

- (void)adDidLoad
{
    NSLog(@"Ad server did return an ad.");
}
- (void)adDidFailToLoad:(NSError *)error
{
    NSLog(@"%@", [NSString stringWithFormat:@"Ad server fail to load ad because: %@",[error localizedDescription]]);

    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^(void){
        [titleLabel setText:@"Ad did fail to load"];
        [spinner stopAnimating];
    });
}
- (void)adDidNotLoad:(NSString *)reason
{
    NSLog(@"%@", [NSString stringWithFormat:@"Ad server did not return an ad because: %@",reason]);
    
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^(void){
        [titleLabel setText:@"Ad did not load"];
        [spinner stopAnimating];
    });
}
- (void)adWillAppear
{
    NSLog(@"%@", @"Ad will appear");
}
- (void)adDidAppear
{
    NSLog(@"%@", @"Ad has appeared");

    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^(void){
        [titleLabel setText:@"An Intersitial Ad has been shown"];
        [spinner stopAnimating];
    });
    
}
- (void)adWillDisappear
{
    NSLog(@"%@", @"Ad will disappear");
}
- (void)adDidDisappear
{
    NSLog(@"%@", @"Ad has disappeared");
}
- (void)userWillLeaveApp
{
    NSLog(@"%@", @"User will leave app");
}


@end
