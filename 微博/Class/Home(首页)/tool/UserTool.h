//
//  UserTool.h
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserParmaModel.h"
#import "UserResultModel.h"
@interface UserTool : NSObject



+(void)userInfoWithParma:(UserParmaModel *)parma success:(void(^)(UserResultModel *result))success failure:(void (^)(NSError *error))failure;
@end
