//
//  CustomPullToRefresh.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "CustomPullToRefresh.h" 

#define PANEL_TIME   0.5
#define PANEL_HEIGHT 185

@interface CustomPullToRefresh ()
@property UIView      *customAdUIView;
@property UILabel     *adHeadline,
                      *adDescription;
@property UIImageView *adImage;
@property UIButton    *adButton;

@property CGFloat     position;

@property BOOL        hidden,
                      isAnimating;

@property AVCustomAd *myAd;

@end

@implementation CustomPullToRefresh

@synthesize scrollPanel;
@synthesize infoLabel;
@synthesize instructionLabel;

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
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

    // Show a loading message on the screen
    [self.infoLabel setText:@"Loading a Native Ad..."];
    
    // Construct UIView where the Custom Native Ad will be displayed
    self.customAdUIView = [[UIView alloc] initWithFrame:CGRectMake(0, -PANEL_HEIGHT, 360, PANEL_HEIGHT)];
    self.customAdUIView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.f];
    
    UIImageView *shadowImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_shadow.png"]];
    UILabel *sponsored        = [[UILabel     alloc] initWithFrame:CGRectMake(170,50, 100,30)];
    self.adImage              = [[UIImageView alloc] init];
    self.adHeadline           = [[UILabel     alloc] initWithFrame:CGRectMake(0,10, 320,30)];
    self.adDescription        = [[UILabel     alloc] initWithFrame:CGRectMake(170,65, 130,70)];
    self.adButton             = [[UIButton    alloc] initWithFrame:CGRectMake(170,130,100, 40)];
    
    shadowImage.contentMode = UIViewContentModeScaleToFill;
    shadowImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    shadowImage.frame = CGRectMake(0, self.customAdUIView.frame.size.height-10, self.customAdUIView.frame.size.width, 10);
    [shadowImage setAlpha:0.2];

    [sponsored setTextColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.f]];
    [sponsored setFont:[UIFont systemFontOfSize:13]];
 
    [self.adImage.layer setBorderColor:[[UIColor colorWithRed:51/255.f green:100/255.f blue:181/255.f alpha:1.f] CGColor]];
    [self.adImage.layer setBorderWidth:4.0f];
    [self.adHeadline setTextAlignment:NSTextAlignmentCenter];
    
    [self.adButton setBackgroundColor: [UIColor colorWithRed:51/255.f green:100/255.f blue:181/255.f alpha:1.f]];
    [self.adButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.adButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.adButton setTitle:@"Click Here" forState:UIControlStateNormal];
    [self.adButton setTitleColor:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f] forState:UIControlStateNormal];

    [self.adHeadline setFont:[UIFont systemFontOfSize:16]];
    
    [self.adDescription setFont:[UIFont systemFontOfSize:14]];
    
    sponsored.text = @"Sponsored Ad";
    [self.adHeadline setText: @"Ad Headline "];
    [self.adDescription setText: @"Ad description"];
    [self.adDescription setNumberOfLines: 0];
    [self.adDescription setLineBreakMode:NSLineBreakByWordWrapping];
    [self.adDescription setTextAlignment:NSTextAlignmentJustified];
    
    [self.customAdUIView addSubview:sponsored];
    [self.customAdUIView addSubview:shadowImage];
    [self.customAdUIView addSubview:self.adImage];
    [self.customAdUIView addSubview:self.adHeadline];
    [self.customAdUIView addSubview:self.adDescription];
    [self.customAdUIView addSubview:self.adButton];
    
    [self.view addSubview:self.customAdUIView];

    [self.scrollPanel setDelegate:self];
    [self.scrollPanel setContentSize:CGSizeMake(320, 500)];
    
    // ------------------------------------------------------------------------------------------------
    // Avocarrot
    // Native Custom Ad Integration
    
    AvocarrotCustom * avocarrotCustom = [[AvocarrotCustom alloc] init];
    [avocarrotCustom setApiKey:@"3dbab458941a2446e2b48ac866b42027f5cac288"];
    [avocarrotCustom setDelegate:self];
    [avocarrotCustom setSandbox:YES];
    [avocarrotCustom setLogger:YES withLevel:@"ALL"];
    [avocarrotCustom loadAdForPlacement:@"custom"];

}

// ------------------------------------------------------------------------------------------------
// Avocarrot - ( Optional )

#pragma mark - AVCustomAdDelegate

- (void) adDidLoad:(AVCustomAd *)ad
{
    self.myAd = ad;

    // Bind myAd to a UIView
    [self.myAd bindToView:self.customAdUIView];

    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^(void){
        
        // Update UI Labels
        [self.instructionLabel setText:@"Swipe Down to see the Ad"];
        [self.infoLabel setText:@"A Native Ad has been loaded"];
        
        // Get Native Ad CTA Text
        if ([[self.myAd getCTAText] length]!=0)
            [self.adButton setTitle:[self.myAd getCTAText] forState:UIControlStateNormal];
        
        // Get Native Ad Headline
        if ([[self.myAd getHeadline] length]!=0)
             [self.adHeadline setText:[self.myAd getHeadline]];
        
        // Get Native Ad Description
        if ([[self.myAd getSubHeadline] length]!=0)
             [self.adDescription setText:[self.myAd getSubHeadline]];
        
        // Get Native Ad Image
        if (([self.myAd getImageHeight]>0)&&([self.myAd getImageWidth]>0) && ([self.myAd getImage] != nil)){
        
            // Keep aspect ratio
            CGFloat imageHeight = 120;
            CGFloat imageWidth = ((CGFloat)[[self.myAd getImageHeight]integerValue]/(CGFloat)[[self.myAd getImageWidth]integerValue])*imageHeight;
            
            [self.adImage setFrame: CGRectMake(10, 50, imageWidth,imageHeight)];
            [self.adImage setImage:[self.myAd getImage]];
        }
    });
}

- (void)onAdImpression: (NSString *) message
{
    NSLog(@"%@", [NSString stringWithFormat:@"Impression request for Native Ad with result: %@",message]);
}
- (void)onAdClick:      (NSString *) message
{
    NSLog(@"%@", [NSString stringWithFormat:@"Click request for Native Ad with result: %@",message]);
}
- (void)adDidNotLoad:(NSString *)reason
{
    NSLog(@"%@", [NSString stringWithFormat:@"Ad server did not return an ad because: %@",reason]);
}
- (void)adDidFailToLoad:(NSError *)error
{
    NSLog(@"%@", [NSString stringWithFormat:@"Ad server fail to load ad because: %@",[error localizedDescription]]);
}
- (void)userWillLeaveApp
{
    NSLog(@"%@", @"User will leave app");
}

// ------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) showView
{
    self.hidden = YES;
    self.isAnimating = YES;
    [self performSelector:@selector(endAnimation:) withObject:nil afterDelay:PANEL_TIME];
    [UIView animateWithDuration:PANEL_TIME animations:^(void){
        [self.instructionLabel setText:@"Swipe Up to close the Ad"];
        [self.scrollPanel setFrame:CGRectMake(0, self.scrollPanel.frame.origin.y+PANEL_HEIGHT, 320, self.scrollPanel.frame.size.height)];
        [self.customAdUIView setFrame:CGRectMake(0, self.customAdUIView.frame.origin.y+PANEL_HEIGHT, 320, self.customAdUIView.frame.size.height)];
    }];
}

-(void) hideView
{
    self.hidden = NO;
    self.isAnimating = YES;
    [self performSelector:@selector(endAnimation:) withObject:nil afterDelay:PANEL_TIME];
    [UIView animateWithDuration:PANEL_TIME animations:^(void){
        [self.instructionLabel setText:@"Swipe Down to see the Ad"];
        [self.scrollPanel setFrame:CGRectMake(0, self.scrollPanel.frame.origin.y-PANEL_HEIGHT, 320, self.scrollPanel.frame.size.height)];
        [self.customAdUIView setFrame:CGRectMake(0, self.customAdUIView.frame.origin.y-PANEL_HEIGHT, 320, self.customAdUIView.frame.size.height)];
    } completion:^(BOOL finished){ }];
    
}
-(void)endAnimation:(id)sender
{
    @synchronized(self){
        self.isAnimating = NO;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentPostion = scrollView.contentOffset.y;
    
    if (currentPostion - self.position > 25 ) {
        self.position = currentPostion;
        
        if (self.isAnimating)
            return;
        
        if (self.hidden)
            [self hideView];
        
    } else if (self.position - currentPostion > 25) {
        self.position = currentPostion;
        
        if (self.isAnimating)
            return;
        
        if (scrollView.contentOffset.y < 0 && !self.hidden)
            [self showView];
    }
}

-(void)buttonClick:(id)sender
{
    [self.myAd handleClick];
}


@end






