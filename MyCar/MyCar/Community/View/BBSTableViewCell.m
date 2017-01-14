//
//  BBSTableViewCell.m
//  MyCar
//
//  Created by 🐵 on 16-5-26.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "BBSTableViewCell.h"

@implementation BBSTableViewCell

-(void)loadDataFromModel:(BBSModel *)model{

    [_IV sd_setImageWithURL:[NSURL URLWithString:model.postImage] placeholderImage:nil];
    
    _titleLabel.text = model.postTitle;
    
    _authorLabel.text =model.author;
    
    _replyCountLabel.text = [NSString stringWithFormat:@"%d",model.replyCount];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
