//
//  CollectionViewCell.m
//  scaleTransimition
//
//  Created by chivox on 2018/12/13.
//  Copyright © 2018年 chivox. All rights reserved.
//

#import "CollectionViewCell.h"
@interface CollectionViewCell ()
@property (nonatomic, strong) UIImageView *upView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipUp;
@property(nonatomic, strong) UISwipeGestureRecognizer *swipDown;
@end
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self creatView];
    return self;
}


- (void)creatView{
//   可以自定义
    _upView = [[UIImageView alloc]initWithFrame:self.bounds];
    _upView.userInteractionEnabled = YES;
    _upView.image = [UIImage imageNamed:@"dy"];
    _bottomView = [[UIView alloc]initWithFrame:self.bounds];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bottomView];
    [self.contentView addSubview:_upView];
    
    UILabel *introduce = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_bottomView.frame) - 100, 250, 100)];
    introduce.font = [UIFont systemFontOfSize:10];
    introduce.numberOfLines = 0;
    introduce.text = @"邪恶与正义一体的傻逼傻舌头\n 牛逼指数： 3颗星。\n人气指数： 3颗星";
    introduce.textColor = [UIColor blackColor];
    [_bottomView addSubview:introduce];
//   可以自定义
    _swipUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipUp:)];
    _swipUp.direction = UISwipeGestureRecognizerDirectionUp;
    [_upView addGestureRecognizer:_swipUp];
    _swipDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipDown:)];
    _swipDown.direction = UISwipeGestureRecognizerDirectionDown;
}

- (void)swipUp:(UISwipeGestureRecognizer *)swipUp{

    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bottomView.transform = CGAffineTransformMakeScale(1.05, 1.1);
        self.upView.frame = CGRectMake(self.upView.frame.origin.x, self.upView.frame.origin.y - 100, self.upView.frame.size.width, self.upView.frame.size.height);
    }completion:^(BOOL finished) {
        [self.upView addGestureRecognizer:self.swipDown];
        [self.upView removeGestureRecognizer:self.swipUp];
        self.scollBlcok(NO);
    }];

}

- (void)swipDown:(UISwipeGestureRecognizer *)swipDown{
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.bottomView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.upView.frame = CGRectMake(self.upView.frame.origin.x, self.upView.frame.origin.y + 100, self.upView.frame.size.width, self.upView.frame.size.height);
    } completion:^(BOOL finished) {
        [self.upView addGestureRecognizer:self.swipUp];
        [self.upView removeGestureRecognizer:self.swipDown];
        self.scollBlcok(YES);
    }];
}

- (void)setShowImageName:(NSString *)showImageName{
    _showImageName = showImageName;
    _upView.image = [UIImage imageNamed:showImageName];
}

@end
