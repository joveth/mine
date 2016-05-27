//
//  MapsViewController.m
//  mine
//
//  Created by Shuwei on 16/5/26.
//  Copyright © 2016年 jov. All rights reserved.
//

#import "MapsViewController.h"

@interface MapsViewController ()

@end

@implementation MapsViewController{
    MBProgressHUD *HUD;
    DBHelper *db;
    NSMutableArray *heros;
    CGFloat width;
    NSInteger sect;
    
}

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeaderIdentifier = @"HeaderCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"地图关卡";
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"加载中...";
    [HUD show:YES];
    heros = [[NSMutableArray alloc] init];
    width = [UIScreen mainScreen].applicationFrame.size.width/4;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseHeaderIdentifier];
    db = [DBHelper sharedInstance];
    
    UIBarButtonItem *rightItem = ({
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        [button setTitle:@"提示" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        barButtonItem;
    });
    rightItem.tintColor=[UIColor whiteColor];
    rightItem.title=@"提示";
    self.navigationItem.rightBarButtonItem =rightItem;
    self.navigationItem.rightBarButtonItem.title=@"提示";
    self.view.backgroundColor=[Common colorWithHexString:@"e0e0e0"];
}

-(IBAction)showMenu:(UIButton *)sender{
    [Common showMessageWithOkButton:@"有背景色的地图会掉血钻哦亲"];
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
        heros = [db getMap];
    }
    [HUD hide:YES];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [heros count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth=0.3f;
    cell.layer.borderColor=[Common colorWithHexString:@"8a8a8a"].CGColor;
    
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:1] ;
    if(name==nil){
        name = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, width-2, width-2)];
        name.tag = 1;
        name.textAlignment=NSTextAlignmentCenter;
        name.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:name];
    }
    
    DataBean *bean = [heros objectAtIndex:indexPath.row];
    if(bean){
        name.text=bean.name;
        name.backgroundColor=[UIColor whiteColor];
        if([@"1" isEqualToString:bean.type]){
            name.backgroundColor = [Common colorWithHexString:@"e89abe"];
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize returnSize = CGSizeMake(width, width);
    return returnSize;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    DataBean *bean=[heros objectAtIndex:indexPath.row];
    WebController *show = [[WebController alloc] init];
    [ShareData shareInstance].html=bean.ref;
    [ShareData shareInstance].urltype=nil;
    show.title=bean.name;
    [self.navigationController pushViewController:show animated:YES];
}

@end
