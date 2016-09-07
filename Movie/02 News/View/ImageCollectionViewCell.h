//
//  ImageCollectionViewCell.h
//  Movie
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@interface ImageCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) ImageModel *imageModel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end
