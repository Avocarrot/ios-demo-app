//
//  CustomCollectionViewCell.h
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

- (void)renderWithFrame:(CGRect)frame withImage:(NSString*)imageUrl withText:(NSString*)text;

- (void)renderWithFrame:(CGRect)frame;

@end
