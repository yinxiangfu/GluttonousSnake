//
//  XFPoint.m
//  贪吃蛇
//
//  Created by biznest on 15/5/26.
//  Copyright (c) 2015年 biznest. All rights reserved.
//

#import "XFPoint.h"

@implementation XFPoint

- (id)initWithX:(int)x Y:(int)y
{
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    XFPoint *point = (XFPoint *)object;
    if (_x == point.x && _y == point.y) {
        return YES;
    }
    return NO;
}

@end
