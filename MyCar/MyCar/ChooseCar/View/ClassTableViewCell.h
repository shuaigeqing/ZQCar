//
//  ClassTableViewCell.h
//  MyCar
//
//  Created by 🐵 on 16-5-30.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseModel.h"

@interface ClassTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *IV;
@property (strong, nonatomic) IBOutlet UILabel *Label;
- (void)loadDataFromModel:(ChooseModel *)model;

@end
