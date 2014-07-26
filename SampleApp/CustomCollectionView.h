//
//  CustomCollectionView.h
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvocarrotSDK/AvocarrotCustom.h>

@interface CustomCollectionView : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, AVCustomAdDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView; 

@end

