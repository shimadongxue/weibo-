//
//  HomeResultModel.m
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import "HomeResultModel.h"
#import "MJExtension.h"
@implementation HomeResultModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses" : @"WBStatus"};
}
@end
