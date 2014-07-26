//
//  InStreamGrouped.h
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "HelpView.h"
#import "InStreamGrouped.h"
#import "InStreamGroupedCell.h"

@interface InStreamGrouped ()

@property AvocarrotInstream *myAd;
@property NSMutableArray *data;
@property NSArray *titles, *icons;
@property UITableView *tableViewTest;
@property CGFloat screenWidth,screenHeight;
@property BOOL modalVisible;

@property HelpView *modalHelpView;

@end

@implementation InStreamGrouped
@synthesize myTableView;
@synthesize myHelpView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    NSArray *owls = [[NSArray alloc] initWithObjects:
                     [[NSArray alloc] initWithObjects:@"1. Australian Masked Owl",@"A barn owl of Southern New Guinea",nil ],
                     [[NSArray alloc] initWithObjects:@"2. Long-eared owl",@"Breeds in Europe, Asia, and North America",nil ],
                     [[NSArray alloc] initWithObjects:@"3. Snowy Owl",@"A large owl of the typical owl family Strigidae",nil ],
                     [[NSArray alloc] initWithObjects:@"4. Great Horned Owl",@"A large owl native to the Americas",nil ], nil];
    
    NSArray *flamingos = [[NSArray alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:@"1. Greater Flamingo",@"The most widespread species of the flamingo family",nil ],
                          [[NSArray alloc] initWithObjects:@"2. Lesser Flamingo",@"A species of flamingo occurring in sub-Saharan Africa",nil ],
                          [[NSArray alloc] initWithObjects:@"3. Chilean Flamingo",@"A large species of flamingo",nil ],
                          [[NSArray alloc] initWithObjects:@"4. Andean Flamingo",@"One of the rarest flamingos in the world",nil ], nil];
    
    NSArray *penguins =[[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects:@"1. Emperor penguin",@"The tallest and heaviest of all living penguin species",nil ],
                        [[NSArray alloc] initWithObjects:@"2. King penguin",@"The second largest species of penguin",nil ],
                        [[NSArray alloc] initWithObjects:@"3. Macaroni penguin",@"One of six species of crested penguin",nil ],
                        [[NSArray alloc] initWithObjects:@"4. Yellow-eyed penguin",@"A penguin native to New Zealand",nil ],
                        [[NSArray alloc] initWithObjects:@"5. African penguin",@"Also known as the jackass penguin",nil ],
                        [[NSArray alloc] initWithObjects:@"6. Chinstrap penguin",@"Found in the South Sandwich Islands",nil ],
                        [[NSArray alloc] initWithObjects:@"7. Erect-crested penguin",@"A penguin from New Zealand",nil ],
                        [[NSArray alloc] initWithObjects:@"8. Humboldt penguin",@"A South American penguin",nil ],
                        [[NSArray alloc] initWithObjects:@"9. Royal penguin",@"One of the crested penguins",nil ], nil];
    
    
    self.data = [[NSMutableArray alloc] initWithObjects:owls, flamingos, penguins, nil];
    self.titles = [[NSArray alloc] initWithObjects:@"Owls",@"Flamingos",@"Penguins", nil];
    self.icons = [[NSArray alloc] initWithObjects:@"icon_owls.png",@"icon_flamingos.png",@"icon_penguins.png", nil];

    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.screenHeight = [[UIScreen mainScreen] bounds].size.height;
    self.modalHelpView = [[HelpView alloc] initWithParentView:self.view  withSibling: self.myTableView withTitle:@"You can customize the look of your Native Ad using Avocarrot's online dashboard." andExitMessage:@"Tap screen to continue"];
    
    [self.view addSubview:self.modalHelpView];
    

    // ------------------------------------------------------------------------------------------------
    // Avocarrot
    // In-Stream Ad Unit Integration

    self.myAd = [[AvocarrotInstream alloc]initWithController:self minHeightForRow:20 tableView:self.myTableView];
    [self.myAd setSandbox:YES];
    [self.myAd setLogger:YES withLevel:@"ALL"];
    [self.myAd setApiKey:@"3dbab458941a2446e2b48ac866b42027f5cac288"];
    [self.myAd setFrequency:2 startPosition:2];
    [self.myAd setDelegate:self];
    [self.myAd loadAdForPlacement:@"instream_1"];
 
}

// ------------------------------------------------------------------------------------------------
// Avocarrot - ( Optional )

#pragma mark - AVInstreamAdDelegate

- (void)adDidNotLoad:(NSString *)reason
{
    NSLog(@"%@", [NSString stringWithFormat:@"Ad server did not return an ad because: %@",reason]);
}

- (void)adDidLoad
{
    NSLog(@"Ad server did return an ad");
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

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data objectAtIndex:section] count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"GroupedTableItem";
    InStreamGroupedCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[InStreamGroupedCell alloc] initWithData:[[self.data objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] andIcon:[self.icons objectAtIndex:indexPath.section]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0]
                                                    message:[[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1]
                                                   delegate:nil
                                          cancelButtonTitle:@"Alright"
                                          otherButtonTitles:nil];
    [alert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.titles objectAtIndex:section];    
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 4;
}
@end
