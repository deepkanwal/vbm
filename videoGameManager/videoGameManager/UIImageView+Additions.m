//
//  UIImageView+Additions.m
//  videoGameManager
//
//  Created by Deepkanwal Plaha on 2013-09-01.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "UIImageView+Additions.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+Additions.h"

@implementation UIImageView (Additions)

- (void)setImageWithURLString:(NSString*)urlString placeHolderImageName:(NSString*)placeholder fade:(BOOL)fade
{
    [self setImageWithURLString:urlString placeHolderImageName:placeholder fade:fade completed:nil];
}

- (void)setImageWithURLString:(NSString*)urlString placeHolderImageName:(NSString*)placeholder fade:(BOOL)fade completed:(void(^)(BOOL isSuccess))completionBlock
{
    __block UIImageView* blockSelf = self;

    
    UIImage * placeholderImage = [UIImage imageNamed:placeholder];
    
    if (![urlString isKindOfClass:[NSString class]]) {
        self.image = placeholderImage;
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

    
    [self setImageWithURLRequest:request placeholderImage:placeholderImage
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                             if (fade) [blockSelf applyFadeTransition];
                             [blockSelf setImage:image];
                             if (completionBlock) {
                                 completionBlock(YES);
                             }

                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                             if (fade) [blockSelf applyFadeTransition];
                             [blockSelf setImage:placeholderImage];
                             if (completionBlock) {
                                 completionBlock(YES);
                             }
                         }];


}

- (void)sizeToFitImage
{
    if (self.image) {
        CGRect bounds;
        bounds.origin = CGPointZero;
        
        CGFloat ratio = self.image.size.height / self.image.size.width;
        CGFloat viewRatio = CGRectGetHeight(self.bounds) / CGRectGetWidth(self.bounds);

        if (ratio < viewRatio) bounds.size = CGSizeMake(CGRectGetWidth(self.bounds), floorf(CGRectGetWidth(self.bounds) * ratio));
        else bounds.size = CGSizeMake(floorf(CGRectGetHeight(self.bounds) * (1.0f/ratio)), CGRectGetHeight(self.bounds));

        self.bounds = bounds;
    }
}

@end
