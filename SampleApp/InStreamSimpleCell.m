//
//  InStreamSimpleCell.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "InStreamSimpleCell.h"

@interface InStreamSimpleCell()

@property UILabel      *title;
@property UILabel      *subTitle;
@property UIImageView  *image;

@end

@implementation InStreamSimpleCell

- (id) initWithData:(NSArray *)data andIcon:(NSString *)iconString
{
    self = [super init];
    if (self) {
        
        // Set title
        self.title    = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, self.frame.size.width - 100, 30)];
        [self.title setText:[data objectAtIndex:0]];
        [self.title setTextColor:[UIColor colorWithRed:101/255.f green:157/255.f blue:220/255.f alpha:1.f]];
        [self.title setFont:[UIFont systemFontOfSize:19]];
        
        // Set subtitle
        self.subTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, self.frame.size.width - 100, 25)];
        [self.subTitle setText: [data objectAtIndex:1]];
        [self.subTitle setTextColor: [UIColor colorWithRed:108/255.f green:108/255.f blue:108/255.f alpha:1.f]];
        [self.subTitle setFont:[UIFont systemFontOfSize:13]];
        
        // Set image
        self.image    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconString]];
        [self.image setFrame: CGRectMake(15,15,50,50)];
        [self.image.layer setBorderWidth:3.0f];
        
        // Set Background
        self.backgroundColor =[UIColor colorWithRed:251/255.f green:251/255.f blue:251/255.f alpha:1.f];
        [self.layer setBorderColor:[ [UIColor colorWithRed:204/255.f green:204/255.f blue:204/255.f alpha:1.f] CGColor]] ;
        [self.layer setBorderWidth:1.f];
        
        // Construct View
        [self addSubview:self.title    ];
        [self addSubview:self.subTitle ];
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
}

@end

