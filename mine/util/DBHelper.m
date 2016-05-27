//
//  DBHelper.m
//  Isaac
//
//  Created by Shuwei on 15/7/2.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"
#import "Common.h"


@interface DBHelper(){
    FMDatabase *db;
}
@end

static const NSString *TB_HEROS = @"tb_heros";
static const NSString *TB_MAPS = @"tb_maps";
static const NSString *TB_SKILL = @"tb_skill";
static const NSString *TB_TABS = @"tb_tabs";

static const NSString *TB_SETTING = @"tb_setting";


@implementation DBHelper
+(id)sharedInstance{
    static DBHelper *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedInstance = [[super alloc]init];
    });
    return sharedInstance;
}
-(BOOL)openDB{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"mine.sqlite"];
    
    // 1.获得数据库对象
    db = [FMDatabase databaseWithPath:fileName];
    // 2.打开数据库
    if ([db open]) {
        NSLog(@"打开成功");
        // 2.1创建表
        //name,image,type,attack,factor,skill,skill1,skill2,tool,before,prot,dodge,king
        NSString *sql = @"CREATE TABLE IF NOT EXISTS %@ ( name varchar(60),image varchar(80),type varchar(10), attack varchar(30),factor varchar(30), skill varchar(30),skill1 varchar(30),skill2 varchar(30),tool varchar(30),before varchar(20),prot varchar(20),dodge varchar(20),king varchar(20) )";
        BOOL success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_HEROS]];
        
        sql = @"CREATE TABLE IF NOT EXISTS %@ (key varchar(20),version varchar(10),buildno varchar(10))";

        success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_SETTING]];
        
        sql = @"CREATE TABLE IF NOT EXISTS %@ ( name varchar(60),type varchar(10),ref varchar(30) )";
        
        success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_MAPS]];
        
        sql = @"CREATE TABLE IF NOT EXISTS %@ (name varchar(60),belong varchar(60),hurt varchar(40),hurtrate varchar(20),rate varchar(10),desc varchar(200),type varchar(40))";
        
        success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_SKILL]];
        
        sql = @"CREATE TABLE IF NOT EXISTS %@ (name varchar(100),type varchar(2),ref varchar(40))";
        
        success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_TABS]];
        
        return success;
    }else{
        return NO;
    }
}
-(void)initData:(BOOLCallBack)success{
    NSArray *aArray = [@"store.db" componentsSeparatedByString:@"."];
    NSString *filename = [aArray objectAtIndex:0];
    NSString *sufix = [aArray objectAtIndex:1];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:sufix];
    NSString* myString = [NSString stringWithContentsOfFile:filePath usedEncoding:NULL error:NULL];
    NSArray *result = [myString componentsSeparatedByString:@"\n"];
    if(![db open]){
        if(success){
            success(NO);
        }
        return;
    }
    for(int i=0;i<[result count];i++){
        myString = [result objectAtIndex:i];
        if([Common isEmptyString:myString]){
            continue;
        }else if([myString hasPrefix:@"#"]){
            continue;
        }
        [db executeUpdate:myString];
    }
    [db close];
    if(success){
        success(YES);
    }
}
-(void)deleteData{
    if(![db open]){
        return;
    }
    [db executeUpdate:[NSString stringWithFormat:@"delete from %@ ",TB_HEROS]];
    [db executeUpdate:[NSString stringWithFormat:@"delete from %@ ",TB_MAPS]];
    [db executeUpdate:[NSString stringWithFormat:@"delete from %@ ",TB_SKILL]];
    [db executeUpdate:[NSString stringWithFormat:@"delete from %@ ",TB_TABS]];
    [db executeUpdate:[NSString stringWithFormat:@"delete from %@ ",TB_SETTING]];
   
    [db close];
}

-(NSInteger)getCnt{
    if(![db open])
    {
        return 0;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select count(*) as total from %@ ",TB_HEROS]];
    NSString *temp =@"0";
    if ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        temp = dict[@"total"];
    }
    [rs close];
    [db close];
    return temp.integerValue;
}
-(NSMutableArray *)getHerosByType:(NSString *)type{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where type=? ",TB_HEROS],type];
    DataBean *bean;
    while ([rs next]) {
        //name,image,type,attack,factor,skill,skill1,skill2,tool,before,prot,dodge,king
        NSDictionary *dict = [rs resultDictionary];
        bean = [[DataBean alloc] init];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.attack = dict[@"attack"];
        bean.type = dict[@"type"];
        bean.factor = dict[@"factor"];
        bean.skill = dict[@"skill"];
        bean.skill1 = dict[@"skill1"];
        bean.skill2 = dict[@"skill2"];
        bean.tool = dict[@"tool"];
        bean.before = dict[@"before"];
        bean.prot = dict[@"prot"];
        bean.dodge = dict[@"dodge"];
        bean.king = dict[@"king"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}
-(NSMutableArray *)getHeros{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  ",TB_HEROS]];
    DataBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[DataBean alloc] init];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.attack = dict[@"attack"];
        bean.type = dict[@"type"];
        bean.factor = dict[@"factor"];
        bean.skill = dict[@"skill"];
        bean.skill1 = dict[@"skill1"];
        bean.skill2 = dict[@"skill2"];
        bean.tool = dict[@"tool"];
        bean.before = dict[@"before"];
        bean.prot = dict[@"prot"];
        bean.dodge = dict[@"dodge"];
        bean.king = dict[@"king"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}

-(NSMutableArray *)getHerosByKey:(NSString *)key;{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where  name like '%%%@%%'  ",TB_HEROS,key]];
    DataBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[DataBean alloc] init];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.attack = dict[@"attack"];
        bean.type = dict[@"type"];
        bean.factor = dict[@"factor"];
        bean.skill = dict[@"skill"];
        bean.skill1 = dict[@"skill1"];
        bean.skill2 = dict[@"skill2"];
        bean.tool = dict[@"tool"];
        bean.before = dict[@"before"];
        bean.prot = dict[@"prot"];
        bean.dodge = dict[@"dodge"];
        bean.king = dict[@"king"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}
-(NSMutableArray *)getSkills{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@ ",TB_SKILL]];
    DataBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[DataBean alloc] init];
        bean.name = dict[@"name"];
        bean.belong = dict[@"belong"];
        bean.hurt = dict[@"hurt"];
        bean.hurtrate = dict[@"hurtrate"];
        bean.rate = dict[@"rate"];
        bean.desc = dict[@"desc"];
        bean.type = dict[@"type"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}

-(NSMutableArray *)getSkillsByKey:(NSString *)key{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }

    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where  name like '%%%@%%'  ",TB_SKILL,key]];
    DataBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[DataBean alloc] init];
        bean.name = dict[@"name"];
        bean.belong = dict[@"belong"];
        bean.hurt = dict[@"hurt"];
        bean.hurtrate = dict[@"hurtrate"];
        bean.rate = dict[@"rate"];
        bean.desc = dict[@"desc"];
        bean.type = dict[@"type"];
        
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}

-(NSMutableArray *)getMap{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  ",TB_MAPS]];
    DataBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[DataBean alloc] init];
        bean.name = dict[@"name"];
        bean.type = dict[@"type"];
        bean.ref = dict[@"ref"];
        
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}

-(NSMutableArray *)getBlogsByType:(NSString *)type{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where type=? ",TB_TABS],type];
    DataBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[DataBean alloc] init];
        bean.name = dict[@"name"];
        bean.type = dict[@"type"];
        bean.ref = dict[@"ref"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;

}

-(SettingBean *)getSetting:(NSString *)key{
    
    if(![db open])
    {
        return nil;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where key=? ",TB_SETTING],key];
    SettingBean *bean;
    if ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[SettingBean alloc] init];
        bean.key = dict[@"key"];
        bean.version = dict[@"version"];
        bean.buildno = dict[@"buildno"];
    }
    [rs close];
    [db close];
    return bean;
}
-(void)saveSetting:(SettingBean *)setting{
    if(![db open]){
        return;
    }
    [db executeUpdate:[NSString stringWithFormat:@"insert into %@(key,version,buildno) values(?,?,?) ",TB_SETTING],setting.key,setting.version,setting.buildno];
    [db close];
}
-(void)deleteSetting{
    if(![db open]){
        return;
    }
    [db executeUpdate:[NSString stringWithFormat:@"delete from %@ ",TB_SETTING]];
    [db close];
}


@end
