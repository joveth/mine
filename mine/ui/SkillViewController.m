//
//  SkillViewController.m
//  mine
//
//  Created by Shuwei on 16/5/26.
//  Copyright © 2016年 jov. All rights reserved.
//

#import "SkillViewController.h"

@interface SkillViewController ()

@end

@implementation SkillViewController{
    MBProgressHUD *hud;
    NSMutableArray *list;
    DBHelper *db;
    CGFloat width;
    BOOL flag;
    UISearchController *searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"加载中...";
    [hud show:YES];
    db = [DBHelper sharedInstance];
    self.title=@"技能图鉴";
    
    
    list = [[NSMutableArray alloc] init];
    width = [UIScreen mainScreen].applicationFrame.size.width;
    self.tableView.tableFooterView=[[UIView alloc] init];
    searchController= [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = YES;
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchBar.frame = CGRectMake(searchController.searchBar.frame.origin.x,searchController.searchBar.frame.origin.y, searchController.searchBar.frame.size.width, 44.0);
    searchController.searchBar.placeholder=@"搜索";
    self.tableView.tableHeaderView = searchController.searchBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self load];
}
-(void)load{
    if([db openDB]){
        list = [db getSkills];
        [self.tableView reloadData];
    }
    [hud hide:YES];
}
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
    
    UILabel *nameLabel =(UILabel*)[cell viewWithTag:1];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:3];
    UILabel *tagLabel=(UILabel*)[cell viewWithTag:4];
    UILabel *tag3=(UILabel*)[cell viewWithTag:5];
    if(nameLabel==nil){
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 4, width, 22)];
        nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
        nameLabel.numberOfLines=0;
        nameLabel.tag=1;
        nameLabel.textColor=[Common colorWithHexString:@"ea8010"];
        [cell addSubview:nameLabel];
    }
    
    if(contentLabel==nil){
        contentLabel = [[UILabel alloc] init];
        contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
        contentLabel.numberOfLines=0;
        contentLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        contentLabel.tag=3;
        [cell addSubview:contentLabel];
    }
    if(tagLabel==nil){
        tagLabel = [[UILabel alloc] init];
        tagLabel.lineBreakMode=NSLineBreakByWordWrapping;
        tagLabel.numberOfLines=0;
        tagLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        tagLabel.tag=4;
        [cell addSubview:tagLabel];
    }
    if(tag3==nil){
        tag3 = [[UILabel alloc] init];
        tag3.lineBreakMode=NSLineBreakByWordWrapping;
        tag3.numberOfLines=0;
        tag3.font = [UIFont fontWithName:@"Arial" size:12.0f];
        tag3.tag=5;
        [cell addSubview:tag3];
    }
    
    DataBean *bean = [list objectAtIndex:indexPath.row];
    
    if(bean){
        nameLabel.text = [NSString stringWithFormat:@"%@",bean.name];
        
        contentLabel.frame=CGRectMake(5, 30, width, 20);
        contentLabel.text = [NSString stringWithFormat:@"所属英雄:%@",bean.belong];
        tagLabel.frame=CGRectMake(5, 54, width, 20);
        tagLabel.text = [NSString stringWithFormat:@"伤害类型:%@,伤害倍率:%@,发动概率:%@",bean.hurt,bean.hurtrate,bean.rate];
        
        tag3.text = [NSString stringWithFormat:@"描述:%@",bean.desc];
        CGSize size = [tag3.text sizeWithFont:[UIFont fontWithName:@"Arial" size:12.0f] constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        tag3.frame=CGRectMake(5, 78, width, size.height);
        
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataBean *bean = [list objectAtIndex:indexPath.row];
    NSString *txt =[NSString stringWithFormat:@"描述:%@",bean.desc];
    CGSize size = [txt sizeWithFont:[UIFont fontWithName:@"Arial" size:12.0f] constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height+82;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)sController {
    NSString *searchString = [searchController.searchBar text];
    if(![Common isEmptyString:searchString]){
        list = [db getSkillsByKey:searchString];
        [self.tableView reloadData];
    }
}

@end
