//
//  ShareListViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/16/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "ShareListViewController.h"
#import "ShareViewController.h"
#import "UITableView+Additions.h"

#define kSEGUE_SHARE_LIST_TO_SHARE_SEGUE @"ShareListToShareSegue"

@interface ShareListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) ListType listType;
@property (nonatomic, strong) NSArray *rowTitles;
@end

@implementation ShareListViewController

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
    self.rowTitles = @[@"Now Playing", @"Backlog", @"Full Backlog", @"All Games"];
    [self.tableView setupDefaultApperance];
    [self.tableView setUpHeaderWithTitle:@"Select the list to share. A text file will be generated for that list which can be shared via email." title:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rowTitles count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"ShareListCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *cellTitle = [self.rowTitles objectAtIndex:indexPath.row];
    [cell.textLabel setText:cellTitle];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    
    return cell;
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.listType = (int)indexPath.row;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:kSEGUE_SHARE_LIST_TO_SHARE_SEGUE sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShareViewController* shareViewController = (ShareViewController*)segue.destinationViewController;
    shareViewController.listType = self.listType;
}

@end
