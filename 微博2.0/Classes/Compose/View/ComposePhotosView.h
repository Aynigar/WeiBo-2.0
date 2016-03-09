//
//  ComposePhotosView.h
//  微博2.0
//
//  Created by apple on 16/2/16.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposePhotosView : UIView
- (void)addPhotos:(UIImage *)photos;
@property (nonatomic,strong,readonly)  NSMutableArray *photos;

@end
