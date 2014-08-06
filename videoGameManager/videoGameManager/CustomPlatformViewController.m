//
//  CustomPlatformViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 2014-04-28.
//  Copyright (c) 2014 Deepkanwal Plaha. All rights reserved.
//

#import "CustomPlatformViewController.h"
#import "SelectPlatformViewController.h"
#import "AddedGame.h"
#import "AddedPlatform.h"
#import "CoreDataHelper.h"
#import "UIHelper.h"
#import "GeneralHelpers.h"

@interface CustomPlatformViewController ()
@property (weak, nonatomic) IBOutlet UITextField *platformTextField;
@end

@implementation CustomPlatformViewController

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
    [self.platformTextField setTintColor:kUI_COLOR_DEFAULT_TINT];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionDone:(id)sender {
    NSString *platform = self.platformTextField.text;
    if (platform.length > 0) {
        
        if ([AddedGame getMatchesForGameId:self.addedGame.gameId andPlatform:platform inContext:[CoreDataHelper sharedContext]].count > 0) {
            [self showAlertViewWithTitle:@"Error" andMessage:@"Game with this platform already exists"];
            return;
        }
        
        NSInteger index = self.navigationController.viewControllers.count - 2;
        if (index < self.navigationController.viewControllers.count) {
            id viewController = [[self.navigationController viewControllers] objectAtIndex:index];
            if ([viewController isKindOfClass:[SelectPlatformViewController class]]) {
                SelectPlatformViewController *selectPlatformVC = (SelectPlatformViewController*)viewController;
                [selectPlatformVC setCustomPlatfromSelected:YES];
            }
        }
        
        [GeneralHelpers trackEventWithCategory:@"Add Games" action:@"Custom Platform" label:[NSString stringWithFormat:@"ID: %@, GAME: %@, PLATFORM: %@", self.addedGame.gameId
                                                                                             , self.addedGame.gameName, platform]];
        
        [self.addedGame updateWithPlatformOfName:platform inContext:[CoreDataHelper sharedContext]];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showAlertViewWithTitle:@"Error" andMessage:@"Please enter a platform."];
    }
}


@end
