//
//  ComposeToolBar.h
//  微博2.0
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComposeToolBar;

typedef enum {
    ComposeToolBarTypeCamara,
    ComposeToolBarTypePicture,
    ComposeToolBarTypeMention,
    ComposeToolBarTypeTrend,
    ComposeToolBarTypeEmotion
}ComposeToolBarType;

@protocol ComposeToolBarDelegate <NSObject>

@optional
- (void)ComposeToolBarDidClick:(ComposeToolBar *)toolbar didClickBtn:(ComposeToolBarType)type;
@end
@interface ComposeToolBar : UIView

@property (nonatomic,weak) id<ComposeToolBarDelegate> delegate;

@end
