//
//  UILabel+Additions.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "UILabel+Additions.h"
#import "UIView+Additions.h"

@implementation UILabel (Additions)

- (void)resizeLabelToFitMaxWidth:(CGFloat)maxWidth
{
    CGSize size = [self sizeThatFits:CGSizeMake(maxWidth, (self.numberOfLines == 0 ? NSIntegerMax: self.numberOfLines * self.font.lineHeight))];
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)sizeToFitWithWidthConserved
{
    CGFloat width = self.frame.size.width;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    [self sizeToFit];
    [self resizeWidth:width];
}

- (void)sizeToFitWithMaxHeight:(CGFloat)maxHeight
{
    [self sizeToFit];
    if (CGRectGetHeight(self.bounds) > maxHeight) {
        [self resizeHeight:maxHeight];
    }
}

- (void)adjustFontSizeToFitWithMinFontSize:(CGFloat)minFontSize
{
    UIFont *font = self.font;
    CGSize size = self.frame.size;
    
    for (CGFloat maxSize = self.font.pointSize; maxSize >= minFontSize; maxSize -= 1.0f)
    {
        font = [font fontWithSize:maxSize];
        CGSize constraintSize = CGSizeMake(size.width, MAXFLOAT);
        CGSize labelSize = CGRectIntegral([self.text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil]).size;
        if(labelSize.height <= size.height)
        {
            break;
        }
    }
    // set the font to the minimum size anyway
    self.font = font;
    [self setNeedsLayout];
}

@end
