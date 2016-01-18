//
//  StatuesTableViewCell.h
//  微博
//
//  Created by 赵武灵王 on 15/11/15.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusFrame.h"
@interface StatuesTableViewCell : UITableViewCell


@property (strong, nonatomic) StatusFrame *statusFrame;

+(instancetype)statuesTabView:(UITableView *)tabView;


@end
