//
//  ComposeKeyboardView.m
//  个人客户端
//
//  Created by llairen on 15/12/16.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "ComposeKeyboardView.h"
#import "EmotionTabBar.h"
#import "EmotionListView.h"
#import "MJExtension.h"
#import "EmojiTool.h"
@interface ComposeKeyboardView ()<EmotionTabBarDelegate>
/**创建表情底部tabBar */
@property (nonatomic ,weak )EmotionTabBar *TabBar;


/** 把表情view放入showView盒子里*/
/** 最近表情*/
@property (nonatomic, weak) EmotionListView *showListView;

/** 最近表情*/
@property (nonatomic, strong) EmotionListView *recentListView;
/** 默认表情*/
@property (nonatomic, strong) EmotionListView *defaultListView;
/** emoji表情*/
@property (nonatomic, strong) EmotionListView *emojiListView;
/** 浪小花表情*/
@property (nonatomic, strong) EmotionListView *lxhListView;
@end



@implementation ComposeKeyboardView




#pragma mark -懒加载表情数据


/** 最近表情*/
-(EmotionListView *)recentListView
{
    if (_recentListView==nil)
    {
        _recentListView=[[EmotionListView alloc]init];
        _recentListView.emotionArr=[EmojiTool emojiArr];
    }
    return _recentListView;
}
/** 默认表情*/
-(EmotionListView *)defaultListView
{
    if (_defaultListView==nil)
    {
        _defaultListView=[[EmotionListView alloc]init];
//        _defaultListView.backgroundColor=WBArc4random;

        NSString * path=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultListView.emotionArr=[EmojiModel mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}
/** emoji表情*/

-(EmotionListView *)emojiListView
{
    if (_emojiListView==nil)
    {
        _emojiListView=[[EmotionListView alloc]init];
//        _emojiListView.backgroundColor=WBArc4random;

        NSString * path=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiListView.emotionArr=[EmojiModel mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}
/** 浪小花表情*/
-(EmotionListView *)lxhListView
{
    if (_lxhListView==nil)
    {
        _lxhListView=[[EmotionListView alloc]init];
//        _lxhListView.backgroundColor=WBArc4random;

        NSString * path=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhListView.emotionArr=[EmojiModel mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}




-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
//        1.添加表情键盘底部
        EmotionTabBar * TabBar=[[EmotionTabBar alloc]init];
        [self addSubview:TabBar];
        self.TabBar=TabBar;
        TabBar.delegate=self;
//        2.添加表情内容的父级盒子
//        EmotionListView *showListView=[[EmotionListView alloc]init];
//        [self addSubview:showListView];
//        self.showListView=showListView;
//        self.showListView.backgroundColor=[UIColor greenColor];
    }
    return self;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat tabBarH=37;
//     1.添加表情键盘底部
    self.TabBar.x=0;
    self.TabBar.height=tabBarH;
    self.TabBar.y=self.height-tabBarH;
    self.TabBar.width=self.width;
//    2.添加表情内容的父级盒子
    self.showListView.x=0;
    self.showListView.y=0;
    self.showListView.width=self.width;
    self.showListView.height=self.height-tabBarH;
    
}


-(void)emotionTabBar:(EmotionTabBar *)tabBar didSeletcedBtn:(EmotionTabBarButtonType)btnType
{
    [self.showListView removeFromSuperview];
    switch (btnType) {
        case EmotionTabBarButtonTypeRecent:{
            [self addSubview:self.recentListView];
            break;
        }
        case EmotionTabBarButtonTypeDefault:{
            [self addSubview:self.defaultListView];
            break;
        }
            
        case EmotionTabBarButtonTypeEmoji:{
            [self addSubview:self.emojiListView];
            break;
        }
            
        case EmotionTabBarButtonTypeLxh:{
            [self addSubview:self.lxhListView];
            break;
        }
            
      
    }
    self.showListView=[self.subviews lastObject];
    [self setNeedsLayout];
}
@end
