//
//  CustomCollectionViewCell.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (void)renderWithFrame:(CGRect)frame withImage:(NSString*)imageUrl withText:(NSString*)text
{
    
    self.frame = frame;
    [self applyCellStyle];

        UIImageView *cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageUrl]];
        
        cellImage.frame = CGRectMake(0,0,frame.size.width, frame.size.height);
    
        UILabel *cellText = [[UILabel alloc] initWithFrame:CGRectMake(0,frame.size.height-30,frame.size.width, 30)];
        cellText.text = text;

        cellText.textAlignment = NSTextAlignmentCenter;
    

    
        cellText.textColor  = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:1.f];

        cellText.backgroundColor =[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f] ;
    
    
    // Set Fonts
    [cellText setFont:[UIFont systemFontOfSize:10]];
    
    
        [self addSubview:cellImage ];
        [self addSubview:cellText ];

    
    
    
}

- (void)renderWithFrame:(CGRect)frame
{
    self.frame = frame;
    [self applyCellStyle];
}

- (void) applyCellStyle
{
    
    [self setClipsToBounds:YES];
    self.backgroundColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.f];
    
    self.layer.borderColor = [[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f] CGColor];
    self.layer.borderWidth = 3.0f;
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 0.3;

}




@end
