//
//  CardView.m
//  scaleTransimition
//
//  Created by chivox on 2018/12/14.
//  Copyright © 2018年 chivox. All rights reserved.
//

#import "CardView.h"
#import "CollectionViewCell.h"
#import "Flowlayout.h"
@interface CardView()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property(nonatomic, strong) UIView *upView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIImageView *imageView;//保存背景图

@property(nonatomic, assign) CGFloat startContentOffSet_X;
@property(nonatomic, assign) CGFloat endContentOffSet_X;
@property(nonatomic, assign) NSInteger currentIndex;

@end
@implementation CardView

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatCollectionView];
    }
    return self;
}

- (void)creatCollectionView{
    Flowlayout *flowLayout = [[Flowlayout alloc]init];
    _collectionView  = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    
    //设置背景毛玻璃效果
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dy"]];
    imageView.frame = _collectionView.bounds;
    imageView.backgroundColor = [UIColor blueColor];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]initWithEffect:effect];
    visualEffect.alpha = 0.8;
    visualEffect.frame = imageView.bounds;
    [imageView addSubview:visualEffect];
    _imageView = imageView;
    _collectionView.backgroundView = _imageView;

}


#pragma mark -UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
    cell.showImageName = self.dataArr[indexPath.row];
    cell.scollBlcok = ^(BOOL allowScroll){
        collectionView.scrollEnabled = allowScroll;
    };
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startContentOffSet_X = scrollView.contentOffset.x;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _endContentOffSet_X = scrollView.contentOffset.x;
    
    CGFloat dragMin_X = [UIScreen mainScreen].bounds.size.width / 4.0; // 滑动不足o屏幕的四分之一 不换页
    if (_endContentOffSet_X > _startContentOffSet_X &&
        (fabs(_endContentOffSet_X - _startContentOffSet_X) > dragMin_X)) {
        //向右滑动
        _currentIndex += 1;
        _currentIndex = (_currentIndex > _dataArr.count - 1) ? (_dataArr.count - 1) : _currentIndex;
    }else if(_endContentOffSet_X < _startContentOffSet_X &&
             (fabs(_endContentOffSet_X - _startContentOffSet_X) > dragMin_X)){
        //向左滑动
        _currentIndex -= 1;
        _currentIndex = (_currentIndex < 0) ? 0 : _currentIndex;
    }
    NSLog(@"%ld",_currentIndex);
    //在主线程调用会有问题
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.imageView.image = [UIImage imageNamed:self.dataArr[self.currentIndex]];
    });
    
}








@end
