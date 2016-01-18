//
//  WBAccountTool.h
//  微博
//
//  Created by llairen on 15/11/5.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBAccount.h"
@interface WBAccountTool : NSObject
/**存储模型工具类 */
+(void)saveAccount:(WBAccount *)account;

/**获得一个帐号模型*/
+(WBAccount *)account;
@end
