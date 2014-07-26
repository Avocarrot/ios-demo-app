//
//  MenuViewController.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "MenuViewController.h"
#import "LoaderView.h"

@interface MenuViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation MenuViewController

@synthesize inStreamExample1;
@synthesize inStreamExample2;
@synthesize customExample1;
@synthesize customExample2;
@synthesize interstitialExample1;
@synthesize interstitialExample2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set LoaderView on start (gets removed automatically)
    LoaderView *avocarrotLoader = [[LoaderView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [avocarrotLoader startCountdown];
    [self.view addSubview:avocarrotLoader];
    
    // Apply styles for menu buttons
    [self  setStyle:self.inStreamExample1];
    [self  setStyle:self.inStreamExample2];
    [self  setStyle:self.customExample1];
    [self  setStyle:self.customExample2];
    [self  setStyle:self.interstitialExample1];
    [self  setStyle:self.interstitialExample2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setStyle:(UIButton *)button
{
    [button.layer setBorderWidth:1];
    [button.layer setBorderColor:[[UIColor colorWithRed:213/255.0 green:100/255.0 blue:69/255.0 alpha:1] CGColor]];
    [button.layer setCornerRadius:4.0];
    [button.layer setShadowOffset: CGSizeMake(0, 1) ];
    [button.layer setShadowRadius:1];
    [button.layer setShadowOpacity:0.1];
    [button setBackgroundColor:[UIColor colorWithRed:213/255.0 green:100/255.0 blue:69/255.0 alpha:1]];
    [button setTintColor:[UIColor whiteColor] ];
}

@end

