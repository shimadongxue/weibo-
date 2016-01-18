//
//  EmotionTabBar.m
//  个人客户端
//
//  Created by llairen on 15/12/16.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "EmotionTabBar.h"
#import "ComposeTabBarButton.h"

@interface EmotionTabBar ()
@property (nonatomic ,weak)UIButton * selectedBtn;

@end



@implementation EmotionTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
//        self.backgroundColor=[UIColor redColor];
        [self setUpBtnName:@"最近" type:EmotionTabBarButtonTypeRecent];
        [self setUpBtnName:@"默认" type:EmotionTabBarButtonTypeDefault];
        [self setUpBtnName:@"Emoji" type:EmotionTabBarButtonTypeEmoji];
        [self setUpBtnName:@"浪小花" type: EmotionTabBarButtonTypeLxh];
    }
    return self;
}


/**tabBar按钮 */

-(void)setUpBtnName:(NSString *)name type:(EmotionTabBarButtonType )type
{
    ComposeTabBarButton * button=[[ComposeTabBarButton alloc]init];
    [button setTitle:name forState:UIControlStateNormal];
    
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    button.titleLabel.font=[UIFont systemFontOfSize:13];
    button.tag=type;
    // 设置背景图片
    [self addSubview:button];
    NSString *image = @"compose_emotion_table_right_normal";
    NSString *selectImage = @"compose_emotion_table_right_selected";

    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    
    
}
/**默认选中按钮*/

-(void)setDelegate:(id<EmotionTabBarDelegate>)delegate
{
    _delegate=delegate;
    [self btnClick:[self viewWithTag:EmotionTabBarButtonTypeDefault]];
}


-(void)btnClick:(UIButton *)button
{
    self.selectedBtn.enabled=YES;
    button.enabled=NO;
    self.selectedBtn=button;
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSeletcedBtn:)])
    {
        [self.delegate emotionTabBar:self didSeletcedBtn:(EmotionTabBarButtonType)button.tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int count=(int)self.subviews.count;
    CGFloat BtnY=0;
    CGFloat BtnW=self.width/count;
    CGFloat BtnH=self.height;
    for (int i=0; i<count; i++) {
        UIButton * Btn=self.subviews[i];
        
        CGFloat BtnX= i*BtnW;
        Btn.frame=CGRectMake(BtnX, BtnY, BtnW, BtnH);
    }
}
@end
