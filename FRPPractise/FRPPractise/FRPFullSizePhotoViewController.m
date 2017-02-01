//
//  FRPFullSizePhotoViewController.m
//  FRPPractise
//
//  Created by cjfire on 2017/2/1.
//  Copyright © 2017年 cjfire. All rights reserved.
//

#import "FRPFullSizePhotoViewController.h"
#import "FRPPhotoModel.h"
#import "FRPPhotoViewController.h"

@interface FRPFullSizePhotoViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
//Private assignment
@property (nonatomic, strong, readwrite) NSArray<FRPPhotoModel*> *photoModeArray;
//Private properties
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation FRPFullSizePhotoViewController

- (instancetype)initWithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSInteger)photoIndex{
    self = [self init];
    if (!self) return nil;
    
    //Initialized, read-only properties
    _photoModelArray = photoModelArray;
    
    //Configure self
    self.title = [self.photoModelArray[photoIndex] photoName];
    
    //ViewControllers
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:@{UIPageViewControllerOptionInterPageSpacingKey: @30}];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [self addChildViewController:self.pageViewController];
    
    [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:photoIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.pageViewController.view.frame = self.view.bounds;
    
    [self.view addSubview:self.pageViewController.view];
}

- (FRPPhotoViewController *)photoViewControllerForIndex:(NSInteger)index{
    if (index >= 0 && index < self.photoModelArray.count){
        FRPPhotoModel *photoModel = self.photoModelArray[index];
        
        FRPPhotoViewController *photoViewController = [[FRPPhotoViewController alloc] initWithPhotoModel:photoModel index:index];
        
        return photoViewController;
    }
    
    //Index was out of bounds, return nil
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating: (BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed{
    
    self.title = [[self.pageViewController.viewControllers.firstObject photoModel] photoName];
    [self.delegate userDidScroll:self toPhotoAtIndex:[self.pageViewController.viewControllers.firstObject photoIndex]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(FRPPhotoViewController *)viewController{
    return [self photoViewControllerForIndex:viewController.photoIndex - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(FRPPhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex + 1];
}

@end
