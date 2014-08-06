//
//  SelectPlatformViewController.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-08.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseViewController.h"

@class AddedGame;

@interface SelectPlatformViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) AddedGame* addedGame;
@property (nonatomic, strong) NSArray *arrayOfAddedGames;

@property (nonatomic) BOOL customPlatfromSelected;

@end
