//
//  Menu.m
//  微博2.0
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "Menu.h"

@implementation Menu

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row ==0) {
        cell.textLabel.text = @"特别关注";
    }else if (indexPath.row ==1){
        cell.textLabel.text = @"首页";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"好友圈";
    }
    return cell;
}

@end
