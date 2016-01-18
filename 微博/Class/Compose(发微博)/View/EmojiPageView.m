//
//  EmojiPageView.m
//  个人客户端
//
//  Created by llairen on 15/12/18.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "EmojiPageView.h"
#import "EmojiBtnView.h"
#import "EmojiTool.h"
@interface EmojiPageView ()

@property (nonatomic, strong)EmojiBtnView *emojiBtnView;
@property (nonatomic, weak)UIButton *button;
@end

@implementation EmojiPageView



-(EmojiBtnView *)emojiBtnView
{
    if (_emojiBtnView==nil)
    {
        self.emojiBtnView=[EmojiBtnView emojiBtnView];
        
    }
    return _emojiBtnView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        
        //删除按钮
        UIButton * button=[[UIButton alloc]init];
        [button setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:button];
        [button addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        self.button=button;
        
        
        
        //添加长按手势
        UILongPressGestureRecognizer * recognizer=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPreessGest:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

-(void)longPreessGest:(UILongPressGestureRecognizer *)longPressGest
{
    CGPoint loc=[longPressGest locationInView:longPressGest.view];
   
    EmojiBtn * emojibtn=[self emojiButtonWithLocation:loc];
    switch (longPressGest.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.emojiBtnView removeFromSuperview];
            if(emojibtn)
            {
                [self selectEmojiBtnAddFile:emojibtn.emoji];
            }
        
            
            break;
        case UIGestureRecognizerStateChanged:
        case UIGestureRecognizerStateBegan:
            [self.emojiBtnView showFrom:emojibtn];
            
        default:
            break;
    }
    
}

//根据一个点
-(EmojiBtn *)emojiButtonWithLocation:(CGPoint)location
{
     NSUInteger count=self.emojiArr.count;
    for (int i=0; i<count; i++)
    {
        EmojiBtn * BTN=self.subviews[i+1];
        if (CGRectContainsPoint(BTN.frame, location))
        {
            return BTN;
        }
    }
    return nil;
    
}
-(void)deleteClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDeletedBtnClick object:nil];
}
-(void)setEmojiArr:(NSArray *)emojiArr
{
    _emojiArr=emojiArr;
    for (int i=0; i<emojiArr.count; i++) {
        EmojiBtn * button=[[EmojiBtn alloc]init];
        

        button.emoji=emojiArr[i];
        
        [self addSubview:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Inset=20;
    CGFloat BtnW=(self.width-2*Inset)/EmojiBtnMaxCol;
    CGFloat BtnH=(self.height-Inset)/EmojiBtnMaxRow;
    NSUInteger count=self.emojiArr.count;
    for (int i=0;i<count;i++)
    {
        EmojiBtn *btn =self.subviews[i + 1];
        
        btn.x=Inset+(i%EmojiBtnMaxCol)*BtnW;
        btn.y=Inset+(i/EmojiBtnMaxCol)*BtnH;
        btn.width=BtnW;
        btn.height=BtnH;
    }
    self.button.width=BtnW;
    self.button.height=BtnH;
    self.button.x=self.width-Inset-BtnW;
    self.button.y=self.height-BtnH;
    
}


-(void)btnClick:(EmojiBtn *)btn
{
    
    [self.emojiBtnView showFrom:btn];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emojiBtnView removeFromSuperview];
    });
    
    [self selectEmojiBtnAddFile:btn.emoji];
}
-(void)selectEmojiBtnAddFile:(EmojiModel *)emoji
{
    //插入表情通知
    [EmojiTool addEmoji:emoji];
    NSMutableDictionary * uerInfo=[NSMutableDictionary dictionary];
    uerInfo[EmojiModelUerInfoKey]=emoji;
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDidSelectNotification object:nil userInfo:uerInfo];
}
@end
