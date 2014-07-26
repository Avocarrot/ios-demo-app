//
//  InStreamGrouped.h
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvocarrotSDK/AvocarrotInstream.h>

@interface InStreamGrouped : UIViewController <UITableViewDataSource,UITableViewDelegate, AVInstreamAdDelegate>

@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UIView      *myHelpView;

@end

