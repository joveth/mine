//
//  HerosViewController.m
//  mine
//
//  Created by Shuwei on 16/5/26.
//  Copyright © 2016年 jov. All rights reserved.
//

#import "HerosViewController.h"

@interface HerosViewController ()

@end

@implementation HerosViewController{
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
    self.title=@"英雄图鉴";
    UIBarButtonItem *rightItem = ({
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        [button setTitle:@"分类" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        barButtonItem;
    });
    rightItem.tintColor=[UIColor whiteColor];
    rightItem.title=@"分类";
    self.navigationItem.rightBarButtonItem =rightItem;
    self.navigationItem.rightBarButtonItem.title=@"分类";
    
    list = [[NSMutableArray alloc] init];
    width = [UIScreen mainScreen].applicationFrame.size.width-55;
    self.tableView.tableFooterView=[[UIView alloc] init];
    searchController= [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = YES;
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchBar.frame = CGRectMake(searchController.searchBar.frame.origin.x,searchController.searchBar.frame.origin.y, searchController.searchBar.frame.size.width, 44.0);
    searchController.searchBar.placeholder=@"搜索";
    self.tableView.tableHeaderView = searchController.searchBar;
}

-(IBAction)showMenu:(UIButton *)sender{
    CGPoint point =
    CGPointMake(sender.frame.origin.x + sender.frame.size.width / 2,
                64.0 + 3.0);
    NSArray *titles = @[@"闪金", @"金将",@"紫将",@"蓝将",@"绿将",@"白将"];
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point
                                                   titles:titles
                                               imageNames:nil];
    pop.delegate = self;
    [pop show];
}
- (void)didSelectedRowAtIndex:(NSInteger)index {
    [hud show:YES];
    [list removeAllObjects];
    if (index == 0) {
        self.title=@"闪金";
        list =[db getHerosByType:@"闪金"];
    }else if(index == 1) {
        self.title=@"金将";
        list =[db getHerosByType:@"金将"];
    }else if(index == 2) {
        self.title=@"紫将";
        list =[db getHerosByType:@"紫将" ];
    }else if(index == 3) {
        self.title=@"蓝将";
        list =[db getHerosByType:@"蓝将" ];
    }else if(index == 4) {
        self.title=@"绿将";
       list =[db getHerosByType:@"绿将" ];
    }else if(index == 5) {
        self.title=@"白将";
        list = [db getHerosByType:@"白将"];
    }
    [self.tableView reloadData];
    [hud hide:YES];
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
        list = [db getHeros];
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
    UIImageView *image=(UIImageView*)[cell viewWithTag:2];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:3];
    UILabel *tagLabel=(UILabel*)[cell viewWithTag:4];
    UILabel *tag3=(UILabel*)[cell viewWithTag:5];
    if(nameLabel==nil){
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 4, width, 22)];
        nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
        nameLabel.numberOfLines=0;
        nameLabel.tag=1;
        [cell addSubview:nameLabel];
    }
    if(image==nil){
        image = [[UIImageView alloc]init];
        image.tag=2;
        [cell addSubview:image];
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
        if(![Common isEmptyString:bean.image]){
            image.image = [UIImage imageNamed:bean.image];
        }
        contentLabel.frame=CGRectMake(50, 30, width, 20);
        contentLabel.text = [NSString stringWithFormat:@"品质:%@,初始战力:%@,成长系数:%@",bean.type,bean.attack,bean.factor];
        image.frame = CGRectMake(4, 31, 40, 40);
        tagLabel.frame=CGRectMake(50, 54, width, 20);
        tagLabel.text = [NSString stringWithFormat:@"个人技:%@,合体技1:%@,合体技2:%@,宝具:%@",bean.skill,bean.skill1,bean.skill2,bean.tool];
        tag3.frame=CGRectMake(50, 78, width, 20);
        tag3.text = [NSString stringWithFormat:@"先攻值:%@,防御值:%@,闪避值:%@,王者值:%@",bean.before,bean.prot,bean.dodge,bean.king];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 102;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)sController {
    NSString *searchString = [searchController.searchBar text];
    if(![Common isEmptyString:searchString]){
        list = [db getHerosByKey:searchString];
        [self.tableView reloadData];
    }
}




@end
