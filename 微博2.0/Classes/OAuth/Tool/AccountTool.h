//
//  AccountTool.h
//  微博2.0
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountTool : NSObject
+ (void)saveAccount:(Account *)account;
+ (Account *)account;
@end
