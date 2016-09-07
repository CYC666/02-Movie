//
//  JSONObject.m
//  Movie
//
//  Created by CYC on 16/4/19.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "JSONObject.h"

@implementation JSONObject

+ (id)loadData:(NSString *)fileName {

    //1、获取boundls包中JSON的文件路径
    NSString *JSONPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    //2、将路径中的JSON转化成二进制文件
    NSData *JSONData = [NSData dataWithContentsOfFile:JSONPath];
    //3、将二进制文件转成对象
    id data = [NSJSONSerialization JSONObjectWithData:JSONData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];

    return data;
    
}

@end
