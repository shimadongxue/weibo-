//
//  WBSearchBar.m
//  微博
//
//  Created by llairen on 15/11/6.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        //
        self.font=[UIFont systemFontOfSize:12];
        self.background=[UIImage imageNamed:@"searchbar_textfield_background"];
        UIImageView *searchIcon=[[UIImageView alloc]init];
        searchIcon.image=[UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.contentMode=UIViewContentModeCenter;
        searchIcon.width=30;
        searchIcon.height=30;
        self.leftView=searchIcon;
        
        self.leftViewMode=UITextFieldViewModeAlways;
    }
    return self;
    
}
-(void)setPlaceholdeName:(NSString *)placeholdeName
{
    _placeholdeName=placeholdeName;
    self.placeholder=[NSString stringWithFormat:@"大家都在搜: %@",placeholdeName];;
}
+(instancetype)searchBar
{
    return [[self alloc]init];
}
@end
