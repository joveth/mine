//
//  SettingBean.h
//  Starve
//
//  Created by Shuwei on 16/2/2.
//  Copyright © 2016年 jov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingBean : NSObject
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *version;
@property(nonatomic,copy)NSString *buildno;
@end
