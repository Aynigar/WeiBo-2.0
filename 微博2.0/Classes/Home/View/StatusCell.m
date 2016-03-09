//
//  StatusCell.m
//  微博2.0
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "StatusCell.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "Photo.h"
#import "IconView.h"
#import "StatusToolbar.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"
#import "StatusPhotosView.h"
#import "StatusPhotosView.h"
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface StatusCell()
/**  原创微博整体*/

/** 原创微博*/
@property (nonatomic,weak) UIView *originalView;

/** 用户头像*/
@property (nonatomic,weak) IconView *iconView;

/** 会员图标*/
@property (nonatomic,weak) UIImageView *vipView;

/** 原创微博配图*/
@property (nonatomic,weak) StatusPhotosView *photoView;

/** 昵称*/
@property (nonatomic,weak) UILabel *nameLabel;

/** 微博来源*/
@property (nonatomic,weak) UILabel *sourceLabel;

/** 微博时间*/
@property (nonatomic,weak) UILabel *timeLabel;

/** 原创微博内容*/
@property (nonatomic,weak) UILabel *contentLabel;

/** 转发微博整体*/
@property (nonatomic,weak) UIView *retweetedView;

/** 转发微博正文*/
@property (nonatomic,weak) UILabel *retweetedContent;

/** 转发微博配图*/
@property (nonatomic,weak) StatusPhotosView *retweetedPhoto;

/** 底部工具条*/
@property (nonatomic,weak) StatusToolbar *toolBar;

@end

@implementation StatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //点击cell的时候颜色不变
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化原创微博
        [self setUpOriginal];
        
        //初始化转发微博
        [self setUpRetweeted];
        
        //初始化底部工具条
        [self setUpToolBar];
    }
    return self;
}

- (void)setUpToolBar
{
    StatusToolbar *toolBar = [StatusToolbar toolBar];
    self.toolBar = toolBar;
    [self.contentView addSubview:toolBar];
}

- (void)setUpRetweeted
{
    /** 转发微博整体*/
    UIView *retweetedView = [[UIView alloc]init];
    self.retweetedView = retweetedView;
    retweetedView.backgroundColor = Color(247, 247, 247);
    [self.contentView addSubview:retweetedView];
    
    /** 转发微博正文*/
    UILabel *retweetedContent = [[UILabel alloc]init];
    retweetedContent.numberOfLines = 0;
    retweetedContent.font = statusCellRewteedContentLabel;
    self.retweetedContent = retweetedContent;
    [retweetedView addSubview:retweetedContent];
    
    /** 转发微博配图*/
    StatusPhotosView *retweetedPhoto = [[StatusPhotosView alloc]init];
    self.retweetedPhoto = retweetedPhoto;
    [retweetedView addSubview:retweetedPhoto];
}

- (void)setUpOriginal
{
    /** 原创微博*/
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    self.originalView = originalView;
    [self.contentView addSubview:originalView];
    
    /** 用户头像*/
    IconView *iconView = [[IconView alloc]init];
    self.iconView = iconView;
    [originalView addSubview:iconView];
    
    /** 会员图标*/
    UIImageView *vipView = [[UIImageView alloc]init];
    self.vipView = vipView;
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    
    /** 原创微博配图*/
    StatusPhotosView *photoView = [[StatusPhotosView alloc]init];
    self.photoView = photoView;
    [originalView addSubview:photoView];
    
    /** 昵称*/
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = statusCellNameLabel;
    self.nameLabel = nameLabel;
    [originalView addSubview:nameLabel];
    
    
    /** 微博来源*/
    UILabel *sourceLabel = [[UILabel alloc]init];
    self.sourceLabel = sourceLabel;
    sourceLabel.font = statusCellSourceLabel;
    [originalView addSubview:sourceLabel];
    
    /** 微博时间*/
    UILabel *timeLabel = [[UILabel alloc]init];
    self.timeLabel = timeLabel;
    timeLabel.font = statusCellTimeLabel;
    [originalView addSubview:timeLabel];
    
    /** 原创微博内容*/
    UILabel *contentLabel = [[UILabel alloc]init];
    self.contentLabel = contentLabel;
    contentLabel.numberOfLines = 0;
    contentLabel.font = statusCellContentLabel;
    [originalView addSubview:contentLabel];
}

- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    Status *status = statusFrame.status;
    User *user = status.user;

    /** 用户头像*/
    self.iconView.frame = self.statusFrame.iconViewF;
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width * 0.5;
    self.iconView.layer.borderWidth = 3.0f;
    self.iconView.clipsToBounds = YES;
    self.iconView.layer.borderColor = [UIColor clearColor].CGColor;
    self.iconView.user = user;
    
    /** 会员图标*/
    self.vipView.frame = statusFrame.vipViewF;
    if (user.isVip) {
        self.vipView.hidden = NO;
        NSString *name = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:name];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /** 原创微博配图*/
    if (status.pic_urls.count) {
        self.photoView.photos = status.pic_urls;
        self.photoView.frame = statusFrame.photoViewF;
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }
    
    /** 昵称*/
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    /** 微博时间*/
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF);
    CGSize timeSize = [time sizeWithText:statusCellTimeLabel];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text = time;
    
    /** 微博来源*/
    NSString *source = status.source;
    CGFloat sourceX = CGRectGetMaxX(statusFrame.timeLabelF) + statusCellBorder;
    CGFloat sourecY = timeY;
    CGSize sourceSize = [source sizeWithText:statusCellSourceLabel];
    self.sourceLabel.frame = (CGRect){{sourceX,sourecY},sourceSize};
    self.sourceLabel.text = source;
    
    /** 原创微博内容*/
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    /** 原创微博整体*/
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 转发微博整体*/
    if (status.retweeted_status) {
        Status *retweeted_status = status.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
        
        self.retweetedView.hidden = NO;
        self.retweetedView.frame = statusFrame.retweetedViewF;
        
        /** 转发微博正文*/
        self.retweetedContent.frame = statusFrame.retweetedContentF;
        NSString *text = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetedContent.text = text;
        if (retweeted_status.pic_urls.count) {
            
            /** 转发微博配图*/
            self.retweetedPhoto.hidden = NO;
            self.retweetedPhoto.frame = statusFrame.retweetedPhotoF;
            self.retweetedPhoto.photos = retweeted_status.pic_urls;
        }else{
            self.retweetedPhoto.hidden = YES;
        }
        
    }else{
        self.retweetedView.hidden = YES;
        
    }
    self.toolBar.frame = statusFrame.toolBarF;
    self.toolBar.status = status;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//        Photo *photo = [status.pic_urls firstObject];
//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
@end
