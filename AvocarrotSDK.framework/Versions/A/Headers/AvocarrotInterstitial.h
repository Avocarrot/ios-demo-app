//
//  AvocarrotInterstitial.h
//  AvocarrotSDK
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvocarrotSDK.h"

@class UIViewController;
@protocol AVInterstitialAdDelegate;

@interface AvocarrotInterstitial : AvocarrotSDK

@property (nonatomic, strong) id<AVInterstitialAdDelegate> delegate;

/**
 Shows an ad using provided view controller.
 
 @param controller The provided controller that the ad view will be displayed with.
 @param placement  The placement name.
 */
- (void)showAdInViewController:(UIViewController *)controller forPlacement:(NSString *)placement;

/**
 * Loads an ad for the provided placement but doesn't display it. This method is intended for power-users who require deep customization.
 *
 * @param reason The reason why an ad was not returned.
 */
- (void)loadAdForPlacement:(NSString *)placement;

@end

#pragma mark - AVInterstitialAdDelegate

/**
 * The delegate object must adopt the AVInterstitialAdDelegate protocol in order to
 * receive ad lifecycle messages
 *
 * The methods are optional and allow the delegate to receive ad lifecycle messages
 * such as when an ad will appear or disappear or when our ad server was unable to retrieve
 * a relevant ad.
 */

@protocol AVInterstitialAdDelegate <NSObject>

@optional

/**
 * Sent when an ad is not available along with the reason why.
 *
 * @param reason The reason why an ad was not returned.
 */
- (void)adDidNotLoad:(NSString *)reason;

/**
 * Sent when an ad is loaded along with the ad information.
 *
 */
- (void)adDidLoad;

/**
 * Sent when a error occurs while loading an ad.
 *
 * @param error The error.
 */
- (void)adDidFailToLoad:(NSError *)error;

/**
 * Sent immediately before an ad appears on the screen.
 */
- (void)adWillAppear;

/**
 * Sent immediately after the ad appears on the screen.
 */
- (void)adDidAppear;

/**
 * Sent immediately before the ad disappears from the screen.
 */
- (void)adWillDisappear;

/**
 * Sent after the ad has disappeared from the screen
 */
- (void)adDidDisappear;

/**
 * Sent immediately before the user will leave the app because of a click. Use this to
 * pause or save the app state before the user leaves the app.
 */
-(void)userWillLeaveApp;

@end