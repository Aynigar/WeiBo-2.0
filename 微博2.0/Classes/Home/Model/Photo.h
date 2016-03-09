//
//  Photo.h
//  微博2.0
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
/** thumbnail_pic	string	缩略图片地址，没有时不返回此字段*/
@property (nonatomic,copy) NSString *thumbnail_pic;

@end
