//
//  NewsTableViewCell.m
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)loadDataFromModel:(NewsCellModel *)model{

    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
    if (model.src) {
         _srcLabel.text = model.src;
    }else{
    
       _srcLabel.text = model.mediaName;
    }
    
    _titleLabel.text = model.title;
    
    _countLabel.text = [NSString stringWithFormat:@"%d",model.commentCount];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
