//
//  StatusPhotoView.m
//  微博2.0
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "StatusPhotoView.h"
#import "Photo.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@implementation StatusPhotoView
//[imageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhotos:(Photo *)photos
{
    _photos = photos;
    [self sd_setImageWithURL:[NSURL URLWithString:photos.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
//    if ([photos.thumbnail_pic hasSuffix:@"gif"]) {
//        self.gifView.hidden = NO;
//    }else{
//        self.gifView.hidden = YES;
//    }
    self.gifView.hidden = ![photos.thumbnail_pic hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
