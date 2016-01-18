//
//  StatuesPtoto.m
//  微博
//
//  Created by 赵武灵王 on 15/11/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "StatuesPtoto.h"

@interface StatuesPtoto ()
@property (weak ,nonatomic)UIImageView * gitPhoto;

@end
@implementation StatuesPtoto

-(UIImageView *)gitPhoto
{
    if (_gitPhoto==nil)
    {
        UIImage * image=[UIImage imageNamed:@"timeline_image_gif"];
        UIImageView * gitImage=[[UIImageView alloc]initWithImage:image];
        [self addSubview:gitImage];
        self.gitPhoto=gitImage;
    }
    return _gitPhoto;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor redColor];
//        UIViewContentModeScaleToFill,
//        UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
//        UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//        UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
//        UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
//        UIViewContentModeTop,
//        UIViewContentModeBottom,
//        UIViewContentModeLeft,
//        UIViewContentModeRight,
//        UIViewContentModeTopLeft,
//        UIViewContentModeTopRight,
//        UIViewContentModeBottomLeft,
//        UIViewContentModeBottomRight,
        self.userInteractionEnabled=YES;
//        self.contentMode=UIViewContentModeScaleToFill;  //内容全放进行去后缩放；
//        self.contentMode=UIViewContentModeScaleAspectFit;//缩放后适应
        self.contentMode=UIViewContentModeScaleAspectFill;
//        self.contentMode=UIViewContentModeScaleAspectFit;   //长图
        
        self.clipsToBounds=YES;
    }
    return self;
}
-(void)setPhoto:(PhotoMode *)photo
{
    _photo=photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gitPhoto.hidden=![photo.thumbnail_pic.lowercaseString hasSuffix:@"git"];
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gitPhoto.x=self.width-self.gitPhoto.width;
    self.gitPhoto.y=self.height-self.gitPhoto.height;
}
@end
