//
//  MovieModel.h
//  Movie
//
//  Created by CYC on 16/4/19.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject


@property (strong, nonatomic)NSDictionary *rating;//评分
@property (strong, nonatomic)NSArray *genres; //类型
@property (copy, nonatomic)NSString *title; //标题
@property (assign,nonatomic)NSUInteger collect_count; //收藏数
@property (copy, nonatomic)NSString *original_title; //原始标题
@property (copy, nonatomic)NSString *year; //上映年份
@property (strong, nonatomic)NSDictionary *images; //电影海报
















/*      在JSON文件中拷贝过来，而不是直接打印 需要什么就将它定义成属性
 {
 "rating": {
 "max": 10,
 "average": 8,
 "stars": "40",
 "min": 0
 },
 "genres": [
 "剧情",
 "奇幻",
 "冒险"
 ],
 "title": "奇幻森林",
 "year": "2016",
 "images": {
 "small": "http://img3.doubanio.com/view/movie_poster_cover/ipst/public/p2324130709.jpg",
 "large": "http://img3.doubanio.com/view/movie_poster_cover/lpst/public/p2324130709.jpg",
 "medium": "http://img3.doubanio.com/view/movie_poster_cover/spst/public/p2324130709.jpg"
 },
 */







@end
