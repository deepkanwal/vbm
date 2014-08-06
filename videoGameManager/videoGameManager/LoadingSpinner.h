//
//  LoadingSpinner.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-21.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingSpinner : UIView

- (id)initWithFrame:(CGRect)frame large:(BOOL)large;
- (void)startAnimation;
- (void)stopAnimation;

@end
