//
//  NewsModel.m
//  Movie
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

//消除关键字的错误提示
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        _newsId = value;
    }

}



@end
