//
//  ComposeController.h
//  微博2.0
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeToolBar.h"
@class LSTextView;
@class ComposePhotosView;
@interface ComposeController : UIViewController<UITextViewDelegate,ComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) LSTextView *textview;
@property (nonatomic,weak) ComposeToolBar *toolbar;
@property (nonatomic,weak) ComposePhotosView *phtotsView;
@end
