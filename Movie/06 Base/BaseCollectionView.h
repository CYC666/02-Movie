//
//  BaseCollectionView.h
//  Movie
//
//  Created by CYC on 16/4/22.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionView : UICollectionView

@property (strong, nonatomic)NSArray *largeCollectionViewMoviesData;
@property (assign, nonatomic)NSInteger currentPage;     //当前页码

@end
