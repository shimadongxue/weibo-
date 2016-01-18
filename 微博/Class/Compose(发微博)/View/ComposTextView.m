//
//  ComposTextView.m
//  微博
//
//  Created by llairen on 15/11/30.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "ComposTextView.h"



@interface ComposTextView ()
@property(nonatomic,weak)UILabel * placeLabel;

@end
@implementation ComposTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        UILabel * placeLabel=[[UILabel alloc]init];
        placeLabel.textColor=[UIColor lightGrayColor];
//        placeLabel.backgroundColor=[UIColor redColor];
        [self insertSubview:placeLabel atIndex:0];
        placeLabel.numberOfLines=0;
        self.placeLabel=placeLabel;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeText) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self changeText];
}

-(void)changeText
{
    self.placeLabel.hidden=self.hasText;
}

-(void)setPlacehoderStr:(NSString *)placehoderStr
{
    _placehoderStr=placehoderStr;
    
    self.placeLabel.text=placehoderStr;
    NSMutableDictionary * attr=[NSMutableDictionary dictionary];
    attr[NSFontAttributeName]=self.font;
    attr[NSForegroundColorAttributeName]=self.phaceColor;
    CGFloat placeX=5;
    CGFloat placeY=8;
//    CGFloat placeW=150;
//    CGFloat placeH=20;
    CGSize size=[self.placehoderStr sizeWithAttributes:attr];
    self.placeLabel.frame=(CGRect){{placeX,placeY},{size.width+30,size.height}};
}
-(void)setPhaceColor:(UIColor *)phaceColor
{
    _phaceColor=phaceColor;
    self.placeLabel.textColor=phaceColor;
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeLabel.font=font;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//}
@end
