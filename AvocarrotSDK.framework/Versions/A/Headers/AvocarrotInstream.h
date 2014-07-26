//
//  AvocarrotInstream.h
//  AvocarrotSDK
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AvocarrotSDK.h"

@protocol AVInstreamAdDelegate;

@interface AvocarrotInstream : AvocarrotSDK

/**
 * The Native In-Stream Ad delegate
 */
@property (nonatomic, strong) id<AVInstreamAdDelegate> delegate;

/**
 * Initializes Native In-Stream Ad UIViewController
 *
 * @param parent     The destination UIViewController <UITableViewDataSource,UITableViewDelegate>
 * @param tableView  The destination UITableView
 * @param minHeight  The minimum height for the UITableViewCell
 */
- (id)initWithController:(UIViewController <UITableViewDataSource,UITableViewDelegate> *)parent minHeightForRow:(int) minHeight tableView:(UITableView*)tableView;

/**
 * Loads Native In-Stream Ads for a given placement
 *
 * @param placement  The placement name
 */
- (void)loadAdForPlacement:(NSString *)placement;

/**
 * Determines frequency and start position for Native Ad stream
 *
 * @param frequency      The repeat gap to be set
 * @param startPosition  The start position to be set
 */
- (void)setFrequency:(int)frequency startPosition:(int)startPos;

@end

#pragma mark - AVInstreamAdDelegate

@protocol AVInstreamAdDelegate <NSObject>

@optional

/**
 * Sent when an ad is not available along with the reason why.
 *
 * @param reason The reason why an ad was not returned.
 */
- (void)adDidNotLoad:(NSString *)reason;

/**
 * Sent when an ad is loaded.
 */
- (void)adDidLoad;

/**
 * Sent when a error occurs while loading an ad.
 *
 * @param error The error.
 */
- (void)adDidFailToLoad:(NSError *)error;

/**
 * Sent immediately before the user will leave the app because of a click. Use this to
 * pause or save the app state before the user leaves the app.
 */
-(void)userWillLeaveApp;


@end