//
//  ComposeController.m
//  微博2.0
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "ComposeController.h"
#import "AccountTool.h"
#import "UIView+Extension.h"
#import "LSTextView.h"
#import "ComposeToolBar.h"
#import "UIView+Extension.h"
#import "ComposePhotosView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@implementation ComposeController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolBar];
    
    [self setupPhotosView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘）
    [self.textview becomeFirstResponder];
}

- (void)setupPhotosView
{
    ComposePhotosView *phtotsView = [[ComposePhotosView alloc]init];
    phtotsView.width = self.view.width;
    phtotsView.height = self.view.height;
    phtotsView.y = 100;
    self.phtotsView = phtotsView;
    [self.textview addSubview:phtotsView];
}

- (void)setupToolBar
{
    ComposeToolBar *toolbar = [[ComposeToolBar alloc]init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.delegate = self;
    toolbar.y = self.view.height - toolbar.height;
    self.toolbar = toolbar;
    [self.view addSubview:toolbar];
}

- (void)setupTextView
{
    LSTextView *textview = [[LSTextView alloc]init];
    textview.delegate = self;
    self.textview = textview;
    
    self.textview.alwaysBounceVertical = YES;
    textview.font = [UIFont systemFontOfSize:15];
    textview.placeholder = @"分享新鲜事...";
    textview.placeholderColor = [UIColor lightGrayColor];
    
    textview.frame = self.view.bounds;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:textview];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [self.view addSubview:textview];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.width = 200;
    titleLabel.height = 35;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;

    NSString *name = [AccountTool account].name;
    NSString *font = @"发微博";
    NSString *str = [NSString stringWithFormat:@"%@\n%@",font,name];
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc]initWithString:str];
    [attrs addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:font]];
    [attrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
    titleLabel.attributedText = attrs;
    
    self.navigationItem.titleView = titleLabel;
}

- (void)textViewDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textview.hasText;
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    double duration =  [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -  ComposeToolbarDelegate 代理方法
- (void)ComposeToolBarDidClick:(ComposeToolBar *)toolbar didClickBtn:(ComposeToolBarType)type
{
    switch (type) {
        case ComposeToolBarTypeCamara:
            [self openCamara];
            break;
            
        case ComposeToolBarTypePicture:
            [self openAlbum];
            break;
            
        case ComposeToolBarTypeMention:
            
            break;
            
        case ComposeToolBarTypeTrend:
            
            break;
            
        case ComposeToolBarTypeEmotion:
           
            break;
        
    }
}

#pragma mark - 私有方法
- (void)openCamara
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType) type
{
    if(![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.phtotsView addPhotos:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 发送微博
- (void)send
{
    if (self.phtotsView.photos.count) {
        [self sendImageStatus];
    }else{
        [self sendWithoutImageStatus];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendImageStatus
{
    AFHTTPSessionManager *mng = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"pic"] = [self.phtotsView.photos firstObject];
    params[@"status"] = self.textview.text;
    
    [mng POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.phtotsView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发布失败"];
    }];
}


- (void)sendWithoutImageStatus
{
    AFHTTPSessionManager *mng = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"] = self.textview.text;
    
    [mng POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发布失败"];;
    }];
   
}


@end
