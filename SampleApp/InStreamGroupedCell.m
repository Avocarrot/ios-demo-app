//
//  InStreamGroupedCell.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "InStreamGroupedCell.h"

@interface InStreamGroupedCell()

@property UILabel      *title;
@property UIImageView  *image;

@end

@implementation InStreamGroupedCell

- (id) initWithData:(NSArray *)data andIcon:(NSString *)iconString
{
    self = [super init];
    if (self) {
        // Set text
        self.title    = [[UILabel alloc] initWithFrame:CGRectMake(70, 8, self.frame.size.width - 100, 30)];
        [self.title setText:[data objectAtIndex:0]];
        [self.title setFont:[UIFont systemFontOfSize:16]];
        
        // Set image
        self.image    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconString]];
        [self.image setFrame: CGRectMake(10,0,45,45)];
        [self.image.layer setBorderWidth: 2.0f];
        
        // Set Background
        [self setBackgroundColor:[UIColor colorWithRed:251/255.f green:251/255.f blue:251/255.f alpha:1.f]];
        [self.layer setMasksToBounds: NO];
        [self.layer setShadowOffset:CGSizeMake(0, 0)];
        [self.layer setShadowRadius: 2];
        [self.layer setShadowOpacity: 0.3];
        
        // Construct View
        [self addSubview:self.title    ];
        [self addSubview:self.image    ];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end





