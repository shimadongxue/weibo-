//
//  ComposScrollPhotosView.h
//  个人客户端
//
//  Created by llairen on 15/12/16.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposScrollPhotosView : UIScrollView

/** 添加图片*/
-(void)addPhoto:(UIImage *)photo;


/**只读的存放图片的数组*/
@property (nonatomic, strong,readonly)NSMutableArray *photosArray;
@end
