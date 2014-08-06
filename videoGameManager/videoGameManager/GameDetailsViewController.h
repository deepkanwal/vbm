//
//  GameDetailsViewController.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseViewController.h"
#import "SwipeView.h"
#import "AddGameViewController.h"
#import "GameDetailsContentView.h"
#import "ImageWithCaptionView.h"

@interface GameDetailsViewController : BaseViewController <GameDetailsContentViewDelegate, AddGameViewControllerDelegate, ImageWithCaptionViewDelegate>
@property (strong, nonatomic) id detailItem;
@property (assign, nonatomic) BOOL fromSearch;
@end
