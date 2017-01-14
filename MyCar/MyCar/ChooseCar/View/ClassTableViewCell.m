//
//  ClassTableViewCell.m
//  MyCar
//
//  Created by 🐵 on 16-5-30.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "ClassTableViewCell.h"

@implementation ClassTableViewCell

- (void)loadDataFromModel:(ChooseModel *)model{

    [_IV sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:nil];
    
    _Label.text = model.name;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
