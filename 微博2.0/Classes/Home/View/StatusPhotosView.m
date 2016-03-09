//
//  StatusPhotosView.m
//  微博2.0
//
//  Created by apple on 16/2/13.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "StatusPhotosView.h"
#import "Photo.h"
#import "StatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

#define StatusphotosSize 70
#define StatusphotosMargin 10
#define StatusMaxrols(count) ((count == 4)?2:3)

@implementation StatusPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    NSUInteger photoCount = photos.count;
    //创建足够多的图片控件
    while (self.subviews.count < photoCount) {
        StatusPhotoView *photosView = [[StatusPhotoView alloc]init];
        [self addSubview:photosView];
    }
    
    //设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        StatusPhotoView *imageView = self.subviews[i];
        if (i < photoCount) {
            imageView.photos = photos[i];
            
            imageView.hidden = NO;
            
        }else{
            imageView.hidden = YES;
        }
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger photoCount = self.photos.count;
    int maxcols = StatusMaxrols(photoCount);
    for (int i = 0; i < photoCount; i++) {
        UIImageView *photosView = self.subviews[i];
        int cols = i % maxcols;//0,3,6模3都是0；1，4，7模3都是1；2，5，8模3都是2
        photosView.x = cols *(StatusphotosSize + StatusphotosMargin);
        
        int rows = i / maxcols;//0,1,2除以3都是0，3，4，5除以3都是1，6，7，8除以3都是2
        photosView.y = rows * (StatusphotosSize + StatusphotosMargin);
        
        photosView.width = StatusphotosSize;
        photosView.height = StatusphotosSize;
    }
    
}

+ (CGSize)sizeWithCount:(NSUInteger)count
{
    int maxcols = StatusMaxrols(count);
    //列数
    NSUInteger cols = (count>= maxcols)? maxcols:count;
    CGFloat photoW = StatusphotosSize * cols + (cols - 1) * StatusphotosMargin;
    
    //行数
    NSUInteger rows = (count + maxcols - 1) / maxcols;
    CGFloat photoH = StatusphotosSize * rows + (rows - 1) * StatusphotosMargin;
    
    return CGSizeMake(photoW, photoH);
}
@end
