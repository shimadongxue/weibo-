//
//  StatusFrame.m
//  微博
//
//  Created by 赵武灵王 on 15/11/15.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "StatusFrame.h"
#import "WBUser.h"
#import "StatuesPhotosView.h"
#import "NSString+Extension.h"
#define StatusCellBorderW 10
@implementation StatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    WBUser *user = status.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /* 原创微博 */
    
    /** 头像 */
    CGFloat iconWH = 40;
    CGFloat iconX = StatusCellBorderW;
    CGFloat iconY = StatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + StatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.screen_name font:StatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    /** 会员图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + StatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + StatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFont:StatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + StatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:StatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + StatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text font:StatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    
    /** 原创微博整体的高 */
    CGFloat originalH=0;
    
    /** 配图 */
    if (status.pic_urls.count)
    {
        CGFloat photosViewX=contentX;
        CGFloat photosViewY=CGRectGetMaxY(self.contentLabelF)+StatusCellBorderW;
        CGSize photosSize=[StatuesPhotosView sizeWithCount:(int)status.pic_urls.count];
        self.photosViewF=(CGRect){{photosViewX, photosViewY}, photosSize};

        originalH = CGRectGetMaxY(self.photosViewF) + StatusCellBorderW;
    }
    else
    {
        originalH = CGRectGetMaxY(self.contentLabelF) + StatusCellBorderW;
    }
    
    
//    @property (assign, nonatomic) CGRect photoViewF;?
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = StatusCellBorderW;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    CGFloat ToolBarY=0;
    
    if (status.retweeted_status)
    {
        
        /** 被转发retweeted_status*/

        WBStatus *retweeted_status=status.retweeted_status;
        /** 被转发user*/
        WBUser * retweeted_user=retweeted_status.user;
         /** 被转发正文frame*/
        CGFloat retweetedContentX = StatusCellBorderW;
        CGFloat retweetedContentY = StatusCellBorderW;
        /** 被转发正文TEXT*/
        CGFloat maxW=cellW-2*retweetedContentX;
        NSString * retweeteText=[NSString stringWithFormat:@"@%@:%@",retweeted_user.screen_name,retweeted_status.text];
        
        CGSize retweetedSize = [self sizeWithText:retweeteText font:RetweetedStatusContentFont maxW:maxW];
        self.retweetedContentF = (CGRect){{retweetedContentX, retweetedContentY}, retweetedSize};
        
        /**被转发整体高*/
        CGFloat retweetedViewH=0;
        
        /**被转发图片*/
        if (retweeted_status.pic_urls.count)
        {
            CGFloat retweetedPhotosX=retweetedContentX;
            CGFloat retweetedPhotosY=CGRectGetMaxY(self.retweetedContentF)+StatusCellBorderW;
            CGSize PhotoSize=[StatuesPhotosView sizeWithCount:(int)retweeted_status.pic_urls.count];
            self.retweetedPhotosF=(CGRect){{retweetedPhotosX, retweetedPhotosY}, PhotoSize};
            
            retweetedViewH = CGRectGetMaxY(self.retweetedPhotosF) + StatusCellBorderW;
        }
        else
        {
            retweetedViewH = CGRectGetMaxY(self.retweetedContentF) + StatusCellBorderW;
        }
        CGFloat retweetedViewX=0;
        CGFloat retweetedViewY=CGRectGetMaxY(self.originalViewF);
        CGFloat retweetedViewW=cellW;
        self.retweetedViewF=CGRectMake(retweetedViewX, retweetedViewY, retweetedViewW, retweetedViewH);
        ToolBarY=CGRectGetMaxY(self.retweetedViewF);
    }
    else
    {
       ToolBarY = CGRectGetMaxY(self.originalViewF);
    }
    
    CGFloat ToolBarX=0;
    
    CGFloat ToolBarW=cellW;
    CGFloat ToolBarH=35;
    self.ToolBarF=CGRectMake(ToolBarX, ToolBarY, ToolBarW, ToolBarH);
    self.cellHeight=CGRectGetMaxY(self.ToolBarF);
}

@end
