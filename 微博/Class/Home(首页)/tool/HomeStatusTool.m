//
//  HomeStatusTool.m
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import "HomeStatusTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
@implementation HomeStatusTool


+(void)homeGetWithParma:(HomeStatusParmaModel *)parma succes:(void (^)(HomeResultModel *))succes failure:(void (^)(NSError *))failure
{
    [HttpTool getWithUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" parmar:parma.mj_keyValues success:^(id json) {
        if (succes)
        {
            HomeResultModel * result=[HomeResultModel mj_objectWithKeyValues:json];
            succes(result);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}
@end
