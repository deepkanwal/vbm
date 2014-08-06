//
//  ImageWithCaptionView.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-20.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "ImageWithCaptionView.h"
#import "UIHelper.h"
#import "UILabel+Additions.h"
#import "UIView+Additions.h"

@interface ImageWithCaptionView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ImageWithCaptionView

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ImageWithCaptionView"
                                          owner:nil
                                        options:nil] lastObject];
    return self;
}

- (void)configureWithImageName:(NSString*)imageName caption:(NSString*)caption
{
//    [self.imageView setContentMode:UIViewContentModeBottom];
    [self.imageView setImage:[UIImage imageNamed:imageName]];
    [self.label setText:caption];
    [self.label sizeToFitWithWidthConserved];
    [self.label setTextColor:kUI_COLOR_DEFAULT_TINT];
    [self resizeHeight:CGRectGetMaxY(self.label.frame) + kUI_PADDING_15];
}

- (IBAction)imageButtonPressed:(id)sender {
    if (self.delegate) {
        [self.delegate imageButtonPressed];
    }
}

@end
