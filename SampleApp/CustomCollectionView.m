//
//  CustomCollectionView.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "HelpView.h"
#import "CustomCollectionView.h"
#import "CustomCollectionViewCell.h"

static NSString *const CellIdentifier = @"MyCell";
@interface CustomCollectionView ()

@property CGFloat screenWidth;
@property CGFloat screenHeight;

@property UIActivityIndicatorView *spinner;
@property NSArray *data;

@property HelpView   *modalHelpView;
@property AVCustomAd *myAd;

@end

@implementation CustomCollectionView
@synthesize myCollectionView;

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

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
	
    self.data =  [[NSArray alloc] initWithObjects:
                  
                    [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"Burrito", @"icon_burrito.png",nil],
                        [[NSArray alloc] initWithObjects:@"Burger", @"icon_burger.png",nil], nil ],
                    [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"Soup", @"icon_soup.png",nil],
                        [[NSArray alloc] initWithObjects:@"Pizza", @"icon_pizza.png",nil],
                        [[NSArray alloc] initWithObjects:@"Carbonara", @"icon_carbonara.png",nil], nil ],
                  [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"Omelette", @"icon_omelette.png",nil], nil ],
                  [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"Bread", @"icon_bread.png",nil],
                        [[NSArray alloc] initWithObjects:@"Burrito", @"icon_burrito.png",nil], nil ],
                    [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"Burger", @"icon_burger.png",nil],
                        [[NSArray alloc] initWithObjects:@"Omelette", @"icon_omelette.png",nil],
                        [[NSArray alloc] initWithObjects:@"Soup", @"icon_soup.png",nil], nil ],
                    [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"Pizza", @"icon_pizza.png",nil],
                        [[NSArray alloc] initWithObjects:@"Carbonara", @"icon_carbonara.png",nil], nil ],
                    [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"Bread", @"icon_bread.png",nil],
                        [[NSArray alloc] initWithObjects:@"Burrito", @"icon_burrito.png",nil],
                        [[NSArray alloc] initWithObjects:@"Burger", @"icon_burger.png",nil], nil ],
                    [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"Omelette", @"icon_omelette.png",nil],
                        [[NSArray alloc] initWithObjects:@"Soup", @"icon_soup.png",nil],
                        [[NSArray alloc] initWithObjects:@"Pizza", @"icon_pizza.png",nil],
                        [[NSArray alloc] initWithObjects:@"Carbonara", @"icon_carbonara.png",nil], nil ],
                  nil];
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.modalHelpView = [[HelpView alloc] initWithParentView:self.view  withSibling: self.myCollectionView withTitle:@"You can show a Native Ad using your own custom style and presentation logic." andExitMessage:@"Tap screen to continue"];
    [self.view addSubview:self.modalHelpView];
    
    [ self.myCollectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
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

- (void)adDidLoad:(AVCustomAd *)ad
{
    // Store Native Ad received
    self.myAd = ad;
    
    // Force collection view to redraw itself
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^(void){
        [self.myCollectionView reloadData];
    });
}
- (void)onAdImpression: (NSString *) message
{
    NSLog(@"%@", [NSString stringWithFormat:@"Impression request for Native Ad with result: %@",message]);
}
- (void)onAdClick: (NSString *) message
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


-(void)viewDidLayoutSubviews
{
    [self.modalHelpView update];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.data objectAtIndex:section] count];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger numberOfItems = [[self.data objectAtIndex:indexPath.section] count];
    
    CGFloat extension = 1.;
    CGFloat cellheight = 130.;
    
    CGFloat cellPaddingY = 7.f;
    CGFloat cellPaddingX = 5.f;
    CGFloat totalPaddingX = cellPaddingX * ((numberOfItems-1)+2);
    
    CGFloat width = (self.screenWidth / (CGFloat)numberOfItems);
    CGFloat widthAndPadding = width - (totalPaddingX/numberOfItems);
    
    CGFloat height = cellheight * extension - cellPaddingY;
    CGFloat offsetX = (width)*(indexPath.row) + cellPaddingX ;
    CGFloat offsetY = cellheight * indexPath.section * extension + cellPaddingY;
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    CGRect cellFrame = CGRectMake(offsetX,  offsetY, widthAndPadding, height);
    
    // Clear subvies from previous cell
    NSArray *viewsToRemove = [cell subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    // Show Avocarrot ad in Cell at section:0 row:2
    if ((indexPath.row == 0) && (indexPath.section == 2)){
        
        [cell renderWithFrame:cellFrame];
        [self showAdInCell:cell];
        
    // Otherwise show normal cell
    } else {
        
        [cell renderWithFrame: cellFrame
                    withImage:[[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1]
                     withText:[[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0]];
    }
    return cell;
}

- (void) showAdInCell:(UICollectionViewCell *)cell
{
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.spinner setCenter:CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2)];
    
    [cell addSubview:self.spinner ];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.spinner startAnimating];
    });
    
    if (self.myAd == nil)
        return;

    [self.spinner stopAnimating];
    [self.spinner removeFromSuperview];

    UIImageView *cellImage = [[UIImageView alloc] init];
 
    if (([self.myAd getImageHeight]>0) &&([self.myAd getImageWidth]>0)){
        CGFloat imageWidth = ((CGFloat)[[self.myAd getImageHeight]integerValue]/(CGFloat)[[self.myAd getImageWidth]integerValue])*cell.frame.size.height;
        cellImage.frame = CGRectMake(0, 0, imageWidth,cell.frame.size.height);
    }
    
    CGFloat padding = 10.;
    UILabel *cellText = [[UILabel alloc] initWithFrame:CGRectMake(cellImage.frame.size.width+padding,35,cell.frame.size.width- cellImage.frame.size.width-padding, 40)];
    
    UILabel *cellSponsored = [[UILabel alloc] initWithFrame:CGRectMake(cellImage.frame.size.width+padding,5,cell.frame.size.width- cellImage.frame.size.width, 30)];
    
    UIButton *cellButton= [[UIButton alloc] initWithFrame:CGRectMake(cellImage.frame.size.width+padding,83,cell.frame.size.width- cellImage.frame.size.width- padding-6, 35)];
    
    
    cellText.lineBreakMode = NSLineBreakByWordWrapping;
    cellText.numberOfLines = 0;
    cellText.textColor  = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:1.f];
    cellText.text = [self.myAd getHeadline];
    
    cellSponsored.text = @"Sponsored Ad";
    cellSponsored.textColor = [UIColor colorWithRed:0.48f green:0.48f blue:0.48f alpha:0.8f] ;
    
    // Set Fonts
    [cellText setFont:[UIFont systemFontOfSize:15]];
    [cellSponsored setFont:[UIFont systemFontOfSize:12]];
    [cellButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    cellButton.backgroundColor = [UIColor colorWithRed:224/255.f green:202/255.f blue:155/255.f alpha:1.f] ;
    [cellButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cellButton setTitle:[self.myAd getCTAText] forState:UIControlStateNormal];
    [cellButton setTitleColor:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f] forState:UIControlStateNormal];

    [cell addSubview:cellImage];
    [cell addSubview:cellSponsored];
    [cell addSubview:cellText ];
    [cell addSubview:cellButton ];
    
    cell.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f] ;
     
    if ([self.myAd getImage] !=nil){
       [cellImage setImage:[self.myAd getImage]];
       [self.myAd bindToView:cell];
        
    }
}

-(void)buttonClick:(id)sender
{
    [self.myAd handleClick];
}
 @end





