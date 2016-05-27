//
//  BlogsViewController.m
//  mine
//
//  Created by Shuwei on 16/5/26.
//  Copyright © 2016年 jov. All rights reserved.
//

#import "BlogsViewController.h"

@interface BlogsViewController ()

@end

@implementation BlogsViewController{
    NSMutableArray *list;
    DBHelper *db;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![Common isEmptyString:[ShareData shareInstance].title]){
        self.title=[ShareData shareInstance].title;
    }else{
        self.title=@"攻略大全";
    }
    list =  [[NSMutableArray alloc] init];
    db = [DBHelper sharedInstance];
    list = [db getBlogsByType:[ShareData shareInstance].type];
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.view.backgroundColor=[Common colorWithHexString:@"e0e0e0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell    *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    cell.backgroundColor = [UIColor whiteColor];
    DataBean *bean=[list objectAtIndex:indexPath.row];
    cell.textLabel.text=bean.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    DataBean *bean=[list objectAtIndex:indexPath.row];
    WebController *show = [[WebController alloc] init];
    [ShareData shareInstance].html=bean.ref;
    [ShareData shareInstance].urltype=nil;
    show.title=bean.name;
    [self.navigationController pushViewController:show animated:YES];
}

@end
