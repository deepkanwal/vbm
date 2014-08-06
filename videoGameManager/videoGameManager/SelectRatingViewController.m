//
//  SelectRatingViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/9/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "SelectRatingViewController.h"
#import "AddedGame.h"
#import "UITableView+Additions.h"
#import "UITableViewCell+Additions.h"

@interface SelectRatingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AddedGame *addedGame;
@property (strong, nonatomic) NSArray *ratings;
@end

@implementation SelectRatingViewController


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
    
    if ([self.detailItem isKindOfClass:[AddedGame class]]) {
        self.addedGame = self.detailItem;
    }
    
    [self.tableView setupDefaultApperance];
    
    self.ratings = @[ @"Unrated",
                      @"1",
                      @"2",
                      @"3",
                      @"4",
                      @"5",
                      @"6",
                      @"7",
                      @"8",
                      @"9",
                      @"10"];
    
    [self.tableView setUpHeaderWithTitle:@"Rate this game out of 10." title:NO];
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
    return self.ratings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PlatformCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell formatAsPickerCell];
    }
    
    [cell.textLabel setText:[self.ratings objectAtIndex:indexPath.row]];
    
    if (indexPath.row == self.addedGame.ratingValue) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self.addedGame setRatingValue:(int)indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
