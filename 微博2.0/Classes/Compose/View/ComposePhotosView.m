//
//  ComposePhotosView.m
//  微博2.0
//
//  Created by apple on 16/2/16.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "ComposePhotosView.h"
#import "UIView+Extension.h"

@implementation ComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)addPhotos:(UIImage *)photos
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = photos;
    
    [self.photos addObject:photos];
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger Count = self.subviews.count;
    int maxcols = 4;
    CGFloat PhotoWH = 70;
    CGFloat PhotoMargin = 10;
    for (int i = 0; i < Count; i++) {
        UIImageView *photosView = self.subviews[i];
        int cols = i % maxcols;//0,3,6模3都是0；1，4，7模3都是1；2，5，8模3都是2
        photosView.x = cols *(PhotoWH + PhotoMargin);
        
        int rows = i / maxcols;//0,1,2除以3都是0，3，4，5除以3都是1，6，7，8除以3都是2
        photosView.y = rows * (PhotoWH + PhotoMargin);
        
        photosView.width = PhotoWH;
        photosView.height = PhotoWH;
    }
}

@end
