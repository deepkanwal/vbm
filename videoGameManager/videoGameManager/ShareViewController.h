//
//  ShareViewController.h
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/16/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

typedef enum {
    ListTypeNowPlaying,
    ListTypeBacklog,
    ListTypeFullBacklog,
    ListTypeAll
}ListType;

@interface ShareViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) ListType listType;

@end
