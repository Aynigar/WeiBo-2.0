//
//  SearchBar.m
//  微博2.0
//
//  Created by apple on 16/1/17.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "SearchBar.h"
#import "UIView+Extension.h"

@implementation SearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索关键字";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        //添加搜索框图标
        UIImageView *searchIcon = [[UIImageView alloc]init];
        
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        searchIcon.contentMode = UIViewContentModeCenter;
    }
    return self;
}

+(instancetype)searchBar
{
    return [[SearchBar alloc]init];
}

@end
