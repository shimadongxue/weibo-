//
//  WBSearchBar.h
//  微博
//
//  Created by llairen on 15/11/6.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBSearchBar : UITextField
+(instancetype)searchBar;
@property (nonatomic, strong)NSString *placeholdeName;
@end
