//
//  LargeCollectionView.m
//  Movie
//
//  Created by CYC on 16/4/20.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "LargeCollectionView.h"
#import "LargeCell.h"
#define LargeCellID @"CYC666"
#import "PostCollectionViewFlowLayout.h"

@interface LargeCollectionView ()
//<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@end

@implementation LargeCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self != nil) {
//        self.dataSource = self;
//        self.delegate   = self;
//        
//        self.decelerationRate = UIScrollViewDecelerationRateFast;       //使滑动更加清爽
//        self.showsHorizontalScrollIndicator = NO;       //取消水平滑动条的显示
        
        //self.bounces = NO;      //取消回弹效果,不能解决相互调用引起的野指针错误
        //注册单元格
        [self registerClass:[LargeCell class] forCellWithReuseIdentifier:LargeCellID];
        

    }
    return self;
}

////集合的单元格个数
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    return _largeCollectionViewMoviesData.count;
//}

//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LargeCellID forIndexPath:indexPath];
    
    //传递数据
//    cell.largeCellModel = _largeCollectionViewMoviesData[indexPath.item];     //应该用self调用属性
    cell.largeCellModel= self.largeCollectionViewMoviesData[indexPath.item];
    
    return cell;
    
    
}

//留白,设置边缘距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(0, (kScreenWidth - kScreenWidth *0.7)/2, 0, (kScreenWidth - kScreenWidth *0.7)/2);  //上左下右

}


//点击单元格会调用下面这个方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.currentPage != indexPath.item) {       //当前视图不等于点击的视图
        //点击之后不允许用户再点击视图
        self.userInteractionEnabled = NO;
        //跳转到点击的视图
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //多线程，0.35秒后做某些事
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
        //保存点击之后对应中间的item的位置
        self.currentPage = indexPath.item;
    } else {        //点击的视图是中央的视图，那就翻转视图
    
        //获取当前被点击的视图
        LargeCell *selectedCell = (LargeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
        //调用翻转cell方法
        [selectedCell buttonAction:nil];
    }
}


//单元格即将消失时调用这个方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    LargeCell *selectedCell = (LargeCell *)cell;
    [selectedCell resetCell];       //重置cell翻转状
}


//在父类已经实现了，就不必要
////视图将要结束拖拽
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//
//    /*
//     scrollView:集合视图
//     velocity:结束拖拽时滑动视图的速度  x方向和y方向
//     targetContentOffset:偏移量，最终停止的位置相对原始位置的距离, 指针
//     */
//    
////    float xVelocity = velocity.x;
////    float yVelocity = velocity.y;
////    NSLog(@"x轴速度: %.2f  y轴速度: %.2f", xVelocity, yVelocity);
//    
//    NSInteger xOffset = targetContentOffset->x;
////    NSInteger yOffset = targetContentOffset -> y;
////    NSLog(@"x轴位移: %ld  y轴位移: %ld", xOffset, yOffset);
//    
//    //获取当前视图的布局对象
//    PostCollectionViewFlowLayout *flowLayout = (PostCollectionViewFlowLayout *)self.collectionViewLayout;
//    
//    //cell单元格页的宽度
//    NSInteger pageWidth = kScreenWidth*0.7 + flowLayout.minimumLineSpacing/2 * 2;
//    
//    //当前cell的页数
//    NSInteger pageNum = (pageWidth/2 + xOffset) / pageWidth;
//    
//    //通过判断滑动的速度来确定当前的页数(优化)
//    pageNum = velocity.x == 0 ? pageNum : (velocity.x > 0 ? pageNum + 1 : pageNum - 1);
//    
//    //通过当前页数，直接修改目标偏移量到当前页面中间
//    targetContentOffset->x = pageNum * pageWidth;
//
//}









@end
