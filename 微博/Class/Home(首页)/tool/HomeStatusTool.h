//
//  HomeStatusTool.h
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeStatusParmaModel.h"
#import "HomeResultModel.h"
@interface HomeStatusTool : NSObject



+(void)homeGetWithParma:(HomeStatusParmaModel *)parma succes:(void (^)(HomeResultModel * result))succes failure:(void (^)(NSError *error))failure;
@end
