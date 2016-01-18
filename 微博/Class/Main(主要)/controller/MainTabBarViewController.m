//
//  MainTabBarViewController.m
//  微博
//
//  Created by llairen on 15/10/8.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomeTableViewController.h"
#import "MessageTableViewController.h"
#import "DiscoverTableViewController.h"
#import "MineTableViewController.h"
#import "WBNavViewController.h"
#import "ComposeViewController.h"
#import "WBTabBar.h"
@interface MainTabBarViewController ()<WBTabBarDelegate>

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //首页
    HomeTableViewController *home=[[HomeTableViewController alloc]init];
    [self setUpController:home title:@"首页" image:@"tabbar_home" seletedImage:@"tabbar_home_selected"];
    //消息
    MessageTableViewController *message=[[MessageTableViewController alloc]init];
    [self setUpController:message title:@"消息" image:@"tabbar_message_center" seletedImage:@"tabbar_message_center_selected"];
    //广场
    DiscoverTableViewController *discover=[[DiscoverTableViewController alloc]init];
    [self setUpController:discover title:@"发现" image:@"tabbar_discover" seletedImage:@"tabbar_discover_selected"];
    //我的
    MineTableViewController *mine=[[MineTableViewController alloc]init];
    [self setUpController:mine title:@"我" image:@"tabbar_profile" seletedImage:@"tabbar_profile_selected"];
    WBTabBar * wbTabBar=[[WBTabBar alloc]init];
    wbTabBar.delegate  =self;
    [self setValue:wbTabBar forKeyPath:@"tabBar"];
}
-(void)tabBarDidPlusBtn:(WBTabBar *)tabBar
{
    ComposeViewController * compose=[[ComposeViewController alloc]init];
    WBNavViewController * nav=[[WBNavViewController alloc]initWithRootViewController:compose];
    
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)setUpController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image seletedImage:(NSString *)seletedImage
{
    //标题
    childController.title=title;

    childController.tabBarItem.image=[UIImage imageNamed:image];
    childController.tabBarItem.selectedImage=[[UIImage imageNamed:seletedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //文字颜色
    NSMutableDictionary *arrtTittle=[NSMutableDictionary dictionary];
    arrtTittle[NSForegroundColorAttributeName]=WBColor(123, 123, 123,1.0);
    [childController.tabBarItem setTitleTextAttributes:arrtTittle forState:UIControlStateNormal];
    NSMutableDictionary *selectedArrtTittle=[NSMutableDictionary dictionary];
    selectedArrtTittle[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:selectedArrtTittle forState:UIControlStateSelected];
//    childController.view.backgroundColor= [UIColor clearColor];

        //包装导航控制器
    WBNavViewController *nav=[[WBNavViewController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
}

@end
