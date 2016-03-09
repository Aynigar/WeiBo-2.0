//
//  StatusFrame.m
//  微博2.0
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "StatusFrame.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"
#import "User.h"
#import "Status.h"
#import "StatusPhotosView.h"


@implementation StatusFrame

- (void)setStatus:(Status *)status
{
    
    _status = status;
    User *user = status.user;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    /** 用户头像*/
    CGFloat iconWH = 40;
    CGFloat iconX = statusCellBorder;
    CGFloat iconY = statusCellBorder;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称*/
    CGFloat nameX = iconWH + 15;
    CGFloat nameY = iconY;
    CGSize  nameSize = [user.name sizeWithText:statusCellNameLabel];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** 会员图标*/
    if (user.isVip)
    {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + statusCellBorder;
        CGFloat vipY = nameY;
        CGFloat vipW = 15;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 微博时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.iconViewF);
    CGSize timeSize = [status.created_at sizeWithText:statusCellTimeLabel];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /** 微博来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + statusCellBorder;
    CGFloat sourecY = timeY;
    CGSize sourceSize = [status.source sizeWithText:statusCellSourceLabel];
    self.sourceLabelF = (CGRect){{sourceX,sourecY},sourceSize};
    
    /** 原创微博内容*/
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + statusCellBorder;
    CGFloat maxW = cellW - 2 * statusCellBorder;
    CGSize contentSize = [status.text sizeWithText:statusCellContentLabel maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    /** 原创微博配图*/
    CGFloat originH = 0;
    if (status.pic_urls.count) {
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + statusCellBorder;
        CGSize photoSize = [StatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photoViewF = (CGRect){{photoX,photoY},photoSize};
        originH = CGRectGetMaxY(self.photoViewF) + statusCellBorder;
    }else{
        originH = CGRectGetMaxY(self.contentLabelF) + statusCellBorder;
    }
    
    /** 原创微博整体*/
    CGFloat originX = 0;
    CGFloat originY = statusCellMargin;
    CGFloat originW = cellW;
    self.originalViewF = CGRectMake(originX, originY, originW, originH);
  
     /** 转发微博*/
    CGFloat toolBarY = 0;
    if (status.retweeted_status) {
        
        Status *retweeted_status = status.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
         /** 转发微博内容*/
        CGFloat retweetedContentX = statusCellBorder;
        CGFloat retweetedContentY = statusCellBorder;
         NSString *text = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        CGSize  retweetedContentSize = [text sizeWithText:statusCellRewteedContentLabel maxW:cellW];
        self.retweetedContentF = (CGRect){{retweetedContentX,retweetedContentY},retweetedContentSize};
        
        CGFloat reweetedH = 0;
        if (retweeted_status.pic_urls.count) {
            /** 转发微博配图*/
            CGFloat retweetedPhotoX = retweetedContentX;
            CGFloat retweetedPhotoY = CGRectGetMaxY(self.retweetedContentF) + statusCellBorder;
            CGSize  retweetedSize = [StatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            self.retweetedPhotoF = (CGRect){{retweetedPhotoX,retweetedPhotoY},retweetedSize};
            reweetedH = CGRectGetMaxY(self.retweetedPhotoF) + statusCellBorder;
            
        }else{
            reweetedH = CGRectGetMaxY(self.retweetedContentF) + statusCellBorder;
        }
      /** 转发微博整体*/
        CGFloat reweetedX = 0;
        CGFloat reweetedY = CGRectGetMaxY(self.originalViewF);
        CGFloat reweetedW = cellW;
        self.retweetedViewF = CGRectMake(reweetedX, reweetedY, reweetedW, reweetedH);
        toolBarY = CGRectGetMaxY(self.retweetedViewF);
        //self.cellHeight = CGRectGetMaxY(self.retweetedViewF);
    }else{
        toolBarY = CGRectGetMaxY(self.originalViewF) + 1;
        //self.cellHeight = CGRectGetMaxY(self.originalViewF);
    }
    
    /** 底部工具条*/
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
    
}


//NSUInteger maxcols = 3;
//列数
//NSUInteger cols = (count>= maxcols)? maxcols:count;
//CGFloat photoW = StatusphotosSize * cols + (cols - 1) * StatusphotosMargin;

//行数
//    NSUInteger rows = 0;
//    if (count % 3 ==0) {
//        rows = count / 3;
//    }else{
//        rows = count / 3 + 1;
//    }
@end
