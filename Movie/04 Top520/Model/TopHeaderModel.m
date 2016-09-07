//
//  TopHeaderModel.m
//  Movie
//
//  Created by CYC on 16/4/25.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "TopHeaderModel.h"

@implementation TopHeaderModel

//消除JSON里有关键字选项的错误
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"release"]) {
        _detialRelease = value;
    }

}




@end
