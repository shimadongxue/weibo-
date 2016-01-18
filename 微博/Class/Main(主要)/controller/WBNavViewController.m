//
//  WBNavViewController.m
//  微博
//
//  Created by llairen on 15/10/27.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "WBNavViewController.h"
#import "UIBarButtonItem+Extension.h"
@interface WBNavViewController ()

@end

@implementation WBNavViewController
+(void)initialize
{
    //第一次使用类设置barButton文字（正常与不正常状态的两种文字）
    
    UIBarButtonItem * barButton=[UIBarButtonItem appearance];
    NSMutableDictionary * normal=[NSMutableDictionary dictionary];
    normal[NSForegroundColorAttributeName]=[UIColor orangeColor];
    normal[NSFontAttributeName]=[UIFont systemFontOfSize:14];
    [barButton setTitleTextAttributes:normal forState:UIControlStateNormal];
    
    NSMutableDictionary * disenble=[NSMutableDictionary dictionary];
    disenble[NSFontAttributeName]=[UIFont systemFontOfSize:14];
    disenble[NSForegroundColorAttributeName]=WBColor(0.6, 0.6, 0.6, 0.5);
    [barButton setTitleTextAttributes:disenble forState:UIControlStateDisabled];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count>0)
    {
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed=YES;
        
        //设置导航barButtonItem
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(moreClick) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        
    }
    
    [super pushViewController:viewController animated:YES];
}
-(void)backClick
{
    [self popViewControllerAnimated:YES];
}
-(void)moreClick
{
    [self popToRootViewControllerAnimated:YES];
}


@end
