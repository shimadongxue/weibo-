//
//  StatuesPhotosView.m
//  微博
//
//  Created by 赵武灵王 on 15/11/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "StatuesPhotosView.h"
#import "PhotoMode.h"
#import "StatuesPtoto.h"


#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

#define PhotosViewMaxW [UIScreen mainScreen].bounds.size.width-20

#define PhotoMargin 10
#define PhotoWH 90
#define PhotoCol(count) ((count==4)?2:3)
@implementation StatuesPhotosView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}


-(void)setPhotos:(NSArray *)photos
{
    _photos=photos;
    
    int photoCount=(int)photos.count;
    
    while (self.subviews.count<photoCount) {
        StatuesPtoto * creatView=[[StatuesPtoto alloc]init];
        [self addSubview:creatView];
        
    }
    for (int i=0;i<self.subviews.count;i++)
    {
        StatuesPtoto * photoView=self.subviews[i];
        
        if (i<photos.count)
        {
            photoView.hidden=NO;
            photoView.photo=photos[i];
        }
        else
        {
            photoView.hidden=YES;
        }
        photoView.tag=i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
        [photoView addGestureRecognizer:tap];
    }
}




-(void)tapImage:(UITapGestureRecognizer *)tap
{
    
    
    int count=(int)self.photos.count;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        PhotoMode * img=self.photos[i];
        NSString *url = [img.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
+(CGSize)sizeWithCount:(int)count
{
    int maxCol=PhotoCol(count);
    CGFloat photosViewW=0;
    int cols=(count>=maxCol)?maxCol:count;
   
    photosViewW=cols*PhotoWH +(cols-1)*PhotoMargin;
   
    CGFloat photosViewH=0;
    int row=(count+maxCol-1)/maxCol;
    photosViewH=PhotoWH*row +(row-1)*PhotoMargin;
    
    return CGSizeMake(photosViewW, photosViewH);
}
-(void)layoutSubviews
{
    [super subviews];
    int count=(int)self.photos.count;
    
    int maxCol=PhotoCol(count);
    for (int i=0;i<self.photos.count;i++)
    {
        StatuesPtoto * imageView=self.subviews[i];
        
        int col=i % maxCol;
        imageView.x=col * (PhotoWH+PhotoMargin);
        
        int row=i / maxCol;
        imageView.y=row *(PhotoWH +PhotoMargin);
        imageView.width=PhotoWH;
        imageView.height=PhotoWH;
    }
}
@end
