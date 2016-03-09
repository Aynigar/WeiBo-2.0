//
//  HomeViewController.m
//  微博2.0
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "DropDownMenu.h"
#import "Menu.h"
#import "AccountTool.h"
#import "TittleButton.h"
#import "User.h"
#import "Status.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "loadMoreFooter.h"
#import "StatusCell.h"
#import "StatusFrame.h"
#import "Test1ViewController.h"
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface HomeViewController ()<DropDownMenuDelegate>
/**  微博数组 (里面放着都是StatusFrame模型，一个StatusFrame对象就代表一条微博)*/
@property (nonatomic,strong) NSMutableArray *statusFrame;

@end

@implementation HomeViewController

- (NSMutableArray *)statusFrame
{
    if (!_statusFrame) {
        self.statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = Color(211, 211, 211);
    //设置导航栏内容
    [self setupNav];
    //获取用户信息
    [self setupUserInfo];
    //上拉刷新
    [self setUPLoadMore];
    //下拉刷新
    [self setupRefresh];
    //显示未读微博数
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(setupUnReadStatus) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setUPLoadMore
{
    loadMoreFooter *footer = [loadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (void)setupUnReadStatus
{
    AFHTTPSessionManager *mng = [AFHTTPSessionManager manager];
    NSMutableDictionary *pamars = [NSMutableDictionary dictionary];
    Account *account = [AccountTool account];
    pamars[@"access_token"] =account.access_token;
    pamars[@"uid"] = account.uid;
    
    [mng GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:pamars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
        }else{
            self.tabBarItem.badgeValue = status;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];
}

- (void)setupRefresh
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(NewStatusChanged:) forControlEvents:UIControlEventValueChanged];
    [refresh beginRefreshing];
    //马上加载微博数据
    [self NewStatusChanged:refresh];
    
    [self.tableView addSubview:refresh];
}

- (void)NewStatusChanged:(UIRefreshControl *)control
{
    AFHTTPSessionManager *mng = [AFHTTPSessionManager manager];
    NSMutableDictionary *pamars = [NSMutableDictionary dictionary];
    Account *account = [AccountTool account];
    
    pamars[@"access_token"] = account.access_token;

    StatusFrame *firstStatusF = [self.statusFrame firstObject];
    if (firstStatusF) {
        pamars[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [mng GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:pamars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
         //NSLog(@"%@",responseObject);
        //将微博字典数组 转成微博模型数组
        NSArray *newStatus = [Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self statusFramesWithStatus:newStatus];
        
        //将最新的微博数据，添加到总数组最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrame insertObjects:newFrames atIndexes:set];
        
        [self.tableView reloadData];
        
         [control endRefreshing];
        //显示加载微博个数
        [self showUpNewStatusCount:newStatus.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败-%@",error);
         [control endRefreshing];
    }];
}

//显示加载微博个数
- (void)showUpNewStatusCount:(NSUInteger)count
{
    //1，显示label
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.y = 64 - label.height;
    //2，设置label其他属性
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    if (count == 0) {
        label.text = @"没有更新的微博数据";
    }else{
        label.text = [NSString stringWithFormat:@"共有%lu条微博数据",(unsigned long)count];
    }
    
    //3,设置动画效果
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        //label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
           // label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
}

- (void)setupUserInfo
{
    AFHTTPSessionManager *mng = [AFHTTPSessionManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mng GET:@"https://api.weibo.com/2/users/show.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取昵称
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        User *user = [User mj_objectWithKeyValues:responseObject];
        NSString *name = user.name;
        [titleBtn setTitle:name forState:UIControlStateNormal];
        
        //将昵称存入沙盒
        account.name = name;
        [AccountTool saveAccount:account];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败-%@",error);
    }];
}

- (void)setupNav
{
    //添加左右上角按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" imageHighlighted:@"navigationbar_pop_highlighted"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" imageHighlighted:@"navigationbar_friendsearch_highlighted"];
    
    //添加中间标题按钮
    TittleButton *titleBtn = [[TittleButton alloc]init];
    NSString *name = [AccountTool account].name;
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];

    //添加监听事件
    self.titleButton = titleBtn;
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
}

- (void)titleClick:(UIButton *)titleButton
{
    //创建下拉菜单
    DropDownMenu *menu = [DropDownMenu menu];
    menu.delegate = self;
    //设置内容
    Menu *vc = [[Menu alloc]init];
    vc.view.width = 100;
    vc.view.height = 44 * 3;
    menu.contentController = vc;
    
    //显示
    [menu showFrom:titleButton];
}

- (void)friendSearch
{
    NSLog(@"friendSearch...");
}

- (void)pop
{
    NSLog(@"pop...");
}

#warning mark -DropDownMenuDelegate代理方法
- (void)dropDownMenuDissmiss:(DropDownMenu *)menu
{
    self.navigationItem.titleView = (UIButton *)self.titleButton;
    self.titleButton.selected = NO;
    
}

- (void)dropDownMenuShow:(DropDownMenu *)menu
{
    self.navigationItem.titleView = (UIButton *)self.titleButton;
    self.titleButton.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statusFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    //给cell传递模型数据
    cell.statusFrame = self.statusFrame[indexPath.row];

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrame.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
         //加载更多的微博数据
        [self loadMoreStatus];
    }
}

//将status模型转为statusFrame模型
- (NSArray *)statusFramesWithStatus:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (Status *status in statuses) {
        StatusFrame *f = [[StatusFrame alloc]init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;

}

- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    
    StatusFrame *lastStatusF = [self.statusFrame lastObject];
    if (lastStatusF) {
//         若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
//         id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatus:newStatuses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrame addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败-%@",error);
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *frame = self.statusFrame[indexPath.row];
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Test1ViewController *test1 = [[Test1ViewController alloc]init];
    test1.hidesBottomBarWhenPushed = YES;
    test1.title = @"微博正文";
    [self.navigationController pushViewController:test1 animated:YES];
}

//    NSDictionary *status = self.status[indexPath.row];
//    NSDictionary *user = status[@"user"];
//    NSString *imageUrl = user[@"profile_image_url"];
//
//    cell.textLabel.text = user[@"name"];
//    cell.detailTextLabel.text = status[@"text"];

//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image];

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// cell.status = self.statuses[indexPath.row];

//    Status *status = self.statuses[indexPath.row];
//    cell.detailTextLabel.text = status.text;
//
//    User *user = status.user;
//    cell.textLabel.text = user.name;
//
//    UIImage *image = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:image];

//这样获得的窗口，是目前显示在最上面的窗口
//UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//添加蒙版
//UIView *cover = [[UIView alloc]init];
//cover.frame = window.bounds;
//cover.backgroundColor = [UIColor clearColor];
//[window addSubview:cover];
//添加带箭头的灰色图片
//UIImageView *dropDownMeau = [[UIImageView alloc]init];
//dropDownMeau.image = [UIImage imageNamed:@"popover_background"];
//dropDownMeau.width = 217;
//dropDownMeau.height = 217;
//dropDownMeau.y = 50;
//开启用户交互功能
//dropDownMeau.userInteractionEnabled = YES;
//
//[cover addSubview:dropDownMeau];

//取出微博字典数据
//NSArray *dictArray = responseObject[@"statuses"];
//将取出的微博字典 转换成 微博模型数据
//for (NSDictionary *dict in dictArray) {
//    Status *status = [Status statusWithDict:dict];
//    [self.statuses addObject:status];
//}
@end
