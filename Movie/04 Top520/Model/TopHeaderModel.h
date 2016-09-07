//
//  TopHeaderModel.h
//  Movie
//
//  Created by CYC on 16/4/25.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopHeaderModel : NSObject

@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *titleCn;
@property (strong, nonatomic) NSArray *type;
@property (strong, nonatomic) NSArray *directors;
@property (strong, nonatomic) NSArray *actors;
@property (strong, nonatomic) NSDictionary *detialRelease;  //关键字是不可以作为属性滴
@property (strong, nonatomic) NSArray *images;








/*
 
    "image" : "http://img31.mtime.cn/mt/2012/06/28/131128.94272291.jpg",
	"titleCn" : "摩尔庄园2海妖宝藏",
	"type" : [ "动画", "动作", "奇幻", "冒险" ],
	"url" : "http://movie.mtime.com/157836/",
	"directors" : [ "刘可欣" ],
	"actors" : ["阿黄","阿龟","阿宇","阿红","凤姐"],
	"release" : {
 "location" : "中国",
 "date" : "2012-7-5"
	},
	"imageCount" : 16,
	"images" : [ "http://img31.mtime.cn/pi/2012/06/14/193026.85486289.jpg",
 "http://img31.mtime.cn/pi/2012/06/14/193028.65049217.jpg",
 "http://img31.mtime.cn/pi/2012/06/14/193029.38103098.jpg",
 "http://img31.mtime.cn/pi/2012/06/14/193030.29253345.jpg" ],

 */





@end
