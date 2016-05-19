//
//  XFPoint.h
//  贪吃蛇
//
//  Created by biznest on 15/5/26.
//  Copyright (c) 2015年 biznest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPoint : NSObject

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
- (id)initWithX:(int)x Y:(int)y;

@end
