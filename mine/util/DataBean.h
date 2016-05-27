//
//  DataBean.h
//  Starve
//
//  Created by Shuwei on 15/10/28.
//  Copyright © 2015年 jov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBean : NSObject


@property(nonatomic,copy)NSString *sid;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *attack;
@property(nonatomic,copy)NSString *factor;

@property(nonatomic,copy)NSString *skill;
@property(nonatomic,copy)NSString *skill1;
@property(nonatomic,copy)NSString *skill2;
@property(nonatomic,copy)NSString *tool;
@property(nonatomic,copy)NSString *before;
@property(nonatomic,copy)NSString *prot;
@property(nonatomic,copy)NSString *dodge;
@property(nonatomic,copy)NSString *king;

@property(nonatomic,copy)NSString *belong;
@property(nonatomic,copy)NSString *hurt;
@property(nonatomic,copy)NSString *hurtrate;
@property(nonatomic,copy)NSString *rate;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *ref;
@end
