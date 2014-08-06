//
//  ImageWithCaptionView.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-20.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageWithCaptionViewDelegate <NSObject>
- (void)imageButtonPressed;
@end

@interface ImageWithCaptionView : UIView

@property (nonatomic, weak) id<ImageWithCaptionViewDelegate> delegate;
- (void)configureWithImageName:(NSString*)imageName caption:(NSString*)caption;

@end
