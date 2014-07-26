//
//  AvocarrotSDK.h
//  AvocarrotSDK
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

@interface AvocarrotSDK : NSObject

@property (nonatomic) NSString *apiKey;
@property (nonatomic) BOOL sandbox;

- (void)setLogger:(BOOL)value withLevel:(NSString *)level;

@end
