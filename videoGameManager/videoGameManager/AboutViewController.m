//
//  AboutViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/9/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "AboutViewController.h"
#import "UIScrollView+Additions.h"
#import "UIHelper.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lastLabel;

@end

@implementation AboutViewController

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
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetMaxY(self.lastLabel.frame) + kUI_PADDING_10)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)linkButtonPressed:(id)sender
{
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    
    NSString *urlString = ((UIButton*)sender).titleLabel.text;

    if (urlString.length > 0) {
        urlString = [NSString stringWithFormat:@"http://%@", [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

@end
