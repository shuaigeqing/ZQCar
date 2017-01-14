//
//  HeadButtonModel.m
//  MyCar
//
//  Created by 🐵 on 16-5-22.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "HeadButtonModel.h"

@implementation HeadButtonModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }

}

@end
