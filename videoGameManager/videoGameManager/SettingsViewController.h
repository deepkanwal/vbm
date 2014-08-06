//
//  SettingsViewController.h
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/3/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <DropboxSDK/DropboxSDK.h>

@interface SettingsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, DBRestClientDelegate, UIAlertViewDelegate>

@end
