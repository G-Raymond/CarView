//
//  CollectionViewCell.h
//  scaleTransimition
//
//  Created by chivox on 2018/12/13.
//  Copyright © 2018年 chivox. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^allowScrollViewsroll)(BOOL allowScroll);

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)  allowScrollViewsroll scollBlcok;
@property (nonatomic, strong)  NSString *showImageName;
@end

NS_ASSUME_NONNULL_END
