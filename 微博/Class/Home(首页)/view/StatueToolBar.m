//
//  StatueToolBar.m
//  微博
//
//  Created by llairen on 15/11/20.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "StatueToolBar.h"



@interface StatueToolBar ()
@property (nonatomic, strong)NSMutableArray *btnArray;
@property (nonatomic, strong)NSMutableArray *lineArray;


/**  转发 */
@property (nonatomic, weak)UIButton *retweet;
/**  评论 */
@property (nonatomic, weak)UIButton *comment;
/**  赞 */
@property (nonatomic, weak)UIButton *unlike;
@end
@implementation StatueToolBar

-(NSMutableArray *)btnArray
{
    if (!_btnArray)
    {
        _btnArray=[NSMutableArray array];
    }
    return _btnArray;
}
-(NSMutableArray *)lineArray
{
    if (!_lineArray)
    {
        _lineArray=[NSMutableArray array];
    }
    return _lineArray;
}

+(instancetype)statueToolBar
{
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
//        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"]];
        
        self.backgroundColor=WBColor(254, 254, 254, 1);
        self.retweet=[self setTitle:@"转发" icon:@"timeline_icon_retweet" ];
        self.comment=[self setTitle:@"评论" icon:@"timeline_icon_comment" ];
        self.unlike=[self setTitle:@"赞" icon:@"timeline_icon_unlike" ];
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}
-(void)setupDivider
{
    UIImageView * divier=[[UIImageView alloc]init];
    divier.image=[UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divier];
    [self.lineArray addObject:divier];
}
-(UIButton *)setTitle:(NSString *)title icon:(NSString *)icon
{
    UIButton * button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:13];
//    [button setImage:[UIImage :bgImg] forState:UIControlStateHighlighted];
    button.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    [self addSubview:button];
    [self.btnArray addObject:button];
    button.adjustsImageWhenHighlighted=YES;
    return button;
}

-(void)setStatus:(WBStatus *)status
{
    _status=status;
    [self setCount:status.reposts_count setBtn:self.retweet setTitle:@"转发" ];
    [self setCount:status.comments_count setBtn:self.comment setTitle:@"评论" ];
    [self setCount:status.attitudes_count setBtn:self.unlike setTitle:@"赞" ];
}
-(void)setCount:(int )count setBtn:(UIButton *)btn setTitle:(NSString *)title
{
    if (count)
    {
        if (count<10000)
        {
            title=[NSString stringWithFormat:@"%d",count];
        }
        else
        {
            double num=count/10000.0;
            title=[NSString stringWithFormat:@"%0.1f万",num];
            title=[title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    long dividerCount=self.lineArray.count;
    long count =self.btnArray.count;
    
    
    CGFloat lineW=1;
    CGFloat BtnW=(self.width-lineW*dividerCount)/count;
    CGFloat BtnH=self.height;
    CGFloat BtnY=0;
    for (int i=0;i<count;i++)
    {
        UIButton * btn=self.btnArray[i];
        btn.x=i*(BtnW+1);
        btn.y=BtnY;
        btn.width=BtnW;
        btn.height=BtnH;
        
    }
    
    CGFloat lineY=0;
    CGFloat lineH=self.height;
    for(int j=0;j<dividerCount;j++)
    {
        UIImageView *lineView=self.lineArray[j];
        UIButton * button=self.btnArray[j];
        
        CGFloat lineX=CGRectGetMaxX(button.frame);
        lineView.frame=CGRectMake(lineX, lineY, lineW, lineH);
        
    }
}
@end
