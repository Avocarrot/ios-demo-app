//
//  OnClickInterstitial.h
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//
 
#import <UIKit/UIKit.h>
#import <AvocarrotSDK/AvocarrotInterstitial.h>

@interface OnClickInterstitial : UIViewController <AVInterstitialAdDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UILabel                 *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton                *interstitialButton;

@end
