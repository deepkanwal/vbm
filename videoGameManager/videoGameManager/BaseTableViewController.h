//
//  BaseTableViewController.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

- (void)createSearchBar;
- (void)updateTableViewLayout;
- (void)updateColourOfCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

@end
