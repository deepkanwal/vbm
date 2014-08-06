//
//  BaseTableViewController.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-24.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseTableViewController.h"
#import "GeneralHelpers.h"
#import "UIHelper.h"
#import "UIScrollView+Additions.h"
#import "UITableView+Additions.h"


@interface BaseTableViewController ()
@property (nonatomic, assign) CGFloat scrollViewLastYOffset;
@end

@implementation BaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self updateTableViewLayout];
    [self.tableView setupDefaultApperance];
    [self.view addSubview:self.tableView];
}

- (void)createSearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44.0f)];
    self.searchBar.placeholder = @"search game";
    self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    [self adjustOverlayViewYOrigin:CGRectGetHeight(self.searchBar.bounds) + CGRectGetHeight(self.navigationController.navigationBar.bounds) + kSTATUS_BAR_HEIGHT];
}

- (void)updateTableViewLayout
{
    [self.tableView setInitialPositionBelowNavigationBar:self.navigationController.navigationBar];
    [self.tableView setInitialPositionAboveTabBar:self.tabBarController.tabBar];
}

#pragma mark - UITableViewDatasource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [GeneralHelpers logSubclassImplementationRequired:__PRETTY_FUNCTION__];
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [GeneralHelpers logSubclassImplementationRequired:__PRETTY_FUNCTION__];
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [GeneralHelpers logSubclassImplementationRequired:__PRETTY_FUNCTION__];
    return 0;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [GeneralHelpers logSubclassImplementationRequired:__PRETTY_FUNCTION__];
}

- (void)updateColourOfCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row % 2 == 1) {
        [cell setBackgroundColor:kUI_COLOR_LIGHT_GRAY];
    } else {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
}

#pragma mark - UISearchBarDelagate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self showOverlay];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self dismissOverlay];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self dismissOverlay];
}

@end
