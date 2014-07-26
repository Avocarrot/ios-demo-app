//
//  InStreamSimple.h
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvocarrotSDK/AvocarrotInstream.h>

@interface InStreamSimple : UIViewController <UITableViewDataSource,UITableViewDelegate, AVInstreamAdDelegate>

@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@end



