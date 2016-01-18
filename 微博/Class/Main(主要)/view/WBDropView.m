//
//  WBDropView.m
//  微博
//
//  Created by llairen on 15/10/29.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "WBDropView.h"
@interface WBDropView ()

@property (nonatomic, weak)UIImageView *containerView;

@end
@implementation WBDropView
-(UIImageView *)containerView
{
    if (!_containerView)
    {
        //灰色图片
        UIImageView *containerView=[[UIImageView alloc]init];
        containerView.image=[UIImage imageNamed:@"popover_background"];
        
        containerView.userInteractionEnabled=YES;
        [self addSubview:containerView];
        self.containerView =containerView;
    }
    return _containerView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+(instancetype)menu
{
    return [[self alloc]init];
}
-(void)setContentController:(UIViewController *)contentController
{
    _contentController=contentController;
    self.content=contentController.view;
}
-(void)setContent:(UIView *)content
{
    _content=content;
    content.x=10;
    content.y=15;
    self.containerView.width=CGRectGetMaxX(content.frame)+10;
    self.containerView.height=CGRectGetMaxY(content.frame)+10;
    [self.containerView addSubview:content];
}
-(void)showFrom:(UIView *)form
{
    UIWindow * window=[[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame=window.bounds;
    CGRect newFrame=[form convertRect:form.bounds toView:window];
    self.containerView.centerX=CGRectGetMidX(newFrame);
    self.containerView.y=CGRectGetMaxY(newFrame);
    if ([self.delegate respondsToSelector:@selector(dropMenuViewDidShow:)])
    {
        [self.delegate dropMenuViewDidShow:self];
    }
}
-(void)dismiss
{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropDismissMenuView:)])
    {
        [self.delegate dropDismissMenuView:self];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
