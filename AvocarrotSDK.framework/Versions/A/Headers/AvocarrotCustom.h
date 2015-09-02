//
//  AvocarrotCustom.h
//  AvocarrotSDK
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvocarrotSDK.h"
#import "AVCustomAd.h"

@protocol AVCustomAdDelegate;

@interface AvocarrotCustom : AvocarrotSDK

/**
 * The Native Custom Ad delegate
 */
@property (nonatomic, strong) id<AVCustomAdDelegate> delegate;

/**
 * Loads an ad for a given placement.
 *
 * @param placement The placement name.
 */
- (void)loadAdForPlacement:(NSString *)placement;

/**
 * Determines whether preloading should be set
 *
 * @param preloading The boolean value to use.
 */
- (void)disablePreloading;

@end

#pragma mark - AVCustomAdDelegate

@protocol AVCustomAdDelegate <NSObject>

/**
 * Sent when a valid Native Ad object is loaded.
 *
 * @param ad The Native Ad response.
 */
- (void) adDidLoad:(AVCustomAd *)ad;

@optional

/**
 * Sent when an ad is not available along with the reason why.
 *
 * @param reason The reason why an ad was not returned.
 */
- (void) adDidNotLoad:   (NSString *) reason;

/**
 * Sent when a error occurs while loading an ad.
 *
 * @param error The error.
 */
- (void) adDidFailToLoad:(NSError  *) error;

/**
 * Sent when a Custom Native Ad Impression event has occured
 *
 * @param message  The relevant message.
 */
- (void) onAdImpression: (NSString *) message;

/**
 * Sent when a Custom Native Ad click event has occured
 *
 * @param message  The relevant message.
 */
- (void) onAdClick:      (NSString *) message;

/**
 * Sent immediately before the user will leave the app because of a click. Use this to
 * pause or save the app state before the user leaves the app.
 */
-(void)userWillLeaveApp;


@end
