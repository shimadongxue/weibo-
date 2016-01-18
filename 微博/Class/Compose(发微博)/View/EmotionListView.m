//
//  EmotionListView.m
//  个人客户端
//
//  Created by llairen on 15/12/16.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "EmotionListView.h"
#import "EmojiPageView.h"



@interface EmotionListView ()<UIScrollViewDelegate>
/**  表情分页control*/
@property (nonatomic, weak)UIPageControl *pageControl;

///** 表情scrollView*/
@property (nonatomic, weak)UIScrollView *scrollView;
@end


@implementation EmotionListView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        [self addSubview:scrollView];
        scrollView.delegate=self;
        scrollView.pagingEnabled=YES;
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.showsVerticalScrollIndicator=NO;
//        scrollView.backgroundColor=WBArc4random;
        self.scrollView=scrollView;
        
        UIPageControl * pageControl=[[UIPageControl alloc]init];
        [self addSubview:pageControl];
        pageControl.enabled=YES;
//        pageControl.backgroundColor=WBArc4random;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        self.pageControl=pageControl;
    }
    return self;
}

-(void)setEmotionArr:(NSArray *)emotionArr
{
    _emotionArr=emotionArr;
    NSUInteger count=(emotionArr.count + EmojiPageNum -1)/EmojiPageNum;
    /**  把表情字典模型分为20个一组 为一个pageControl页*/
    self.pageControl.numberOfPages=count;
    
    /** 根据分页视图的个数创建scrollView的contentView*/
    for (int i=0; i<count; i++) {
        EmojiPageView *pageView=[[EmojiPageView alloc]init];
        [self.scrollView addSubview:pageView];
//        pageView.backgroundColor=WBArc4random;

        //把每页要显示的多少的子数组截出来
        NSRange rang;
        rang.location=i*EmojiPageNum;
        NSUInteger num=emotionArr.count-rang.location;
        if (num>=EmojiPageNum)
        {
            rang.length=EmojiPageNum;
        }
        else {
            rang.length=num;
        }
        pageView.emojiArr=[emotionArr subarrayWithRange:rang];
    }
    
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat pageX=0;
    CGFloat pageW=self.width;
    CGFloat pageH=25;
    CGFloat pageY=self.height-pageH;
    self.pageControl.frame=CGRectMake(pageX, pageY, pageW, pageH);
    
    CGFloat scrollX=0;
    CGFloat scrollW=self.width;
    CGFloat scrollY=0;
    CGFloat scrollH=self.height-pageH;
    self.scrollView.frame=CGRectMake(scrollX, scrollY, scrollW, scrollH);
    
    //表情父级视图frame
    
    CGFloat pageViewY=0;
    CGFloat pageViewW=self.scrollView.width;
    CGFloat pageViewH=self.scrollView.height;
    NSUInteger count=self.scrollView.subviews.count;
    for (int i=0; i<count; i++) {
        UIView *view=self.scrollView.subviews[i];
        view.frame=CGRectMake(pageViewW*i, pageViewY, pageViewW, pageViewH);
    }
    self.scrollView.contentSize=CGSizeMake(self.scrollView.width*count, self.scrollView.height);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page=self.scrollView.contentOffset.x/self.scrollView.width;
    self.pageControl.currentPage=(int)(page+0.5);
    
}

@end
