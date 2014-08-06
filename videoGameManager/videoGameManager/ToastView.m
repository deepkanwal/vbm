//
//  ToastView.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 1/18/2014.
//  Copyright (c) 2014 Deepkanwal Plaha. All rights reserved.
//

#import "ToastView.h"
#import "UIView+Additions.h"

@interface ToastView ()
@property (weak, nonatomic) IBOutlet UILabel *toastLabel;
@end

@implementation ToastView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self applyRoundedCorners:5.0f];
    [self applyDropShadow];
}

- (void)updateWithMessage:(NSString*)message
{
    [self.toastLabel setText:message];
}

- (IBAction)actionToastPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(toastPressed)]) {
        [self.delegate toastPressed];
    }
}

@end
