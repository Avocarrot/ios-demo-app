//
//  CustomPullToRefresh.h
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvocarrotSDK/AvocarrotCustom.h>

@interface CustomPullToRefresh : UIViewController<UIScrollViewDelegate, AVCustomAdDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollPanel;
@property (strong, nonatomic) IBOutlet UILabel      *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel      *instructionLabel;

@end

