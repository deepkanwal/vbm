//
//  BackupViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/3/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BackupViewController.h"
#import "UIImage+Additions.h"
#import "UIHelper.h"
#import "GeneralHelpers.h"
#import "CoreDataHelper.h"
#import <DropboxSDK/DropboxSDK.h>

@interface BackupViewController ()
@property (weak, nonatomic) IBOutlet UIButton *linkDropboxButton;
@property (weak, nonatomic) IBOutlet UIButton *beginBackupButton;
@end

@implementation BackupViewController

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
    [self.view setBackgroundColor:kUI_COLOR_DEFAULT_BACKGROUNG_GRAY];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dropboxLinked) name:kNOTIFICATION_DROPBOX_LINKED object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([DBSession sharedSession].isLinked == NO) {
        [self.linkDropboxButton setTitle:@"Link Dropbox" forState:UIControlStateNormal];
    } else {
        [self.linkDropboxButton setTitle:@"Link Dropbox (Again)" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dropboxLinked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)linkDropboxButton:(id)sender {
    [[DBSession sharedSession] linkFromController:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNOTIFICATION_DROPBOX_LINKED object:nil];
}

@end
