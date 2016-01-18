//
//  HttpTool.h
//  个人客户端
//
//  Created by llairen on 16/1/8.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject


/**
 get的一个网络请求
 */
+(void)getWithUrl:(NSString *)url parmar:(NSDictionary * )parmar success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
/**
 post的一个网络请求
 */
+(void)postWithUrl:(NSString *)url parmar:(NSDictionary * )parmar success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
/**
 post的一个上传文件的网络请求
 */
+(void)postWithUrl:(NSString *)url parmar:(NSDictionary * )parmar formDataArray:(NSArray *)formDataArray success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
@end


/**
 *  用来封装文件数据的模型
 */
@interface WBFormData : NSObject
/**
 *  文件数据
 */
@property(nonatomic , strong) NSData * data;
@property(nonatomic ,copy) NSString * name;
@property(nonatomic ,copy) NSString * fileName;
@property(nonatomic ,copy) NSString * mimeType;
@end