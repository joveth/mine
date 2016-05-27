//
//  ShareData.m
//  Isaac
//
//  Created by Shuwei on 15/7/23.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import "ShareData.h"

@implementation ShareData

@synthesize type;

@synthesize urltype;
@synthesize title;
@synthesize html;
@synthesize history;

static ShareData *instance;
+(ShareData *)shareInstance{
    if(instance==nil){
        instance = [[super alloc] init];
    }
    return instance;
}

-(id)init{
    if(self==[super init]){
    }
    return self;
}
@end
