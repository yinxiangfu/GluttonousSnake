//
//  XFSnakeView.h
//  贪吃蛇
//
//  Created by biznest on 15/5/26.
//  Copyright (c) 2015年 biznest. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TIME        0.3
#define WIDTH       15
#define HEIGHT      22
#define CELL_SIZE   20
typedef enum {
    XFUp = 0,
    XFDown,
    XFLeft,
    XFRight
}XFDirection;

@interface XFSnakeView : UIView <UIAlertViewDelegate>

@property (nonatomic, assign) XFDirection dir;

@end
