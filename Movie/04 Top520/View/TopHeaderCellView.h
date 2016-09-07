//
//  TopHeaderCellView.h
//  Movie
//
//  Created by CYC on 16/4/25.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopHeaderModel.h"


@interface TopHeaderCellView : UIView

@property (strong, nonatomic) TopHeaderModel *topHeaderModel;

@property (weak, nonatomic) IBOutlet UIImageView *topHeaderCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *directors;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *detialRelease;

@property (weak, nonatomic) IBOutlet UIScrollView *imagesScrollView;

- (IBAction)playButton:(UIButton *)sender;



@end
