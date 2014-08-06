//
//  ToastView.h
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 1/18/2014.
//  Copyright (c) 2014 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToastViewDelegate <NSObject>
- (void)toastPressed;
@end

@interface ToastView : UIView

@property (nonatomic, weak) id<ToastViewDelegate>delegate;

- (void)updateWithMessage:(NSString*)message;

@end
