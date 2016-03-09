//
//  StatusPhotosView.h
//  微博2.0
//
//  Created by apple on 16/2/13.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusPhotosView : UIView
@property (nonatomic,strong) NSArray *photos;
+ (CGSize)sizeWithCount:(NSUInteger)count;
@end
