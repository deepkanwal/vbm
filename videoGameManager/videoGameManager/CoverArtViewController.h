//
//  CoverArtViewController.h
//  gameCollector
//
//  Created by Deepkanwal Plaha on 2013-05-27.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "BaseViewController.h"

@interface CoverArtViewController : BaseViewController <UIScrollViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSString* urlString;
@property (nonatomic, strong) NSString* imageTitle;
@end
