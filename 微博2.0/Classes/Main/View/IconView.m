//
//  IconView.m
//  微博2.0
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "IconView.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "UIView+Extension.h"
@implementation IconView

- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc]init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        
    }
    return self;
}

- (void)setUser:(User *)user
{
    _user = user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
        
        case UserVerifiedPersonal:
             self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
           
            break;
            
        case UserVerifiedOrgEnterprice:
        case UserVerifiedOrgMedia:
        case UserVerifiedOrgWebsite:
             self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
          
            break;
            
         case UserVerifiedDaren:
             self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat scale = 1.05;
    self.verifiedView.clipsToBounds = NO;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
    self.verifiedView.size = self.verifiedView.image.size;
}



@end
