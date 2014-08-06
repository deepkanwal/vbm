//
//  SelectPlatformViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-08.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "SelectPlatformViewController.h"
#import "AddedGame.h"
#import "AddedPlatform.h"
#import "CoreDataHelper.h"
#import "UITableView+Additions.h"
#import "UITableViewCell+Additions.h"

#define kCUSTOM_PLATFORM                    @"Custom Platform"
#define kSEGUE_PLATFORM_TO_CUSTOM_PLATFORM  @"PlatformToCustomPlatformSegue"

@interface SelectPlatformViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *platformsArray;
@property (strong, nonatomic) NSArray *addedPlatformsArray;

@end

@implementation SelectPlatformViewController

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
	   
    NSMutableArray *addedPlatformsArray = [[NSMutableArray alloc] init];
    for (AddedGame *addedGame in self.arrayOfAddedGames) {
        if (addedGame.platform) {
            [addedPlatformsArray addObject:addedGame.platform.name];
        }
    }
    self.addedPlatformsArray = addedPlatformsArray;
    
    if (self.addedGame.platformsArray.count > 0) {
        self.platformsArray = [[self.addedGame platformsArray] arrayByAddingObject:kCUSTOM_PLATFORM];
    } else {
        self.platformsArray = @[kCUSTOM_PLATFORM];
    }
        
    [self.tableView setUpHeaderWithTitle:@"Select the platform you own this game for." title:NO];
    [self.tableView setupDefaultApperance];
    
    self.customPlatfromSelected = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.customPlatfromSelected) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.platformsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PlatformCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell formatAsGroupedCell];
    }
    
    NSString *platformName = [self.platformsArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:platformName];
    
    if ([self.addedGame.platform.name isEqualToString:cell.textLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if ([self.addedPlatformsArray containsObject:platformName]) {
        [cell.textLabel setAlpha:0.5f];
    } else {
        [cell.textLabel setAlpha:1.0f];
    }
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.addedGame.platformsArray.count == 0) {
        return @"This game is missing platform data on the GiantBomb Wiki. You can update the 'Game Details' for this game on the Wiki and wait for the changes to be approved or enter a custom platform.";
    } else {
        return nil;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *platformName = cell.textLabel.text;
    
    if ([self.addedPlatformsArray containsObject:platformName]) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if ([platformName isEqualToString:self.addedGame.platform.name]) {
            [self showToastWithMessage:@"You have already selected this platform."];
        } else {
            [self showToastWithMessage:@"This game has already been added on this platform."];
        }
        
        return;
    }
    
    if ([platformName isEqualToString:kCUSTOM_PLATFORM]) {
        [self performSegueWithIdentifier:kSEGUE_PLATFORM_TO_CUSTOM_PLATFORM sender:nil];
        return;
    }
    
    [self.addedGame updateWithPlatformOfName:cell.textLabel.text inContext:[CoreDataHelper sharedContext]];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSEGUE_PLATFORM_TO_CUSTOM_PLATFORM]) {
        [segue.destinationViewController setAddedGame:self.addedGame];
    }
}

@end
