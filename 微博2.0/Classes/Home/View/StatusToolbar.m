//
//  StatusToolbar.m
//  微博2.0
//
//  Created by apple on 16/2/4.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "StatusToolbar.h"
#import "UIView+Extension.h"
#import "Status.h"
@implementation StatusToolbar
- (NSMutableArray *)toolBarBtn
{
    if (!_toolBarBtn) {
        self.toolBarBtn = [NSMutableArray array];
    }
    return _toolBarBtn;
}

- (NSMutableArray *)divideLine
{
    if (!_divideLine) {
        self.divideLine = [NSMutableArray array];
    }
    return _divideLine;
}

+ (instancetype)toolBar
{
    return [[self alloc]init];
}

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
      self.rewteedBtn = [self setUpToolBar:@"转发" icon:@"timeline_icon_retweet"];
      self.commentsBtn = [self setUpToolBar:@"评论" icon:@"timeline_icon_comment"];
      self.attitudesBtn = [self setUpToolBar:@"赞" icon:@"timeline_icon_unlike"];
        //添加分割线
        [self setUpDirver];
        [self setUpDirver];
    }
    return self;
}

- (void)setUpDirver
{
    UIImageView *dirver = [[UIImageView alloc]init];
    dirver.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:dirver];
    [self.divideLine addObject:dirver];
}

- (UIButton *)setUpToolBar:(NSString *)title icon :(NSString *)icon
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    [self.toolBarBtn addObject:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.toolBarBtn.count;
    
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.toolBarBtn[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    //分割线
    NSUInteger divideCount = self.divideLine.count;
    for (NSUInteger i= 0; i < divideCount; i++) {
        UIImageView *dividView = self.divideLine[i];
        dividView.width = 1;
        dividView.height = btnH;
        dividView.x = (i + 1) * btnW;
        dividView.y = 0;
    }
    
}

- (void)setStatus:(Status *)status
{
    _status = status;
    [self showToolBarCount:status.reposts_count btn:self.rewteedBtn title:@"转发"];
    [self showToolBarCount:status.comments_count btn:self.commentsBtn title:@"评论"];
    [self showToolBarCount:status.attitudes_count btn:self.attitudesBtn title:@"赞"];
    
    [self.attitudesBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.attitudesBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateSelected];
    
}

- (void)click:(UIButton *)btn
{
    self.attitudesBtn.userInteractionEnabled = YES;
    self.attitudesBtn.selected = !self.attitudesBtn.isSelected;
}

- (void)showToolBarCount:(int )count btn:(UIButton *)btn title:(NSString *)title
{
    if (count < 10000) {
        title = [NSString stringWithFormat:@"%d",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        double million = count / 10000.0;
        title = [NSString stringWithFormat:@"%1f.万",million];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
