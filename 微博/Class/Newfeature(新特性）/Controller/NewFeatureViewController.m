//
//  NewFeatureViewController.m
//  微博
//
//  Created by llairen on 15/11/2.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "MainTabBarViewController.h"
#define NewFeatureCount 4
@interface NewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak)UIScrollView *scroll;
@property (nonatomic, weak)UIPageControl *pageControl;
@end

@implementation NewFeatureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个新特性的SCROLL的view
    UIScrollView * scroll=[[UIScrollView alloc]init];
    scroll.frame=self.view.bounds;
    [self.view addSubview:scroll];
    //scroll的一些属性值
    self.scroll=scroll;
    self.scroll.pagingEnabled=YES;
    self.scroll.bounces=NO;
    self.scroll.showsHorizontalScrollIndicator=NO;
    self.scroll.delegate=self;
    //imageView图片宽高
    CGFloat scrollW=self.scroll.width;
    CGFloat scrollH=self.scroll.height;
    CGFloat y=0;
    for (int i=0; i<NewFeatureCount;i++)
    {
        //添加imageView并添加图片
        UIImageView *NewimageView=[[UIImageView alloc]init];
        NSString * imageStr=[NSString stringWithFormat:@"new_feature_%d",i+1];
        NewimageView.image=[UIImage imageNamed:imageStr];
        
        CGFloat x=i* scrollW;
        //图片的frame
        NewimageView.frame=CGRectMake(x, y, scrollW, scrollH);
        //添加checkBox 和开始微博
        if (i==NewFeatureCount-1)
        {
            [self setUplastImageView:NewimageView];
        }
        [self.scroll addSubview:NewimageView];
        
    }
    //scrollView的尺寸
    self.scroll.contentSize=CGSizeMake(scrollW*NewFeatureCount, scrollH);
    //添加pageController以及属性
    UIPageControl * pageControl=[[UIPageControl alloc]init];
    pageControl.backgroundColor=[UIColor blackColor];
    pageControl.numberOfPages=NewFeatureCount;
    [self.view addSubview:pageControl];
    pageControl.currentPageIndicatorTintColor=WBColor(253, 98, 42,1);
    pageControl.pageIndicatorTintColor=WBColor(189, 189, 189, 1);
    pageControl.centerY=scroll.height-50;
    pageControl.centerX=scroll.width*0.5;
    self.pageControl=pageControl;
    
}
-(void)setUplastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled=YES;
    UIButton *checkBon=[[UIButton alloc]init];
    [checkBon setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    [checkBon setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateSelected];
    [checkBon setTitle:@"分享给朋友圈" forState:UIControlStateNormal];
    checkBon.width=200;
    checkBon.height=40;
    checkBon.x=(imageView.width-200)*0.5;
    checkBon.centerY=imageView.height*0.6;
//    checkBon.backgroundColor=[UIColor yellowColor];
    checkBon.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    [checkBon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBon addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    //开始微博
    UIButton *start=[[UIButton alloc]init];
    
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    [start setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [start setTitle:@"开始微博" forState:UIControlStateNormal];
    start.width=200;
    start.height=30;
    start.x=(imageView.width-200)*0.5;
    start.y=imageView.height*0.7;
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:start];
    [imageView addSubview:checkBon];
}
-(void)start
{
    UIWindow * window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[MainTabBarViewController alloc]init];
}
-(void)checkBoxClick:(UIButton *)button
{
    button.selected=!button.isSelected;
    
}
//准确确定pageControl的页数
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page=scrollView.contentOffset.x/self.scroll.width;
    self.pageControl.currentPage=(int)(page+0.5);
}

@end
