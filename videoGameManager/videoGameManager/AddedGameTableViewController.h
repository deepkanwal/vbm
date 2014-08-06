//
//  AddedGameTableViewController.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-14.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseTableViewController.h"

@interface AddedGameTableViewController : BaseTableViewController

@property (nonatomic, strong) NSArray *sortDescriptors;
@property (nonatomic, strong) NSPredicate *predicate;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
