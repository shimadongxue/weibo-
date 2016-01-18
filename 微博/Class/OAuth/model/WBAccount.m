//
//  WBAccount.m
//  微博
//
//  Created by llairen on 15/11/5.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount
+(instancetype)accountWithDict:(NSDictionary *)dict
{
    WBAccount *account=[[self alloc]init];
    account.access_token=dict[@"access_token"];
    account.expires_in=dict[@"expires_in"];
    account.uid=dict[@"uid"];

    return account;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}
-(id)initWithCoder:(NSCoder *)decoder
{
    if (self=[super init])
    {
        self.access_token=[decoder decodeObjectForKey:@"access_token"];
        self.expires_in=[decoder decodeObjectForKey:@"expires_in"];
        self.uid=[decoder decodeObjectForKey:@"uid"];
        self.created_time=[decoder decodeObjectForKey:@"created_time"];
        self.name=[decoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
