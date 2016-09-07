//
//  HeaderCollectionView.m
//  Movie
//
//  Created by CYC on 16/4/22.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "HeaderCollectionView.h"
#import "HeaderCell.h"
#define HeaderCellID @"CYC6666"

@implementation HeaderCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self != nil) {
        //注册单元格
        [self registerClass:[HeaderCell class] forCellWithReuseIdentifier:HeaderCellID];
        //self.bounces = NO;  //取消回弹效果,,不能解决相互调用引起的野指针错误
    }
    return self;

}

//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    HeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HeaderCellID forIndexPath:indexPath];
    
    cell.headerCellModel = self.largeCollectionViewMoviesData[indexPath.item];
    
    return cell;

}

//复写
//在视图将要拖拽结束时调用这个方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    float xOffset = targetContentOffset->x;     //水平方向的位移
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;   //获取当前集合视图的布局对象
    NSInteger pageWidth = kScreenWidth*0.2 + flowLayout.minimumLineSpacing;     //获取单元格页面的宽度
    NSInteger pageNum = (pageWidth/2 + xOffset)/pageWidth;        //获取当前页面的页数
    
    pageNum = velocity.x==0 ? pageNum : (velocity.x>0 ? pageNum+1 : pageNum-1);     //根据滑动速度方向优化页面切换
    //设置当前 pagenum 的范围(0 -- _collectionMoviesData.count-1)
    pageNum = MIN(MAX(pageNum, 0), self.largeCollectionViewMoviesData.count-1);
    targetContentOffset->x = pageNum * pageWidth;       //通过当前页数，直接修偏移量到当前页面即可
    
    self.currentPage = pageNum;     //页数设为属性
    
}

//设置左右边距、留白
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, kScreenWidth*0.2*2, 0, kScreenWidth*0.2*2);  //上左下右
    
}
















@end
