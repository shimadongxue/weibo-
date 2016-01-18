//
//  UIWindow+Extension.m
//  微博
//
//  Created by llairen on 15/11/5.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MainTabBarViewController.h"
#import "NewFeatureViewController.h"
@implementation UIWindow (Extension)
-(void)switchRootViewController
{
    NSString *keyVersion=@"CFBundleVersion";
    //     这次的版本号
    NSString * string =[NSBundle mainBundle].infoDictionary[keyVersion];
    //    上次的版本号
    NSString * lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:keyVersion];
    //    判断版本号确定主控制器。
    if ([string isEqualToString:lastVersion])
    {
        self.rootViewController=[[MainTabBarViewController alloc]init];
    }
    else{
        self.rootViewController=[[NewFeatureViewController alloc]init];
        [[NSUserDefaults standardUserDefaults]setObject:string forKey:keyVersion];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
@end
