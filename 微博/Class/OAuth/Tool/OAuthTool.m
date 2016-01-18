//
//  OAuthTool.m
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import "OAuthTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
@implementation OAuthTool



+(void)oauthWithParma:(OAuthParmaModel *)parma success:(void (^)(OAuthResultModel *))success failure:(void (^)(NSError *))failure
{
    [HttpTool postWithUrl:@"https://api.weibo.com/oauth2/access_token" parmar:parma.mj_keyValues success:^(id json) {
        if (success)
        {
            OAuthResultModel * result=[OAuthResultModel mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
