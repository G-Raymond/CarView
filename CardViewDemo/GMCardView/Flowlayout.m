//
//  Flowlayout.m
//  scaleTransimition
//
//  Created by chivox on 2018/12/13.
//  Copyright © 2018年 chivox. All rights reserved.
//

#import "Flowlayout.h"


#define KMainW [UIScreen mainScreen].bounds.size.width
#define KMainH [UIScreen mainScreen].bounds.size.height
#define KScreenRate (375 / KMainW)
#define KSuitFloat(float) (float / KScreenRate)


CGFloat const itemSizeWith = 250;
CGFloat const itemSizeHeight = 420;
CGFloat const minimumLineSpacing = 50;

@implementation Flowlayout
- (instancetype)init{
    self = [super init];
    self.itemSize =
    self.itemSize = CGSizeMake(KSuitFloat(itemSizeWith), KSuitFloat(itemSizeHeight));
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, (KMainW - KSuitFloat(itemSizeWith))/2.0, 0, (KMainW - KSuitFloat(itemSizeWith))/2.0);
    self.minimumLineSpacing = (KMainW - KSuitFloat(itemSizeWith)) / 4.0;
    return self;
}

//设置放大动画
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
        attributes.alpha = scale;
    }
    return arr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}
//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}
@end
