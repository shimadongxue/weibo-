//
//  HomeTableViewController.m
//  微博
//
//  Created by llairen on 15/10/8.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "HomeTableViewController.h"
#import "WBNavViewController.h"
#import "MenuTableViewController.h"
#import "WBDropView.h"
#import "WBAccountTool.h"
#import "WBTittleNavButton.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "StatusFrame.h"
#import "StatuesTableViewCell.h"
#import "StatuesPhotosView.h"
#import "HomeStatusTool.h"
#import "UserTool.h"
#import "TestViewController.h"
@interface HomeTableViewController ()<WBDropViewDelegate>






@property (nonatomic, strong)NSMutableArray *statuses;

@property (nonatomic, weak) MJRefreshNormalHeader *header;
@property (nonatomic, weak)MJRefreshAutoNormalFooter *footer;
@end

@implementation HomeTableViewController

-(NSMutableArray *)statuses
{
    if (_statuses==nil)
    {
        _statuses=[NSMutableArray array];
    }
    return _statuses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=WBColor(211, 211, 211, 1);
 
    [self setNavBarButton];
//    self.tableView.backgroundColor=[UIColor grayColor];
       //用户数据
    [self setUserData];
    //加载微博数据
//    [self setStatusData];
    //下拉刷新
    [self setUpRefresh];
    //上拉加载
    [self setUpPush];
    //导航按钮
    
    //最新微博未读数
    NSTimer * time=[NSTimer timerWithTimeInterval:60 target:self selector:@selector(warnRead) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:time forMode:NSRunLoopCommonModes];
    
    
   
}


/**最新微博未读数*/
-(void)warnRead
{
//    /* 获取某个用户的各种消息未读数
//      url https://rm.api.weibo.com/2/remind/unread_count.json
//     
//     access_token	采用OAuth授权方式为必填参数，
//     uid		需要获取消息未读数的用户UID，
//     */
//    WBAccount *account=[WBAccountTool account];
//    HomeStatusParmaModel * parma=[[HomeStatusParmaModel alloc]init];
//    parame[@"access_token"]=account.access_token;
//    parame[@"uid"]=account.uid;
//    [HttpTool getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" parmar:parame success:^(id json) {
//        NSString * warnNum=[json[@"status"] description];
//        if ([warnNum isEqualToString:@"0"])
//        {
//            self.tabBarItem.badgeValue=nil;
//            [UIApplication sharedApplication].applicationIconBadgeNumber=0;
//        }
//        else
//        {
//            self.tabBarItem.badgeValue=warnNum;
//            
//            [UIApplication sharedApplication].applicationIconBadgeNumber=warnNum.intValue;
//        }
//    } failure:^(NSError *error) {
//         NSLog(@"微博请求数据失败");
//    }];
    
}
/**下拉刷新*/
-(void)setUpRefresh
{
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setStatusData)];
 /*    普通闲置状态
    MJRefreshStateIdle = 1,
    松开就可以进行刷新的状态
    MJRefreshStatePulling,
     正在刷新中的状态
    MJRefreshStateRefreshing,
     即将刷新的状态
    MJRefreshStateWillRefresh,
    所有数据加载完毕，没有更多的数据了
    MJRefreshStateNoMoreData*/
    [header setTitle:@"下拉刷新微博" forState:MJRefreshStateIdle];
    [header setTitle:@"松开就可以进行刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    header.stateLabel.font=[UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font=[UIFont systemFontOfSize:14];
    header.stateLabel.textColor=[UIColor redColor];
    header.lastUpdatedTimeLabel.textColor=[UIColor grayColor];
    [header beginRefreshing];
    self.tableView.mj_header=header;
    self.header=header;
}
/**下拉刷新*/
-(void)setUpPush
{
    MJRefreshAutoNormalFooter * footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松手就可以加载更多" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer=footer;
    self.footer=footer;
    
}
/**上拉加载更多木微博数据*/
-(void)loadMoreData
{
    //https://api.weibo.com/2/statuses/friends_timeline.json  微博数据接口
  
    
    //取出一个帐号
    [self.footer beginRefreshing];
    WBAccount *account=[WBAccountTool account];
    //取出刷新比since_id大的微博的since_id
    StatusFrame *statuF=[self.statuses lastObject];
    WBStatus * statues=statuF.status;
   
    HomeStatusParmaModel * parma=[[HomeStatusParmaModel alloc]init];
    parma.access_token=account.access_token;
    parma.count=@10;
    if (statues)
    {
//        long long maxId= statues.idstr.longLongValue-1;
        parma.max_id=@([statues.idstr longLongValue]-1);
    }
    [HomeStatusTool homeGetWithParma:parma succes:^(HomeResultModel *result) {
        NSArray * arr=result.statuses;
        NSArray * newArr=[self statusesFrameWith:arr];
        [self.statuses addObjectsFromArray:newArr];
                //结束刷新
        [self.footer endRefreshing];
                //刷新表视图
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"加载更多微博数据失败"];
        [self.footer endRefreshing];

    }];
}
/**加载最终新微博数据*/
-(void)setStatusData
{
    //https://api.weibo.com/2/statuses/friends_timeline.json  微博数据接口
       //取出一个帐号
    WBAccount *account=[WBAccountTool account];
    //取出刷新比since_id大的微博的since_id
    StatusFrame *statuF=[self.statuses firstObject];
    WBStatus * statues=statuF.status;
    
    HomeStatusParmaModel * parma=[[HomeStatusParmaModel alloc]init];
    parma.access_token=account.access_token;
    parma.count=@10;
    if (statues)
    {
        
        parma.since_id=@([statues.idstr longLongValue]);
    }
    [HomeStatusTool homeGetWithParma:parma succes:^(HomeResultModel *result) {
        
        //把新微博插入微博数组
        NSArray * arr=result.statuses;
        NSArray * newArr=[self statusesFrameWith:arr];
        NSRange rang=NSMakeRange(0, newArr.count);
        NSIndexSet * set=[NSIndexSet indexSetWithIndexesInRange:rang];
        [self.statuses insertObjects:newArr atIndexes:set];
        //结束刷新
        [self.header endRefreshing];
        //刷新表视图
        [self.tableView reloadData];
        //检查是否需要把tabBarItem的badgeValue清空。
        [self warnRead];
        //添加最新微博label
        [self showNewStatuses:(int)arr.count];

    } failure:^(NSError *error) {
        [self.header endRefreshing];
        [MBProgressHUD showError:@"加载最新微博数据失败"];
    }];

    }
-(NSArray *)statusesFrameWith:(NSArray *)statusArr
{
    
    NSMutableArray * arr=[NSMutableArray array];
    for (WBStatus * status in statusArr)
    {
        StatusFrame * frame=[[StatusFrame alloc]init];
        frame.status=status;
        [arr addObject:frame];
    }
    return arr;
}
/**最新微博的数量*/
-(void)showNewStatuses:(int)count
{
    
   //创建提示最新微博label
    UILabel * newLabel=[[UILabel alloc]init];
    newLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    //最亲微博label的frame
    CGFloat x=0;
    CGFloat h=35;
    CGFloat y=64-h;
    CGFloat w=self.view.frame.size.width;
    newLabel.frame=CGRectMake(x, y, w, h);
    newLabel.textAlignment=NSTextAlignmentCenter;
    newLabel.textColor=[UIColor whiteColor];
    newLabel.font=[UIFont systemFontOfSize:16];
    
    if (count!=0)
    {
        newLabel.text=[NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    else
    {
        newLabel.text=@"没有新的微博数据，稍后再试";
    }
    //把label加入到nav上
    [self.navigationController.view insertSubview:newLabel belowSubview:self.navigationController.navigationBar];
    CGFloat duration=1;
    [UIView animateWithDuration:duration animations:^{
        newLabel.transform=CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:duration options:UIViewAnimationOptionCurveLinear animations:^{
            newLabel.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [newLabel removeFromSuperview];
        }];
    }];
   
    
}
/**加载微博的用户*/
-(void)setUserData
{
    //根据用户ID获取用户信息 get
    // access_token
    // uid
    //https://api.weibo.com/2/users/show.json
    WBAccount * account=[WBAccountTool account];
   
    UserParmaModel * parma=[[UserParmaModel alloc]init];
    parma.uid=@([[WBAccountTool account].uid longLongValue]);
    parma.access_token=[WBAccountTool account].access_token;
    [UserTool userInfoWithParma:parma success:^(UserResultModel *result) {
        WBUser *user=result;
        WBTittleNavButton *button=(WBTittleNavButton *)self.navigationItem.titleView;
        [button setTitle:user.screen_name forState:UIControlStateNormal];
                //
        account.name=user.screen_name;
        [WBAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求用户失败"];
    }];
}
//导航按钮
-(void)setNavBarButton
{
    //左边导航按钮
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    //右边导航按钮
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    //中间导航按钮
    WBAccount * account=[WBAccountTool account];
    NSString * name=account.name;
    WBTittleNavButton * titleNavBtn=[[WBTittleNavButton alloc]init];
    [titleNavBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];

    
    [titleNavBtn addTarget:self action:@selector(titleNavButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleNavBtn sizeToFit];
    self.navigationItem.titleView=titleNavBtn;
}
-(void)titleNavButtonClick:(UIButton *)button
{
    //首页按钮View
    WBDropView * menu=[WBDropView menu];
    menu.delegate=self;
    MenuTableViewController *vc=[[MenuTableViewController alloc]init];
    vc.view.height=100;
    vc.view.width=100;
    
    menu.contentController=vc;

    [menu showFrom:button];
}
-(void)friendSearch
{
    TestViewController * test=[[TestViewController alloc]init];
    test.titleName=@"好友关注动态";
    [self.navigationController pushViewController:test animated:YES];
}
-(void)pop
{
    TestViewController * test=[[TestViewController alloc]init];
    test.titleName=@"扫一扫";
    [self.navigationController pushViewController:test animated:YES];
}

-(void)dropMenuViewDidShow:(WBDropView *)menu
{
    UIButton * btn=(UIButton *)self.navigationItem.titleView;
    btn.selected=YES;
}
-(void)dropDismissMenuView:(WBDropView *)menu
{
    UIButton * btn=(UIButton *)self.navigationItem.titleView;
    btn.selected=NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatuesTableViewCell * cell=[StatuesTableViewCell statuesTabView:tableView];
    cell.statusFrame=self.statuses[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame * frame=self.statuses[indexPath.row];
    return frame.cellHeight;
}

@end
