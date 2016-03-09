//
//  NewfeatureController.m
//  微博2.0
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "NewfeatureController.h"
#import "UIView+Extension.h"
#import "TabBarController.h"
#define imageviewCount 4
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@implementation NewfeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1，添加scrollview到控制器中
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.size = self.view.size;
    
    [self.view addSubview:scrollView];
    
    //2,添加图片到scrollview中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < imageviewCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i * scrollW;
        [scrollView addSubview:imageView];
        
        if (i == imageviewCount - 1) {
            [self setupLastImage:imageView];
        }
    }
    
    //3,设置其他scrollview的属性
    scrollView.contentSize = CGSizeMake(scrollW * imageviewCount, 0);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    //4,添加pagecontrol
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.width = 100;
    pageControl.height = 30;
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.numberOfPages = imageviewCount;
    pageControl.currentPageIndicatorTintColor = Color(253, 98, 42);
    pageControl.pageIndicatorTintColor = Color(189, 189, 189);
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
}

- (void)setupLastImage:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    UIButton *checkBoxBtn = [[UIButton alloc]init];
    [checkBoxBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBoxBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkBoxBtn.width = 150;
    checkBoxBtn.height = 30;
    checkBoxBtn.centerX = imageView.width * 0.5;
    checkBoxBtn.centerY = imageView.height * 0.65;
    
    [checkBoxBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    checkBoxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [checkBoxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBoxBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [checkBoxBtn addTarget:self action:@selector(checkClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = checkBoxBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    self.checkBoxBtn = checkBoxBtn;
    [imageView addSubview:checkBoxBtn];
}

- (void)checkClick
{
    self.checkBoxBtn.selected = !self.checkBoxBtn.isSelected;
}

- (void)startClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[TabBarController alloc]init];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger count = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(count + 0.5);
}

@end
