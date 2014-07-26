//
//  HelpView.h
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpView : UIView

- (id) initWithParentView:(UIView *) parentView  withSibling:(UIView *) siblingView withTitle:(NSString *)title andExitMessage:(NSString *)message ;

- (void) update;

@end
