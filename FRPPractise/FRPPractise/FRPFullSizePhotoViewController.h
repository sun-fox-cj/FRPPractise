//
//  FRPFullSizePhotoViewController.h
//  FRPPractise
//
//  Created by cjfire on 2017/2/1.
//  Copyright © 2017年 cjfire. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPFullSizePhotoViewController, FRPPhotoModel;

@protocol FRPFullSizePhotoViewControllerDelegate <NSObject>
- (void)userDidScroll:(FRPFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index;

@end

@interface FRPFullSizePhotoViewController : UIViewController

- (instancetype)initWithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSInteger)photoIndex;

@property (nonatomic , readonly) NSArray<FRPPhotoModel*> *photoModelArray;
@property (nonatomic, weak) id<FRPFullSizePhotoViewControllerDelegate> delegate;

@end
