//
//  StatuesTableViewCell.m
//  微博
//
//  Created by 赵武灵王 on 15/11/15.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "StatuesTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PhotoMode.h"
#import "StatueToolBar.h"
#import "StatuesPhotosView.h"
#import "NSString+Extension.h"
@interface StatuesTableViewCell ()
/** 原创整体*/
@property (weak, nonatomic) UIView *originalView;

/** 头像*/
@property (weak, nonatomic) UIImageView *iconView;
/** vip像*/
@property (weak, nonatomic) UIImageView *vipView;
/** 配头*/
@property (weak, nonatomic) StatuesPhotosView *photoView;

/** 昵称*/
@property (weak, nonatomic) UILabel *nameLabel;
/** 时间*/
@property (weak, nonatomic) UILabel *timeLabel;
/** 来源*/
@property (weak, nonatomic) UILabel *sourceLabel;
/** 正文*/
@property (weak, nonatomic) UILabel *contentLabel;

/** 被转发微博整体*/
@property (weak, nonatomic) UIView *retweetedView;

/** 被转发微博正文*/
@property (weak, nonatomic) UILabel *retweetedContent;

/** 被转发微博配头*/
@property (weak, nonatomic) StatuesPhotosView *retweetedPhoto;

/** 工具条*/
@property (weak, nonatomic) StatueToolBar *ToolBar;

@end



@implementation StatuesTableViewCell

+(instancetype)statuesTabView:(UITableView *)tabView
{
    static NSString * str=@"cell";
    StatuesTableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:str];
    
    if (cell==nil)
    {
        cell=[[StatuesTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        /** 原创微博初始化*/
        [self originalStatues];
        
        /** 被转发微博初始化*/
        [self retweetedStatues];
        
         /** 工具条初始化*/
        [self setToolBar];
    }
    return self;
}

-(void)setToolBar
{
    StatueToolBar * toolBar=[StatueToolBar statueToolBar];
    [self.contentView addSubview:toolBar];
    self.ToolBar=toolBar;
}
/** 被转发微博初始化*/
-(void)retweetedStatues
{
    /** 被转发微博整体*/
    UIView *retweetedView=[[UIView alloc]init];
    [self.contentView addSubview:retweetedView];
    retweetedView.backgroundColor=WBColor(245, 245, 245, 1);
    
//    retweetedView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_retweet_background"]];
    self.retweetedView=retweetedView;
    
    /** 被转发微博正文*/
    UILabel *retweetedContent=[[UILabel alloc]init];
    retweetedContent.numberOfLines=0;
    retweetedContent.font=RetweetedStatusContentFont;
    [self.retweetedView addSubview:retweetedContent];
    self.retweetedContent=retweetedContent;
    
    /** 被转发微博配头*/
    StatuesPhotosView  *retweetedPhoto=[[StatuesPhotosView alloc]init];
    [self.retweetedView addSubview:retweetedPhoto];
    self.retweetedPhoto=retweetedPhoto;
}
/** 原创微博初始化*/
-(void)originalStatues
{
    /** 原创整体*/
    UIView *originalView=[[UIView alloc]init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor=[UIColor whiteColor];
    self.originalView=originalView;
    
    /** 头像*/
    UIImageView *iconView=[[UIImageView alloc]init];
    [self.originalView addSubview:iconView];
    self.iconView=iconView;
    /** Vip像*/
    UIImageView *vipView=[[UIImageView alloc]init];
    [self.originalView addSubview:vipView];
    vipView.contentMode=UIViewContentModeCenter;
    self.vipView=vipView;
    /** 配头*/
    StatuesPhotosView *photoView=[[StatuesPhotosView alloc]init];
    [self.originalView addSubview:photoView];
    self.photoView=photoView;
    
    /** 昵称*/
    UILabel *nameLabel=[[UILabel alloc]init];
    [self.originalView addSubview:nameLabel];
    nameLabel.font=StatusCellNameFont;
    self.nameLabel=nameLabel;
    /** 时间*/
    UILabel *timeLabel=[[UILabel alloc]init];
    [self.originalView addSubview:timeLabel];
    timeLabel.font=StatusCellTimeFont;
    timeLabel.textColor=[UIColor orangeColor];
    self.timeLabel=timeLabel;
    /** 来源*/
    UILabel *sourceLabel=[[UILabel alloc]init];
    [self.originalView addSubview:sourceLabel];
    sourceLabel.font=StatusCellSourceFont;
    self.sourceLabel=sourceLabel;
    /** 正文*/
    UILabel *contentLabel=[[UILabel alloc]init];
    contentLabel.numberOfLines=0;
    [self.originalView addSubview:contentLabel];
    contentLabel.font=StatusCellContentFont;
    self.contentLabel=contentLabel;
}
- (void)setStatusFrame:(StatusFrame * )statusFrame
{
    _statusFrame = statusFrame;
    
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
   
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /** 会员图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 昵称 */
    self.nameLabel.text = user.screen_name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + 10;
    CGSize timeSize = [time sizeWithFont:StatusCellTimeFont];
    self.timeLabel.text = status.created_at;
    
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame)+10;
    CGFloat sourceY = timeY;
    CGSize size = [status.source sizeWithFont:StatusCellSourceFont];
    self.sourceLabel.frame=(CGRect){{sourceX, sourceY}, size};
    self.sourceLabel.text = status.source;
    /** 正文 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    /** 配图 */
    if (status.pic_urls.count)
    {
        self.photoView.hidden=NO;
        self.photoView.frame = statusFrame.photosViewF;
        self.photoView.photos=status.pic_urls;

//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
    else
    {
        self.photoView.hidden=YES;
    }
    
    /**被转化  */
    if (status.retweeted_status)
    {
        self.retweetedView.hidden=NO;
        /**被转发微博  */
        WBStatus *retweeted_status=status.retweeted_status;
        /**被转发用户  */
        WBUser * retweeted_user=retweeted_status.user;
        /**被转整体frame  */
        self.retweetedView.frame=statusFrame.retweetedViewF;
        /**被转正文  */
        self.retweetedContent.frame=statusFrame.retweetedContentF;
        NSString * retweeted_text=[NSString stringWithFormat:@"@%@:%@",retweeted_user.screen_name,retweeted_status.text];
        self.retweetedContent.text=retweeted_text;
        
        /**被转图片  */
        if (retweeted_status.pic_urls.count)
        {
            self.retweetedPhoto.hidden=NO;
            self.retweetedPhoto.frame=statusFrame.retweetedPhotosF;
            /**被转图片url  */
            self.retweetedPhoto.photos=retweeted_status.pic_urls;

        }
        else
        {
            self.retweetedPhoto.hidden=YES;
        }
    }
    else{
        self.retweetedView.hidden=YES;
    }
    self.ToolBar.frame=statusFrame.ToolBarF;
    self.ToolBar.status=statusFrame.status;
}


@end
