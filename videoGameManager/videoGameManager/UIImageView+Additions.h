//
//  UIImageView+Additions.h
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-01.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Additions)

- (void)setImageWithURLString:(NSString*)urlString placeHolderImageName:(NSString*)placeholder fade:(BOOL)fade;
- (void)setImageWithURLString:(NSString*)urlString placeHolderImageName:(NSString*)placeholder fade:(BOOL)fade completed:(void(^)(BOOL isSuccess))completionBlock;
- (void)sizeToFitImage;


@end
