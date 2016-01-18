//
//  ComposeToolBar.m
//  微博
//
//  Created by llairen on 15/11/30.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "ComposeToolBar.h"

@interface ComposeToolBar ()
@property (nonatomic ,weak)UIButton *emotionButton;

@end



@implementation ComposeToolBar


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        //工具条背景
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        //相机
        [self setWithImage:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" type:ComposeToolBarButtonCamera];
        //照片
        [self setWithImage:@"compose_toolbar_picture" hightImage:@"compose_toolbar_picture_highlighted" type:ComposeToolBarButtonPicture];
        //@
        [self setWithImage:@"compose_mentionbutton_background" hightImage:@"compose_mentionbutton_background_highlighted" type:ComposeToolBarButtonMention];
        //#
        [self setWithImage:@"compose_trendbutton_background" hightImage:@"compose_trendbutton_background_highlighted" type:ComposeToolBarButtonTrend];
        //表情/键盘
        self.emotionButton=[self setWithImage:@"compose_emoticonbutton_background" hightImage:@"compose_emoticonbutton_background_highlighted" type:ComposeToolBarButtonEmotion];
    }
    return self;
}

-(UIButton *)setWithImage:(NSString *)name hightImage:(NSString *)hightImage type:(ComposeToolBarButtonType)type
{
    UIButton * button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    button.tag=type;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}
-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)])
    {
        ComposeToolBarButtonType type=(ComposeToolBarButtonType)btn.tag;
        [self.delegate composeToolBar:self didClickBtn:type];
    }
}
-(void)setShowKeyboardBtn:(BOOL)showKeyboardBtn
{
    _showKeyboardBtn=showKeyboardBtn;
    NSString * image=@"compose_emoticonbutton_background";
    NSString * heightImage=@"compose_emoticonbutton_background_highlighted";
    if (showKeyboardBtn)
    {
        image = @"compose_keyboardbutton_background";
        heightImage = @"compose_keyboardbutton_background_highlighted";
    }
    // 设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //所有子view
    NSUInteger count=self.subviews.count;

    CGFloat y=0;
    CGFloat w=self.frame.size.width/count;
    CGFloat h=self.frame.size.height;
        for (int i=0;i<count;i++)
    {
        CGFloat x=i*w;
        self.subviews[i].frame=CGRectMake(x, y, w, h);
    }
}
@end
