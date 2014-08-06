//
//  AddGameViewController.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-06.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseViewController.h"

@class AddedGame;

@protocol AddGameViewControllerDelegate <NSObject>
- (void)toggleGameAdded:(AddedGame*)addedGame;
@end

@interface AddGameViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) id<AddGameViewControllerDelegate>delegate;
@end
