//
//  UIBarButtonItem+Extension.m
//  微博
//
//  Created by llairen on 15/10/27.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size=btn.currentBackgroundImage.size;
    UIBarButtonItem * barButton=[[UIBarButtonItem alloc]initWithCustomView:btn];
    return barButton;
}
@end
