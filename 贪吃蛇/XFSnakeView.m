//
//  XFSnakeView.m
//  贪吃蛇
//
//  Created by biznest on 15/5/26.
//  Copyright (c) 2015年 biznest. All rights reserved.
//

#import "XFSnakeView.h"
#import <AVFoundation/AVFoundation.h>
#import "XFPoint.h"

@interface XFSnakeView ()
{
    NSMutableArray *_snakeData;
    XFPoint *_foodPoint;
    NSTimer *_timer;
    UIColor *_bgColor;
    UIImage *_cherryImage;
    UIAlertView *_overAlert;
    SystemSoundID _gu;
    SystemSoundID _crash;
}
@end

@implementation XFSnakeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cherryImage = [UIImage imageNamed:@"food"];
        _bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
        _overAlert = [[UIAlertView alloc] initWithTitle:@"游戏结束" message:@"你输了，是否再来一局？" delegate:self cancelButtonTitle:@"不玩了" otherButtonTitles:@"再来一局！", nil];
        [self startGame];
    }
    return self;
}

- (void)startGame
{
    _snakeData = [NSMutableArray arrayWithObjects:
                  [[XFPoint alloc] initWithX:1 Y:0],
                  [[XFPoint alloc] initWithX:2 Y:0],
                  [[XFPoint alloc] initWithX:3 Y:0],
                  [[XFPoint alloc] initWithX:4 Y:0],
                  [[XFPoint alloc] initWithX:5 Y:0],nil];
    _dir = XFRight;
    _timer = [NSTimer scheduledTimerWithTimeInterval:TIME target:self selector:@selector(move) userInfo:nil repeats:YES];
}

- (void)move
{
    XFPoint *first = _snakeData[_snakeData.count - 1];
    XFPoint *head = [[XFPoint alloc] initWithX:first.x Y:first.y];
    
    switch (_dir) {
        case XFUp:
            head.y -= 1;
            break;
        case XFDown:
            head.y += 1;
            break;
        case XFLeft:
            head.x -= 1;
            break;
        case XFRight:
            head.x += 1;
            break;
        default:
            break;
    }
    if (head.x < 0 ||
        head.x > WIDTH - 1 ||
        head.y < 0 ||
        head.y > HEIGHT - 1 ||
        [_snakeData containsObject:head]) {
        [_overAlert show];
        [_timer invalidate];
    }
    if ([head isEqual:_foodPoint]) {
        [_snakeData addObject:_foodPoint];
        _foodPoint = nil;
    }else{
        for (int i = 0; i < _snakeData.count - 1; i ++) {
            XFPoint *curPt = _snakeData[i];
            XFPoint *nextPt = _snakeData[i + 1];
            curPt.x = nextPt.x;
            curPt.y = nextPt.y;
        }
        [_snakeData setObject:head atIndexedSubscript:_snakeData.count - 1];
    }
    if (_foodPoint == nil) {
        while (1) {
            XFPoint *newFoodPoint = [[XFPoint alloc] initWithX:arc4random()%WIDTH Y:arc4random()%HEIGHT];
            if (![_snakeData containsObject:newFoodPoint]) {
                _foodPoint = newFoodPoint;
                break;
            }
        }
    }
    [self setNeedsDisplay];
}

- (void)drawHeadInRect:(CGRect)rect context:(CGContextRef)ref
{
    CGContextBeginPath(ref);
    CGFloat starAngle;
    switch (_dir) {
        case XFUp:
            starAngle = M_PI * 7 / 4;
            break;
        case XFDown:
            starAngle = M_PI * 3 / 4;
            break;
        case XFLeft:
            starAngle = M_PI * 5 / 4;
            break;
        case XFRight:
            starAngle = M_PI * 1 / 4;
            break;
        default:
            break;
    }
    CGContextAddArc(ref, CGRectGetMidX(rect), CGRectGetMidY(rect), CELL_SIZE/2, starAngle, M_PI * 1.5 + starAngle, 0);
    CGContextAddLineToPoint(ref,CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGContextClosePath(ref);
    CGContextFillPath(ref);
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ref, _bgColor.CGColor);
    CGContextFillRect(ref, CGRectMake(0, 0, WIDTH * CELL_SIZE, HEIGHT * CELL_SIZE));
    [@"贪吃蛇" drawInRect:CGRectMake(rect.size.width/2-50, 20, 100, 50) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                         [UIFont fontWithName:@"Heiti SC" size:30],
                                                         NSFontAttributeName,[UIColor colorWithRed:1 green:0 blue:1 alpha:4],
                                                         NSFontAttributeName, nil]];
    
    CGContextSetRGBFillColor(ref, 1, 0, 0, 1);
    for (int i = 0; i < _snakeData.count; i ++) {
        XFPoint *cp = _snakeData[i];
        CGRect rect = CGRectMake(cp.x * CELL_SIZE, cp.y * CELL_SIZE, CELL_SIZE, CELL_SIZE);
        if (i < 4) {
            CGFloat inset = (4 - i);
            CGContextFillEllipseInRect(ref, CGRectInset(rect, inset, inset));
        }else if (i == _snakeData.count - 1){
            [self drawHeadInRect:rect context:ref];
        }else{
            CGContextFillEllipseInRect(ref, rect);
        }
    }
    [_cherryImage drawAtPoint:CGPointMake(_foodPoint.x * CELL_SIZE, _foodPoint.y * CELL_SIZE)];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self startGame];
    }
}

@end
