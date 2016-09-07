//
//  TopTableViewCell.h
//  Movie
//
//  Created by CYC on 16/4/25.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopCellModel.h"

@interface TopTableViewCell : UITableViewCell

@property (strong, nonatomic) TopCellModel *topCellModel;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *content;



@end
