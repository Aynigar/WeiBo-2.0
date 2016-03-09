//
//  ComposeToolBar.m
//  微博2.0
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "ComposeToolBar.h"
#import "UIView+Extension.h"

@implementation ComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupToolBar:@"compose_camerabutton_background" highlight:@"compose_camerabutton_background_highlighted"type:ComposeToolBarTypeCamara];
        
        [self setupToolBar:@"compose_toolbar_picture" highlight:@"compose_camerabutton_background_highlighted-1"type:ComposeToolBarTypePicture];
        
        [self setupToolBar:@"compose_mentionbutton_background" highlight:@"compose_mentionbutton_background_highlighted"type:ComposeToolBarTypeMention];
        
        [self setupToolBar:@"compose_trendbutton_background" highlight:@"compose_trendbutton_background_highlighted"type:ComposeToolBarTypeTrend];
        
        [self setupToolBar:@"compose_emoticonbutton_background" highlight:@"compose_emoticonbutton_background_highlighted"type:ComposeToolBarTypeEmotion];
        
    }
    return self;
}

- (void)setupToolBar:(NSString *)image highlight:(NSString *)highlight type:(ComposeToolBarType)type
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    btn.tag = type;
    [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}

- (void)btnDidClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(ComposeToolBarDidClick:didClickBtn:)]) {
        [self.delegate ComposeToolBarDidClick:self didClickBtn:(int)btn.tag];
    }
}

@end
