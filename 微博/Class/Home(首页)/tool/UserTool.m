//
//  UserTool.m
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import "UserTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
@implementation UserTool



+(void)userInfoWithParma:(UserParmaModel *)parma success:(void (^)(UserResultModel *))success failure:(void (^)(NSError *))failure
{
        [HttpTool getWithUrl:@"https://api.weibo.com/2/users/show.json" parmar:parma.mj_keyValues success:^(id json) {
            if (success)
            {
                UserResultModel *result=[UserResultModel mj_objectWithKeyValues:json];
                success(result);
            }
        } failure:^(NSError *error) {
            failure(error);
        }];
}
@end
