//
//  IconView.h
//  微博2.0
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@interface IconView : UIImageView
@property (nonatomic,weak) UIImageView *verifiedView;
@property (nonatomic,strong)  User *user;
@end
