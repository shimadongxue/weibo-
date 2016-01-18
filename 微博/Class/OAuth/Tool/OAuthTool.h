//
//  OAuthTool.h
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthParmaModel.h"
#import "OAuthResultModel.h"
@interface OAuthTool : NSObject




+(void)oauthWithParma:(OAuthParmaModel *)parma success:(void(^)(OAuthResultModel *result))success failure:(void (^)(NSError *error))failure;

@end
