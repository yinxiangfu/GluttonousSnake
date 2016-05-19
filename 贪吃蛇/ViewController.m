//
//  ViewController.m
//  贪吃蛇
//
//  Created by biznest on 15/5/26.
//  Copyright (c) 2015年 biznest. All rights reserved.
//

#import "ViewController.h"
#import "XFSnakeView.h"

@interface ViewController ()
{
    XFSnakeView *_snakeView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _snakeView = [[XFSnakeView alloc] initWithFrame:CGRectMake(10, 10, WIDTH * CELL_SIZE, HEIGHT * CELL_SIZE)];
    _snakeView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    _snakeView.layer.borderWidth = 3;
    _snakeView.layer.borderColor = [UIColor blackColor].CGColor;
    _snakeView.layer.cornerRadius = 6;
    _snakeView.layer.masksToBounds = YES;
    self.view.userInteractionEnabled = YES;
    self.view.multipleTouchEnabled = YES;
    for (int i = 0; i < 4; i ++) {
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
        swipe.numberOfTouchesRequired = 1;
        swipe.direction = 1 << i;
        [self.view addGestureRecognizer:swipe];
    }
    [self.view addSubview:_snakeView];
}

- (void)swipeHandle:(UISwipeGestureRecognizer *)sender
{
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            if (_snakeView.dir != XFDown)
            _snakeView.dir = XFUp;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            if (_snakeView.dir != XFUp)
            _snakeView.dir = XFDown;
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            if (_snakeView.dir != XFRight)
            _snakeView.dir = XFLeft;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            if (_snakeView.dir != XFLeft)
            _snakeView.dir = XFRight;
            break;
    }
}

@end
