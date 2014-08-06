//
//  ShareViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/16/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "ShareViewController.h"
#import "UITableView+Additions.h"
#import "UITableViewCell+Additions.h"
#import "UIImage+Additions.h"
#import "UIHelper.h"
#import "AddedGame.h"
#import "AddedPlatform.h"

#define kROW_INFO_PROGRESS @"Progress"
#define kROW_INFO_BEATEN @"Beaten"
#define kROW_INFO_NOWPLAYING @"Now Playing"
#define kROW_INFO_FAVOURITE @"Favourite"
#define kROW_INFO_NOTES @"Notes"
#define kROW_INFO_RATING @"Rating"

#define kROW_DONE @"Export"

@interface ShareViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) BOOL shareProgress;
@property (nonatomic, assign) BOOL shareNotes;
@property (nonatomic, assign) BOOL shareRating;
@property (nonatomic, assign) BOOL shareNowPlaying;
@property (nonatomic, assign) BOOL shareIsBeaten;
@property (nonatomic, assign) BOOL shareFavourite;

@property (strong, nonatomic) NSArray *rowTitles;
@property (strong, nonatomic) NSString *listName;

@property (strong, nonatomic) MFMailComposeViewController *mailViewController;

@end

@implementation ShareViewController

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
    [self setupProperties];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupProperties
{

    NSMutableArray *infoToAdd = [NSMutableArray arrayWithArray:@[kROW_INFO_PROGRESS, kROW_INFO_RATING, kROW_INFO_NOTES, kROW_INFO_FAVOURITE]];
    
    if (self.listType == ListTypeNowPlaying) {
        [infoToAdd addObject:kROW_INFO_BEATEN];
    } else if (self.listType == ListTypeFullBacklog) {
        [infoToAdd addObject:kROW_INFO_BEATEN];
    }
    
    if (self.listType == ListTypeAll) {
        [infoToAdd addObject:kROW_INFO_BEATEN];
        [infoToAdd addObject:kROW_INFO_NOWPLAYING];
    }
    
    self.rowTitles = @[infoToAdd, @[kROW_DONE]];

    switch (self.listType) {
        case ListTypeAll:
            self.listName = @"All Games";
            break;
        case ListTypeBacklog:
            self.listName = @"Backlog";
            break;
        case ListTypeFullBacklog:
            self.listName = @"Full Backlog";
            break;
        case ListTypeNowPlaying:
            self.listName = @"Now Playing";
            break;
        default:
            break;
    }
    
    [self.tableView setupDefaultApperance];
    [self.tableView setUpHeaderWithTitle:[NSString stringWithFormat:@"Select information to include in this list."] title:NO];
}

#pragma mark - TableView Datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rowTitles.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowTitlesArray = [self.rowTitles objectAtIndex:section];
    return [rowTitlesArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"AddGameCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *cellTitle = [[self.rowTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell.textLabel setText:cellTitle];
    
    if ([cellTitle isEqualToString:kROW_DONE]) {
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    } else {
        [cell.textLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self applyChevronIfNecessaryOnCellAtIndexPath:indexPath selected:NO];
    }
    
    return cell;
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.rowTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kROW_DONE]) {
        [self generateTextFile];
    } else {
        [self applyChevronIfNecessaryOnCellAtIndexPath:indexPath selected:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)applyChevronIfNecessaryOnCellAtIndexPath:(NSIndexPath*)indexPath selected:(BOOL)selected
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text;
    
    BOOL showAccessoryView = NO;
    
    if ([title isEqualToString:kROW_INFO_BEATEN]) {
        if (selected) self.shareIsBeaten = !self.shareIsBeaten;
        showAccessoryView = self.shareIsBeaten;
    } else if ([title isEqualToString:kROW_INFO_FAVOURITE]) {
        if (selected) self.shareFavourite = !self.shareFavourite;
        showAccessoryView = self.shareFavourite;
    } else if ([title isEqualToString:kROW_INFO_NOTES]) {
        if (selected) self.shareNotes = !self.shareNotes;
        showAccessoryView = self.shareNotes;
    } else if ([title isEqualToString:kROW_INFO_NOWPLAYING]) {
        if (selected) self.shareNowPlaying = !self.shareNowPlaying;
        showAccessoryView = self.shareNowPlaying;
    } else if ([title isEqualToString:kROW_INFO_PROGRESS]) {
        if (selected) self.shareProgress = !self.shareProgress;
        showAccessoryView = self.shareProgress;
    } else if ([title isEqualToString:kROW_INFO_RATING]) {
        if (selected) self.shareRating = !self.shareRating;
        showAccessoryView = self.shareRating;
    }
    
    if (showAccessoryView) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
}

- (void)generateTextFile
{
    [self showLoadingView];
    
    NSPredicate *predicate = nil;
    switch (self.listType) {
        case ListTypeBacklog:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", AddedGameAttributes.isBeaten, [NSNumber numberWithBool:NO], AddedGameAttributes.nowPlaying, [NSNumber numberWithBool:NO]];
            break;
        case ListTypeFullBacklog:
            predicate = [NSPredicate predicateWithFormat:@"%K != %@ AND %K = %@", AddedGameAttributes.progress, [NSNumber numberWithInteger:100], AddedGameAttributes.nowPlaying, [NSNumber numberWithBool:NO]];
            break;
        case ListTypeNowPlaying:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", AddedGameAttributes.nowPlaying, [NSNumber numberWithBool:YES]];
            break;
        default:
            break;
    }
    
    NSArray *games = [AddedGame getGamesWithPredicate:predicate];
    
    if (games.count == 0) {
        [self hideLoadingView];
        [self showAlertViewWithTitle:@"Error" andMessage:@"There are no games in this list."];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSMutableString *textString = [[NSMutableString alloc] init];
    [textString appendString:[NSString stringWithFormat:@"%@ List\n", self.listName]];
    
    for (AddedGame *game in games) {
        [textString appendString:[self stringForGame:game]];
    }
    
    [textString appendString:[NSString stringWithFormat:@"\nGenerated on %@ via Videogame Backlog Manager\n", [NSDate date]]];
    
    [self showMailComposerViewWithBody:textString];
}

- (NSString*)stringForGame:(AddedGame*)game
{
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:@"\n"];
    [string appendString:[NSString stringWithFormat:@"Name: %@\n", game.gameName]];
    [string appendString:[NSString stringWithFormat:@"Platform: %@\n", game.platform.name]];
    
    if (self.shareProgress)
        [string appendString:[NSString stringWithFormat:@"Progress: %d %%\n", game.progressValue]];
    if (self.shareRating)
        [string appendString:[NSString stringWithFormat:@"Rating: %@\n", game.ratingValue > 0 ? [NSString stringWithFormat:@"%d / 10", game.ratingValue] : @"N/A"]];
    if (self.shareNotes)
        [string appendString:[NSString stringWithFormat:@"Notes: %@\n", game.notes.length > 0 ? [NSString stringWithFormat:@"\n%@", game.notes] : @"No Notes"]];
    if (self.shareIsBeaten)
        [string appendString:[NSString stringWithFormat:@"Is Beaten: %@\n", game.isBeatenValue ? @"Yes" : @"No"]];
    if (self.shareNowPlaying)
        [string appendString:[NSString stringWithFormat:@"Now Playing: %@\n", game.nowPlayingValue ? @"Yes" : @"No"]];
    if (self.shareFavourite)
        [string appendString:[NSString stringWithFormat:@"Favourite: %@\n", game.isFavouriteValue ? @"Yes" : @"No"]];
    
    return string;
}

#pragma mark - MailComposer methods

- (void)showMailComposerViewWithBody:(NSString*)body
{
    if ([MFMailComposeViewController canSendMail]) {
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:kUI_COLOR_MAIL_COMPOSER] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        self.mailViewController = [[MFMailComposeViewController alloc] init];
        self.mailViewController.mailComposeDelegate = self;
        [self.mailViewController setSubject:[NSString stringWithFormat:@"VBM %@ List", self.listName]];
        [self.mailViewController setMessageBody:body isHTML:NO];
        [self presentViewController:self.mailViewController animated:YES completion:^{
            [self hideLoadingView];
        }];
        
    } else {
        [self hideLoadingView];
        
        [self showAlertViewWithTitle:@"Error" andMessage:@"This device cannot send an email in its current state."];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - MailComposeDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:kUI_COLOR_DEFAULT_TINT] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result != MFMailComposeResultCancelled) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

@end
