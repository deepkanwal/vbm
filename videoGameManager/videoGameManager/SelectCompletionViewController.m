//
//  SelectCompletionViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "SelectCompletionViewController.h"
#import "AddedGame.h"
#import "UITableView+Additions.h"
#import "UITableViewCell+Additions.h"

@interface SelectCompletionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *completionPercentages;
@property (strong, nonatomic) AddedGame *addedGame;
@end

@implementation SelectCompletionViewController

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
    
    self.completionPercentages = @[ @"0 %", @"10 %", @"20 %", @"30 %", @"40 %", @"50 %", @"60 %", @"70 %", @"80 %", @"90 %", @"100 %"];
    [self.tableView setUpHeaderWithTitle:@"Estimate your completion progress in the game." title:NO];
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
    return self.completionPercentages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PlatformCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell formatAsPickerCell];
    }
    
    [cell.textLabel setText:[self.completionPercentages objectAtIndex:indexPath.row]];
    
    if ([[NSString stringWithFormat:@"%d %%", self.addedGame.progressValue] isEqualToString:cell.textLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *percentageString = [self.completionPercentages objectAtIndex:indexPath.row];
    NSInteger percentage = 0;
    
    if (percentageString.length == 4) {
        percentage = [[percentageString substringToIndex:2] integerValue];
    } else if (percentageString.length == 5) {
        percentage = 100;
    }

    [self.addedGame setProgressValue:(int)percentage];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
