//
//  DBHelper.h
//  Isaac
//
//  Created by Shuwei on 15/7/2.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "DataBean.h"
#import "SettingBean.h"

typedef void (^BOOLCallBack)(BOOL ret);

@interface DBHelper : NSObject
+(id)sharedInstance;
-(BOOL)openDB;
-(void)initData:(BOOLCallBack)success;
-(void)deleteData;

-(NSInteger)getCnt;
-(NSMutableArray *)getHerosByType:(NSString *)type;
-(NSMutableArray *)getHeros;
-(NSMutableArray *)getHerosByKey:(NSString *)key;

-(NSMutableArray *)getSkills;
-(NSMutableArray *)getSkillsByKey:(NSString *)key;


-(NSMutableArray *)getMap;

-(NSMutableArray *)getBlogsByType:(NSString *)type;

-(SettingBean *)getSetting:(NSString *)key;
-(void)saveSetting:(SettingBean *)setting;
-(void)deleteSetting;



@end
