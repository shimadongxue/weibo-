//
//  WBAccountTool.m
//  微博
//
//  Created by llairen on 15/11/5.
//  Copyright © 2015年 llairen. All rights reserved.
//
#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.archive"]
#import "WBAccountTool.h"

@implementation WBAccountTool
/**存储模型工具类 */
+(void)saveAccount:(WBAccount *)account
{
    account.created_time=[NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
}

/**获得一个帐号模型*/
+(WBAccount *)account
{
    //取出一个帐叼
    WBAccount * account=[NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    //转换过期秒数
    long long createNum= [account.expires_in longLongValue];
    //换算过期的时间
    NSDate *expires_time=[account.created_time dateByAddingTimeInterval:createNum];
    NSDate * now=[NSDate date];
    //对比过期的时间是否过期
    NSComparisonResult result=[expires_time compare:now];
//    {NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};

    if (result!=NSOrderedDescending)
    {
        return nil;
    }
    return account;
}
@end
