//
//  CellBackView.h
//  Movie
//
//  Created by CYC on 16/4/21.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
#import "StarView.h"

@interface CellBackView : UIView

@property (strong, nonatomic)MovieModel *cellBackViewModel;

@property (weak, nonatomic) IBOutlet UIImageView *cellBackImageView;
@property (weak, nonatomic) IBOutlet UILabel *MovieLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (weak, nonatomic) IBOutlet StarView *starView;




@end
