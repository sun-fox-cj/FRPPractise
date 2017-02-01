//
//  FRPPhotoViewController.h
//  FRPPractise
//
//  Created by cjfire on 2017/2/1.
//  Copyright © 2017年 cjfire. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPPhotoModel;

@interface FRPPhotoViewController : UIViewController

@property (nonatomic, readonly) NSInteger photoIndex;
@property (nonatomic, readonly) FRPPhotoModel * photoModel;

- (instancetype)initWithPhotoModel:(FRPPhotoModel *)photoModel index:(NSInteger)photoIndex;

@end
