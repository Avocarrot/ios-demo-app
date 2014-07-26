//
//  LoaderView.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "LoaderView.h"

@interface LoaderView()

@property UIImageView  *backgroundImage;
@property UIImageView  *spinnerImage;

@end

@implementation LoaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Apply LoaderView Style
        self.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f];
        self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avocarrot_loader.png"]];
        self.spinnerImage =    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avocarrot_spinner.png"]];
        
        [self.backgroundImage setFrame: CGRectMake(((frame.size.width/2)-80),((frame.size.height/2)-80),157.0f, 157.0f)];
        [self.spinnerImage    setFrame: CGRectMake(((frame.size.width/2)-80),((frame.size.height/2)-80),157.0f, 157.0f)];
        
        [self addSubview:self.backgroundImage ];
        [self addSubview:self.spinnerImage ];
        
        // Animate Avocarrot Spinner
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 4.0 ];
        rotationAnimation.duration = 2.f;
        rotationAnimation.cumulative = YES;
        
        [self.spinnerImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
    return self;
}

- (void) startCountdown
{
    // Hide superview
    [self.superview setAlpha:0.];
    
    // Show animation for 1 second and then remove this UIView it from its parent UIView
    [UIView animateWithDuration:0.25 delay:0.85 options:UIViewAnimationOptionCurveEaseOut
            animations:^{
                [self.superview setAlpha:1.];
                [self setAlpha:0.];
                [self.spinnerImage setAlpha:0.];
                [self.backgroundImage setAlpha:0.];
            } completion:^(BOOL finished){
                [self.spinnerImage removeFromSuperview];
                [self.backgroundImage removeFromSuperview];
                [self removeFromSuperview];
            }];
}

@end
