//
//  WBTabBar.m
//  微博
//
//  Created by llairen on 15/11/4.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "WBTabBar.h"
@interface WBTabBar();
@property (nonatomic, weak)UIButton *plusBtn;
@end
@implementation WBTabBar
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        //tabBar中间的哪个加号按钮
        UIButton * plusBtn=[[UIButton alloc]init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size=plusBtn.currentBackgroundImage.size;
        [self addSubview:plusBtn];
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn=plusBtn;
    }
    return self;
}
-(void)plusBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidPlusBtn:)])
    {
        [self.delegate tabBarDidPlusBtn:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.plusBtn.centerX=self.width*0.5;
    self.plusBtn.centerY=self.height*0.5;
    CGFloat tabBarW=self.width/5;
    int i=0;
    for (UIView *view in self.subviews)
    {
        Class class=NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class])
        {
            view.width=tabBarW;
            view.x=i*tabBarW;
            i++;
            if (i==2)
            {
                i++;
            }
        }
    }
}
@end
