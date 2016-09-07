//
//  TopModel.h
//  Movie
//
//  Created by CYC on 16/4/25.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopModel : NSObject

@property (strong, nonatomic)NSDictionary *rating;
@property (copy, nonatomic)NSString *title;
@property (strong, nonatomic)NSDictionary *images;









/*
 
 {
 "rating": {
 "max": 10,
 "average": 9.6,
 "stars": "50",
 "min": 0
 },

 "title": "肖申克的救赎",
 
 "images": {
 "small": "https://img1.doubanio.com/view/movie_poster_cover/ipst/public/p480747492.jpg",
 "large": "https://img1.doubanio.com/view/movie_poster_cover/lpst/public/p480747492.jpg",
 "medium": "https://img1.doubanio.com/view/movie_poster_cover/spst/public/p480747492.jpg"
 },
 
 }
 
 */








@end
