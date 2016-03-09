//
//  DropDownMenu.m
//  微博2.0
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DropDownMenu.h"
#import "UIView+Extension.h"
@implementation DropDownMenu

//懒加载需要强引用
- (UIImageView *)containerView
{
    if (!_containerView) {
        //添加带箭头的灰色图片控件
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        //开启用户交互功能
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc]init];
}

- (void)setContent:(UIView *)content
{
    _content = content;
    //调整内容位置
    content.x = 10;
    content.y = 15;
    //调整灰色容器的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    //设置灰色容器的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    
    //将添加的内容放入灰色容器
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

- (void)showFrom:(UIView *)from
{
    //1，获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //2，添加自己到窗口上
    [window addSubview:self];
    //3.设置尺寸
    self.frame = window.bounds;
    //4，调整灰色图片的位置,默认情况下，frame是以父控件左上角为坐标原点，可以通过转换坐标系原点，改变frame的参照点
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    if ([self.delegate respondsToSelector:@selector(dropDownMenuShow:)]) {
        [self.delegate dropDownMenuShow:self];
    }
    
}

- (void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDissmiss:)]) {
        [self.delegate dropDownMenuDissmiss:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
