//
//  ContainDrawerModel.h
//  MyCar
//
//  Created by 🐵 on 16-5-28.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContainDrawerModel : NSObject

@property (nonatomic,copy) NSString * brandId;

@property (nonatomic,copy) NSString * brandName;

@property (nonatomic,strong) NSMutableArray * serialListArr;

@end
