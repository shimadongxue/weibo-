//
//  MessageTableViewController.m
//  微博
//
//  Created by llairen on 15/10/8.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "MessageTableViewController.h"
#import "TestViewController.h"
@interface MessageTableViewController ()

@end

@implementation MessageTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(writeLetter)];
    
}


-(void)writeLetter
{
    NSLog(@"写私信！");
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"test-message-%ld",(long)indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewController * test=[[TestViewController alloc]init];
    [self.navigationController pushViewController:test animated:YES];
}
@end
