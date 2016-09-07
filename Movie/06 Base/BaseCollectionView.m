//
//  BaseCollectionView.m
//  Movie
//
//  Created by CYC on 16/4/22.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "BaseCollectionView.h"
#import "PostCollectionViewFlowLayout.h"

@interface BaseCollectionView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation BaseCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self != nil) {
        self.dataSource = self;
        self.delegate = self;
        
        self.decelerationRate = UIScrollViewDecelerationRateFast;       //使滑动更加清爽
        self.showsHorizontalScrollIndicator = NO;       //不展示水平方向的滑动条
    }
    return self;

}

//单元格item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _largeCollectionViewMoviesData.count;

}

//创建单元格item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    return nil;

}


//在视图将要拖拽结束时调用这个方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    float xOffset = targetContentOffset->x;     //水平方向的位移
    PostCollectionViewFlowLayout *flowLayout = (PostCollectionViewFlowLayout *)self.collectionViewLayout;   //获取当前集合视图的布局对象
    NSInteger pageWidth = kScreenWidth*0.7 + flowLayout.minimumLineSpacing;     //获取单元格页面的宽度
    NSInteger pageNum = (pageWidth/2 + xOffset)/pageWidth;        //获取当前页面的页数
    
    pageNum = velocity.x==0 ? pageNum : (velocity.x>0 ? pageNum+1 : pageNum-1);     //根据滑动速度方向优化页面切换
    
    //设置当前 pagenum 的范围(0 -- _collectionMoviesData.count-1)
    pageNum = MIN(MAX(pageNum, 0), _largeCollectionViewMoviesData.count-1);
    
    targetContentOffset->x = pageNum * pageWidth;       //通过当前页数，直接修偏移量到当前页面即可
    //必须要self调用，才能响应观察者
    self.currentPage = pageNum;     //页数设为属性
    
}























@end
