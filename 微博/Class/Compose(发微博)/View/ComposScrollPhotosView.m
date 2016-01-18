//
//  ComposScrollPhotosView.m
//  个人客户端
//
//  Created by llairen on 15/12/16.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "ComposScrollPhotosView.h"

@implementation ComposScrollPhotosView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
       
        
//        self.backgroundColor=[UIColor redColor];
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        _photosArray=[NSMutableArray array];
//
    }
    return self;
}


/**添加图片的方法*/
-(void)addPhoto:(UIImage *)photo
{
    UIImageView * PhotosView=[[UIImageView alloc]init];
    PhotosView.image=photo;
    [self addSubview:PhotosView];
//    PhotosView.userInteractionEnabled=YES;
    [self.photosArray addObject:photo];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int count= (int)self.subviews.count;
    CGFloat imageY=0;
    CGFloat imageWH=self.height;
    for (int i=0;i<count;i++)
    {
        UIImageView *imageView=self.subviews[i];
        imageView.x = (2+imageWH)*i+2;
        imageView.y = imageY;
        imageView.width =imageWH;
        imageView.height =imageWH;
        
    }
    self.contentSize=CGSizeMake(self.photosArray.count*80, 80);
    
    
}
@end
