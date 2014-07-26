//
//  HelpView.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "HelpView.h"
@interface HelpView()

@property UITapGestureRecognizer       *gestureTap;
@property UIPinchGestureRecognizer     *gesturePinch;
@property UIPanGestureRecognizer       *gesturePan;
@property UISwipeGestureRecognizer     *gestureSwipe;
@property UIRotationGestureRecognizer  *gestureRotation;
@property UILongPressGestureRecognizer *gestureLongPress;

@property CGFloat screenWidth,
                  screenHeight;

@property UIView *parentView,
                 *siblingView;

@property BOOL isShown;

@end

@implementation HelpView

- (id) initWithParentView:(UIView *) parentView  withSibling:(UIView *) siblingView withTitle:(NSString *)title andExitMessage:(NSString *)message
{
    self = [super initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, 100)];
    if (self) {
        
        self.parentView = parentView;
        self.siblingView = siblingView;
        self.isShown = NO;
        self.screenWidth  = [[UIScreen mainScreen] bounds].size.width;
        self.screenHeight = [[UIScreen mainScreen] bounds].size.height;

        // Create title label
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20,20, self.screenWidth-40, 40)];
        [labelTitle setTextAlignment:NSTextAlignmentCenter];
        [labelTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [labelTitle setNumberOfLines:0];
        [labelTitle setText: title];
        [labelTitle setTextColor:[UIColor colorWithRed:108/255.f green:108/255.f blue:108/255.f alpha:1.f]];
        [labelTitle setFont:[UIFont systemFontOfSize:14]];
        
        // Create tap-me label
        UILabel *labelTap   = [[UILabel alloc] initWithFrame:CGRectMake(0,60, self.screenWidth, 30)];
        [labelTap setText:message];
        [labelTap setTextAlignment:NSTextAlignmentCenter];
        [labelTap setFont:[UIFont systemFontOfSize:16]];
        [labelTap setTextColor:[UIColor colorWithRed:233/255.f green:99/255.f blue:68/255.f alpha:1.f]];
        
        [self addSubview:labelTitle];
        [self addSubview:labelTap];
        
        [self setBackgroundColor:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.]];
        [self.layer setMasksToBounds: NO];
        [self.layer setShadowOffset: CGSizeMake(0, 2)];
        [self.layer setShadowRadius: 4];
        [self.layer setShadowOpacity: 0.3];

        // Register gestur listeners
        self.gestureTap       = [[UITapGestureRecognizer alloc]       initWithTarget:self action:@selector(hideModal:)];
        self.gesturePinch     = [[UIPinchGestureRecognizer alloc]     initWithTarget:self action:@selector(hideModal:)];
        self.gesturePan       = [[UIPanGestureRecognizer alloc]       initWithTarget:self action:@selector(hideModal:)];
        self.gestureSwipe     = [[UISwipeGestureRecognizer alloc]     initWithTarget:self action:@selector(hideModal:)];
        self.gestureRotation  = [[UIRotationGestureRecognizer alloc]  initWithTarget:self action:@selector(hideModal:)];
        self.gestureLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(hideModal:)];

        [self.parentView addGestureRecognizer:self.gestureTap      ];
        [self.parentView addGestureRecognizer:self.gesturePinch    ];
        [self.parentView addGestureRecognizer:self.gestureSwipe    ];
        [self.parentView addGestureRecognizer:self.gesturePan      ];
        [self.parentView addGestureRecognizer:self.gestureRotation ];
        [self.parentView addGestureRecognizer:self.gestureLongPress];
        
        [self.siblingView addGestureRecognizer:self.gestureLongPress];
    }
    return self;
}
- (void) update
{
    // Create frame for modal help view
    [self.siblingView setFrame:CGRectMake(0, 0, self.screenWidth, self.screenHeight)];
    [self setFrame: CGRectMake(0, -100, [[UIScreen mainScreen] bounds].size.width, 100)];

    if (self.isShown)
        return;
    
    // Create a slide-fade-in animation
    [self setAlpha:0];
    [UIView animateWithDuration:0.25 delay:0.5 options: UIViewAnimationOptionCurveEaseOut animations:^{
        [self setAlpha:1];
        [self.siblingView setAlpha:0.2];
        [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100)];
    } completion:^(BOOL finished){
        self.isShown = YES;
    }];
}
- (void)hideModal:(UITapGestureRecognizer *)gr
{
    if (!self.isShown)
        return;
    
    // Create a slide-fade-out animation
    [UIView animateWithDuration:0.25 delay:0. options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self setAlpha:0];
                         [self.siblingView setAlpha:1];
                         [self setFrame: CGRectMake(0, -100, [[UIScreen mainScreen] bounds].size.width, 100)];
                     } completion:^(BOOL finished){
                         self.isShown = NO;
                         [self.parentView removeGestureRecognizer:self.gestureTap      ];
                         [self.parentView removeGestureRecognizer:self.gesturePinch    ];
                         [self.parentView removeGestureRecognizer:self.gestureSwipe    ];
                         [self.parentView removeGestureRecognizer:self.gesturePan      ];
                         [self.parentView removeGestureRecognizer:self.gestureRotation ];
                         [self.parentView removeGestureRecognizer:self.gestureLongPress];
                         [self.siblingView addGestureRecognizer:self.gestureLongPress];
                     }];
}

@end

