//
//  InStreamSimple.m
//  SampleApp
//
//  Created by Avocarrot Limited
//  Copyright (c) 2014 Avocarrot Limited. All rights reserved.
//

#import "HelpView.h"
#import "InStreamSimple.h"
#import "InStreamSimpleCell.h"

@interface InStreamSimple ()

@property AvocarrotInstream *myAd;
@property NSArray *data;
@property CGFloat screenWidth, screenHeight;
@property HelpView *modalHelpView;

@end

@implementation InStreamSimple
@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.data =[[NSArray alloc] initWithObjects:
                [[NSArray alloc] initWithObjects:@"1. Emperor penguin"      ,@"The tallest and heaviest of all living penguin species",nil ],
                [[NSArray alloc] initWithObjects:@"2. King penguin"         ,@"The second largest species of penguin",nil ],
                [[NSArray alloc] initWithObjects:@"3. Macaroni penguin"     ,@"One of six species of crested penguin",nil ],
                [[NSArray alloc] initWithObjects:@"4. Yellow-eyed penguin"  ,@"A penguin native to New Zealand",nil ],
                [[NSArray alloc] initWithObjects:@"5. African penguin"      ,@"Also known as the jackass penguin",nil ],
                [[NSArray alloc] initWithObjects:@"6. Chinstrap penguin"    ,@"Found in the South Sandwich Islands",nil ],
                [[NSArray alloc] initWithObjects:@"7. Erect-crested penguin",@"A penguin from New Zealand",nil ],
                [[NSArray alloc] initWithObjects:@"8. Humboldt penguin"     ,@"A South American penguin",nil ],
                [[NSArray alloc] initWithObjects:@"9. Royal penguin"        ,@"One of the crested penguins",nil ], nil];


    self.screenWidth  = [[UIScreen mainScreen] bounds].size.width;
    self.screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.modalHelpView = [[HelpView alloc] initWithParentView:self.view  withSibling: self.myTableView withTitle:@"This Native Ad unit is suitable for lists such as news feeds." andExitMessage:@"Tap screen to continue"];
    
    [self.view addSubview:self.modalHelpView];
    
    
    // ------------------------------------------------------------------------------------------------
    // Avocarrot
    // Native In-Stream Ad Integration

    self.myAd = [[AvocarrotInstream alloc]initWithController:self minHeightForRow:80 tableView:self.myTableView];
    [self.myAd setSandbox:YES];
    [self.myAd setApiKey:@"3dbab458941a2446e2b48ac866b42027f5cac288"];
    [self.myAd setFrequency:4 startPosition:3];
    [self.myAd setDelegate:self];
    [self.myAd setLogger:YES withLevel:@"ALL"];
    [self.myAd loadAdForPlacement:@"instream_2"];
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
    return [self.data count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    InStreamSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[InStreamSimpleCell alloc] initWithData:[self.data objectAtIndex:indexPath.row ] andIcon:@"icon_penguins.png"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[self.data objectAtIndex:indexPath.row] objectAtIndex:0]
                                                    message:[[self.data objectAtIndex:indexPath.row] objectAtIndex:1]
                                                   delegate:nil
                                          cancelButtonTitle:@"Alright"
                                          otherButtonTitles:nil];
    [alert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"List of Penguins";
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 4;
}

@end

