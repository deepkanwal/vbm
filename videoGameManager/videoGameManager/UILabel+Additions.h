//
//  UILabel+Additions.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-08-25.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Additions)

- (void)resizeLabelToFitMaxWidth:(CGFloat)maxWidth;
- (void)sizeToFitWithWidthConserved;
- (void)sizeToFitWithMaxHeight:(CGFloat)maxHeight;
- (void)adjustFontSizeToFitWithMinFontSize:(CGFloat)minFontSize;

@end
