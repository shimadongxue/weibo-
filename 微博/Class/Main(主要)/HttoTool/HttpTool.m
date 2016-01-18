//
//  HttpTool.m
//  个人客户端
//
//  Created by llairen on 16/1/8.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@implementation HttpTool



+(void)getWithUrl:(NSString *)url parmar:(NSDictionary * )parmar success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager * mar=[AFHTTPRequestOperationManager manager];

    [mar GET:url parameters:parmar success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(void)postWithUrl:(NSString *)url parmar:(NSDictionary * )parmar success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager * mar=[AFHTTPRequestOperationManager manager];
    
    [mar POST:url parameters:parmar success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)postWithUrl:(NSString *)url parmar:(NSDictionary *)parmar formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager * mar=[AFHTTPRequestOperationManager manager];
    
    [mar POST:url parameters:parmar constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        for (WBFormData * WBformData in formDataArray)
        {
            [formData appendPartWithFileData:WBformData.data name:WBformData.name fileName:WBformData.fileName mimeType:WBformData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end


/**
 *  用来封装文件数据的模型
 */
@implementation WBFormData

@end
