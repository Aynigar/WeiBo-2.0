//
//  StatusCell.h
//  微博2.0
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;

@interface StatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)  StatusFrame *statusFrame;

@end
