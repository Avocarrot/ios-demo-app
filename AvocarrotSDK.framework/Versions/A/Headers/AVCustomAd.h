//
//  AVCustomAd.h
//  AvocarrotSDK
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AVCustomEventDelegate;

@interface AVCustomAd : NSObject

/**
 * The Custom Native Ad Event delegate
 */
@property (nonatomic, strong) id<AVCustomEventDelegate> delegate;

- (id) initWithAd:(NSObject *)ad;

- (void) handleClick;
- (void) bindToView:(UIView*)view;

- (NSString *) getHeadline;
- (NSString *) getSubHeadline;
- (NSString *) getCTAText;

- (NSNumber *) getImageWidth;
- (NSNumber *) getImageHeight;
- (NSNumber *) getIconWidth;
- (NSNumber *) getIconHeight;

- (UIImage *) getImage;
- (UIImage *) getIcon;

- (NSString *) getImageUrl;
- (NSString *) getIconUrl;
- (NSString *) getDestinationUrl;
- (NSMutableArray *) getImpressionTrackers;

@end

@protocol AVCustomEventDelegate <NSObject>
@optional

- (void)customEventWillLeaveApp: (AVCustomAd *)ad;
- (void)customEventOnmpression:  (AVCustomAd *)ad withMessage:(NSString *) message;
- (void)customEventOnClick:      (AVCustomAd *)ad withMessage:(NSString *) message;

@end

