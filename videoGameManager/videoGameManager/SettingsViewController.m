//
//  SettingsViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/3/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "SettingsViewController.h"
#import "UITableView+Additions.h"
#import "UITableViewCell+Additions.h"
#import "UIImage+Additions.h"
#import "UIHelper.h"
#import "GeneralHelpers.h"
#import "CoreDataHelper.h"
#import <DropboxSDK/DropboxSDK.h>

#define kSECTION_OVERALL_STATS @"Overall Stats"
#define kSECTION_SHARE @"Share Games List"
#define kSECTION_FEEDBACK @"Send Feedback"
#define kSECTION_FAQ @"FAQ"
#define kSECTION_ABOUT @"About"
#define kSECTION_DROPBOX @"Configure Backup with Dropbox"
#define kSECTION_BACKUP @"Back Up"
#define kSECTION_RESTORE @"Restore"

#define kSEGUE_SETTINGS_TO_BACKUP @"SettingsToBackUpSegue"
#define kSEGUE_SETTINGS_TO_ABOUT @"SettingToAboutSegue"
#define kSEGUE_SETTINGS_TO_STATS @"SettingsToStatsSegue"
#define kSEGUE_SETTINGS_TO_SHARE @"SettingsToShareListSegue"
#define kSEGUE_SETTINGS_TO_FAQ @"SettingsToFAQSegue"

#define kBACKUP_FILE_NAME @"VBM_BACKUP"
#define kBACKUP_FILE_PATH [NSString stringWithFormat:@"/%@", kBACKUP_FILE_NAME]
#define kRESTORE_FILE_NAME @"VBM_RESTORE"


@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) MFMailComposeViewController *mailViewController;

@property (strong, nonatomic) DBRestClient *dbRestClient;
@property (strong, nonatomic) NSString *revision;
@property (strong, nonatomic) NSString *restorePath;

@property (strong, nonatomic) UIAlertView *backupConfAlertView;
@property (strong, nonatomic) UIAlertView *restoreConfAlertView;

@end

@implementation SettingsViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dropboxLinked) name:kNOTIFICATION_DROPBOX_LINKED object:nil];
    
    [self setupProperties];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([DBSession sharedSession].isLinked) {
        self.dbRestClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.dbRestClient.delegate = self;
    } else {
        self.dbRestClient = nil;
        self.dbRestClient.delegate = nil;
    }
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupProperties
{
    self.sectionTitles = @[@[kSECTION_OVERALL_STATS], @[kSECTION_BACKUP, kSECTION_RESTORE, kSECTION_DROPBOX], @[kSECTION_SHARE], @[kSECTION_FEEDBACK, kSECTION_FAQ, kSECTION_ABOUT]];
    [self.tableView setupDefaultApperance];
}

#pragma mark - TableView Datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTitles.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sectionTitles objectAtIndex:section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"AddGameCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell formatAsGroupedCell];
    }

    [cell.textLabel setText:[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    [cell.textLabel setTextColor:[UIColor darkTextColor]];
    
    if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_RESTORE] ||
        [[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_BACKUP]) {
        if ([DBSession sharedSession].isLinked == NO) {
            [cell.textLabel setTextColor:[UIColor lightGrayColor]];
        }
    }
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == self.sectionTitles.count - 1) {
        return [NSString stringWithFormat:@"\nVersion %@", kVERSION_STRING];
    }
    return nil;
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_FEEDBACK]) {
        [self showMailComposerView];
    } else if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_ABOUT]) {
        [self performSegueWithIdentifier:kSEGUE_SETTINGS_TO_ABOUT sender:nil];
    } else if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_OVERALL_STATS]) {
        [self performSegueWithIdentifier:kSEGUE_SETTINGS_TO_STATS sender:nil];
    } else if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_SHARE]) {
        [self performSegueWithIdentifier:kSEGUE_SETTINGS_TO_SHARE sender:nil];
    } else if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_FAQ]) {
        [self performSegueWithIdentifier:kSEGUE_SETTINGS_TO_FAQ sender:nil];
    } else if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_BACKUP]) {
        
        if ([DBSession sharedSession].isLinked) {
            [self beginBackup];
        } else {
            [self showToastWithMessage:@"You must configure back up with a Dropbox account first"];
        }
        
    } else if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_RESTORE]) {
        
        if ([DBSession sharedSession].isLinked) {
            [self beginRestore];
        } else {
            [self showToastWithMessage:@"You must configure back up with a Dropbox account first"];
        }
        
        
    } else if ([[[self.sectionTitles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:kSECTION_DROPBOX]) {
        [self performSegueWithIdentifier:kSEGUE_SETTINGS_TO_BACKUP sender:nil];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MailComposer methods

- (void)showMailComposerView
{
    [self showLoadingView];
    
    if ([MFMailComposeViewController canSendMail]) {
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:kUI_COLOR_MAIL_COMPOSER] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        self.mailViewController = [[MFMailComposeViewController alloc] init];
        self.mailViewController.mailComposeDelegate = self;
        [self.mailViewController setSubject:[NSString stringWithFormat:@"VBM Support v%@", kVERSION_STRING]];
        [self.mailViewController setToRecipients:@[@"videogamebacklogmanager@gmail.com"]];
        
        [self presentViewController:self.mailViewController animated:YES completion:^{
            [self hideLoadingView];
        }];
        
    } else {
        
        [self hideLoadingView];
        [self showAlertViewWithTitle:@"Error" andMessage:@"This device cannot send feedback in its current state."];
    }
}

#pragma mark - MailComposeDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:kUI_COLOR_DEFAULT_TINT] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.mailViewController = nil;
}

#pragma mark - Backup

- (void)beginBackup
{
    [self showLoadingViewWithMessage:@"Checking to see if there is an existing back up file."];
    [self.dbRestClient loadMetadata:kBACKUP_FILE_PATH];
}

- (void)backupToDropbox
{
    NSString *backupString  = [CoreDataHelper generateJSONStringForSavedGames];
    if (!backupString) {
        NSLog(@"ERROR: nothing to backup.");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There is nothing to back up." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [self showLoadingViewWithMessage:@"Backing up games. Please do not exit the app"];
    
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:kBACKUP_FILE_NAME];
    [backupString writeToFile:localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString *destDir = @"/";
    [self.dbRestClient uploadFile:kBACKUP_FILE_NAME toPath:destDir withParentRev:self.revision fromPath:localPath];
    
}

- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath metadata:(DBMetadata *)metadata
{
    [self hideLoadingView];
    [self showToastWithMessage:@"Back up was completed successfully and uploaded to your Dropbox."];
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error
{
    [self hideLoadingView];
    [self showAlertViewWithTitle:@"Failure" andMessage:@"Backup was unsuccessful due to a failed upload to your Dropbox"];
}


- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    
    [self hideLoadingView];
    
    if (metadata.filename.length > 0 && metadata.isDeleted == NO) {
        self.revision = metadata.rev;
        if (!self.backupConfAlertView) {
            self.backupConfAlertView = [[UIAlertView alloc] initWithTitle:@"Replace Existing Backup" message:[NSString stringWithFormat:@"An previous back up from %@ exists in Dropbox. Replace this backup with the new one?", [GeneralHelpers dateStringFromDate:metadata.lastModifiedDate]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        }
        [self.backupConfAlertView show];
    } else {
        self.revision = nil;
        [self backupToDropbox];
    }
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error
{
    [self hideLoadingView];
    self.revision = nil;
    
    if ([GeneralHelpers isNetworkAvailable] == NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No network connectivity." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if (error.code == 404) {
        [self backupToDropbox];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Backup was unsuccessful due to a Dropbox metadata issue. You may need to configure this app with Dropbox again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark - Restore

- (void)beginRestore
{
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:kRESTORE_FILE_NAME];
    
    [self showLoadingViewWithMessage:@"Looking for backup file to restore."];
    
    [self.dbRestClient loadFile:kBACKUP_FILE_PATH intoPath:localPath];
}

- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    
    [self hideLoadingView];
        
    NSString *date = [GeneralHelpers dateStringFromDate:metadata.lastModifiedDate];
    self.restoreConfAlertView = [[UIAlertView alloc] initWithTitle:@"Confirm Restore" message:[NSString stringWithFormat:@"Restore backup from %@? Restoring will clear any changes since the last backup. This operation cannot be undone.", date] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    self.restorePath = localPath;
    [self.restoreConfAlertView show];
}

- (void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error {
    
    [self hideLoadingView];
    self.restorePath = nil;
    
    if ([GeneralHelpers isNetworkAvailable] == NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No network connectivity." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if (error.code == 404) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Backup file could not be found in Dropbox." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failure in loading file from Dropbox. You may need to configure this app with Dropbox again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)restoreFromPath
{
    NSString *jsonString = [NSString stringWithContentsOfFile:self.restorePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *backupData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *backupDictionary = [NSJSONSerialization JSONObjectWithData:backupData options:NSJSONReadingMutableContainers error:nil];
    BOOL success = [CoreDataHelper restoreGamesFromJSONDictionary:backupDictionary];
    [self hideLoadingView];
    
    if (success) {
        [self showToastWithMessage:@"Restore completed."];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Restore was unsuccessful due to a corrupted back up file." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark - Dropbox

- (void)dropboxLinked
{
    if ([GeneralHelpers isNetworkAvailable]) {
        [self showToastWithMessage:@"Dropbox linked successfully"];
    }
}

#pragma mark - Helpers


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.backupConfAlertView) {
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
            [self backupToDropbox];
        }
    } else if (alertView == self.restoreConfAlertView) {
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
            [self showLoadingViewWithMessage:@"Restoring games. Please do not exit the app."];
            [self performSelector:@selector(restoreFromPath) withObject:nil afterDelay:0.1f];
        }
    }
}


@end
