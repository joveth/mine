//
//  ViewController.m
//  mine
//
//  Created by Shuwei on 16/5/26.
//  Copyright © 2016年 jov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIView *topView,*content,*other;
    CGFloat width,avgWidth,avgHeight;
    NSInteger tag;
}

- (void)viewDidLoad  {
    [super viewDidLoad];
    self.title=@"冒险与挖矿";
    width = self.view.frame.size.width;
    avgWidth = width/3;
    avgHeight = 90;
    CGFloat offset=64;
    self.view.backgroundColor=[Common colorWithHexString:@"e0e0e0"];
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, offset, width, 110)];
    topView.backgroundColor=[Common colorWithHexString:@"89692E"];
    [self.view addSubview:topView];
    offset+=130;
    content = [[UIView alloc] initWithFrame:CGRectMake(0, offset, width, 200)];
    content.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:content];
    offset+=220;
    other= [[UIView alloc] initWithFrame:CGRectMake(0, offset, width, 44)];
    other.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:other];
    UILabel *copyright=[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-20, self.view.frame.size.width, 20)];
    copyright.text=@"知己知彼";
    copyright.textColor=[Common colorWithHexString:@"707070"];
    copyright.font=[UIFont systemFontOfSize:10.0];
    copyright.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:copyright];
    tag=1;
    //原图片
    UIImage * img = [UIImage imageNamed:@"carnival.png"];//570,334,114
    //1
    CGImageRef temImg = img.CGImage;
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(570, 343, 114, 114));
    UIView *b0 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, avgWidth, 90)];
    UIImageView *i0 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i0.image = [UIImage imageWithCGImage:temImg];
    UILabel *l0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l0.font=[UIFont systemFontOfSize:18];
    l0.textColor=[UIColor whiteColor];
    l0.textAlignment=NSTextAlignmentCenter;
    l0.text=@"英雄图鉴";
    [b0 addSubview:i0];
    [b0 addSubview:l0];
    b0.tag=tag++;
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap0.cancelsTouchesInView=NO;
    tap0.delegate = self;
    [b0 addGestureRecognizer:tap0];
    [topView addSubview:b0];
    
    //2
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(411, 1, 114, 114));
    
    UIView *b1 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth, 10, avgWidth, 90)];
    UIImageView *i1 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i1.image = [UIImage imageWithCGImage:temImg];
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l1.font=[UIFont systemFontOfSize:18 ];
    l1.textColor=[UIColor whiteColor];
    l1.textAlignment=NSTextAlignmentCenter;
    l1.text=@"关卡地图";
    [b1 addSubview:i1];
    [b1 addSubview:l1];
    b1.tag=tag++;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap1.cancelsTouchesInView=NO;
    tap1.delegate = self;
    [b1 addGestureRecognizer:tap1];
    [topView addSubview:b1];
    
    //3
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(684, 571, 114, 114));
    UIView *b2 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth*2, 10, avgWidth, 90)];
    UIImageView *i2 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i2.image =  [UIImage imageWithCGImage:temImg];
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l2.font=[UIFont systemFontOfSize:18 ];
    l2.textColor=[UIColor whiteColor];
    l2.textAlignment=NSTextAlignmentCenter;
    l2.text=@"技能图鉴";
    [b2 addSubview:i2];
    [b2 addSubview:l2];
    b2.tag=tag++;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap2.cancelsTouchesInView=NO;
    tap2.delegate = self;
    [b2 addGestureRecognizer:tap2];
    [topView addSubview:b2];
    //4
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(456, 343, 114, 114));
    UIView *b3 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, avgWidth, 90)];
    UIImageView *i3 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i3.image = [UIImage imageWithCGImage:temImg];
    UILabel *l3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l3.font=[UIFont systemFontOfSize:16];
    l3.textColor=[UIColor blackColor];
    l3.textAlignment=NSTextAlignmentCenter;
    l3.text=@"排行榜";
    [b3 addSubview:i3];
    [b3 addSubview:l3];
    b3.tag=tag++;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap3.cancelsTouchesInView=NO;
    tap3.delegate = self;
    [b3 addGestureRecognizer:tap3];
    [content addSubview:b3];
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(0, 297, 114, 114));
    //5
    UIView *b4 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth, 10, avgWidth, 90)];
    UIImageView *i4 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i4.image = [UIImage imageWithCGImage:temImg];
    UILabel *l4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l4.font=[UIFont systemFontOfSize:16];
    l4.textColor=[UIColor blackColor];
    l4.textAlignment=NSTextAlignmentCenter;
    l4.text=@"常用表";
    [b4 addSubview:i4];
    [b4 addSubview:l4];
    b4.tag=tag++;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap4.cancelsTouchesInView=NO;
    tap4.delegate = self;
    [b4 addGestureRecognizer:tap4];
    [content addSubview:b4];
    
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(798, 571, 114, 114));
    //6
    UIView *b5 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth*2, 10, avgWidth, 90)];
    UIImageView *i5 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i5.image = [UIImage imageWithCGImage:temImg];
    UILabel *l5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l5.font=[UIFont systemFontOfSize:16];
    l5.textColor=[UIColor blackColor];
    l5.textAlignment=NSTextAlignmentCenter;
    l5.text=@"新手攻略";
    [b5 addSubview:i5];
    [b5 addSubview:l5];
    b5.tag=tag++;
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap5.cancelsTouchesInView=NO;
    tap5.delegate = self;
    [b5 addGestureRecognizer:tap5];
    [content addSubview:b5];
    
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(114, 639, 114, 114));
    
    UIView *b6 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, avgWidth, 90)];
    UIImageView *i6 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i6.image = [UIImage imageWithCGImage:temImg];
    UILabel *l6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l6.font=[UIFont systemFontOfSize:16];
    l6.textColor=[UIColor blackColor];
    l6.textAlignment=NSTextAlignmentCenter;
    l6.text=@"矿区攻略";
    [b6 addSubview:i6];
    [b6 addSubview:l6];
    b6.tag=tag++;
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap6.cancelsTouchesInView=NO;
    tap6.delegate = self;
    [b6 addGestureRecognizer:tap6];
    [content addSubview:b6];
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(798, 685, 114, 114));
    
    UIView *b7 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth, 100, avgWidth, 90)];
    UIImageView *i7 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i7.image = [UIImage imageWithCGImage:temImg];
    UILabel *l7 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l7.font=[UIFont systemFontOfSize:16];
    l7.textColor=[UIColor blackColor];
    l7.textAlignment=NSTextAlignmentCenter;
    l7.text=@"PVP攻略";
    [b7 addSubview:i7];
    [b7 addSubview:l7];
    b7.tag=tag++;
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap7.cancelsTouchesInView=NO;
    tap7.delegate = self;
    [b7 addGestureRecognizer:tap7];
    [content addSubview:b7];
    temImg=CGImageCreateWithImageInRect(img.CGImage, CGRectMake(798, 229, 114, 114));
    
    UIView *b8 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth*2, 100, avgWidth, 90)];
    UIImageView *i8 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-55)/2, 10, 55, 55)];
    i8.image = [UIImage imageWithCGImage:temImg];
    UILabel *l8 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l8.font=[UIFont systemFontOfSize:16];
    l8.textColor=[UIColor blackColor];
    l8.textAlignment=NSTextAlignmentCenter;
    l8.text=@"佣兵攻略";
    [b8 addSubview:i8];
    [b8 addSubview:l8];
    b8.tag=tag++;
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap8.cancelsTouchesInView=NO;
    tap8.delegate = self;
    [b8 addGestureRecognizer:tap8];
    [content addSubview:b8];
    
    UIView *other1 = [[UIView alloc] initWithFrame:CGRectMake(5, 2, width-10, 40)];
    UIImageView *otherimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
    otherimage1.image = [UIImage imageNamed:@"message"];
    UILabel *otherlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, width-40, 20)];
    otherlabel1.font=[UIFont systemFontOfSize:14];
    otherlabel1.textColor=[UIColor blackColor];
    otherlabel1.text=@"给我留言吧，亲";
    //otherlabel1.textAlignment=NSTextAlignmentCenter;
    [other1 addSubview:otherimage1];
    [other1 addSubview:otherlabel1];
    other1.tag=tag++;
    UITapGestureRecognizer *tap9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap9.cancelsTouchesInView=NO;
    tap9.delegate = self;
    [other1 addGestureRecognizer:tap9];
    [other addSubview:other1];
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(void)handler :(UITapGestureRecognizer *)sender{
    NSLog(@"tag=%d",sender.view.tag);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    switch (sender.view.tag) {
        case 1:{
            HerosViewController *show =[[HerosViewController alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 2:{
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            [flowLayout setItemSize:CGSizeMake([UIScreen mainScreen].applicationFrame.size.width/4,60)];
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            MapsViewController *show = [[MapsViewController alloc] initWithCollectionViewLayout:flowLayout];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 3:{
            SkillViewController *show =[[SkillViewController alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 4:{
            BlogsViewController *show =[[BlogsViewController alloc] init];
            [ShareData shareInstance].title=@"排行榜";
            [ShareData shareInstance].type=@"2";
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 5:{
            BlogsViewController *show =[[BlogsViewController alloc] init];
            [ShareData shareInstance].title=@"常用表";
            [ShareData shareInstance].type=@"1";
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 6:{
            BlogsViewController *show =[[BlogsViewController alloc] init];
            [ShareData shareInstance].title=@"新手攻略";
            [ShareData shareInstance].type=@"3";
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 7:{
            BlogsViewController *show =[[BlogsViewController alloc] init];
            [ShareData shareInstance].title=@"矿区攻略";
            [ShareData shareInstance].type=@"4";
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 8:{
            BlogsViewController *show =[[BlogsViewController alloc] init];
            [ShareData shareInstance].title=@"PVP攻略";
            [ShareData shareInstance].type=@"5";
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 9:{
            BlogsViewController *show =[[BlogsViewController alloc] init];
            [ShareData shareInstance].title=@"佣兵攻略";
            [ShareData shareInstance].type=@"6";
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 10:{
            MessageViewController *show =[[MessageViewController alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
