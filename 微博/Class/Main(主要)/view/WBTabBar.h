//
//  WBTabBar.h
//  微博
//
//  Created by llairen on 15/11/4.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBar;


@protocol WBTabBarDelegate <UITabBarDelegate>
@optional
-(void)tabBarDidPlusBtn:(WBTabBar *)tabBar;
@end

@interface WBTabBar : UITabBar
@property (nonatomic, weak)id <WBTabBarDelegate> delegate;
@end
