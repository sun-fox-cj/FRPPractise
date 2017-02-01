//
//  FRPPhotoViewController.m
//  FRPPractise
//
//  Created by cjfire on 2017/2/1.
//  Copyright © 2017年 cjfire. All rights reserved.
//

#import "FRPPhotoViewController.h"

//Model
#import "FRPPhotoModel.h"

//Utilities
#import "FRPPhotoImporter.h"
#import "SVProgressHUD.h"

@interface FRPPhotoViewController ()
//Private assignment
@property (nonatomic, assign) NSInteger photoIndex;
@property (nonatomic, strong) FRPPhotoModel *photoModel;

//Private properties
@property (nonatomic, weak) UIImageView * imageView;

@end

@implementation FRPPhotoViewController

- (instancetype)initWithPhotoModel:(FRPPhotoModel *)photoModel index:(NSInteger)photoIndex{
    self = [self init];
    if (!self) return nil;
    
    self.photoModel = photoModel;
    self.photoIndex = photoIndex;
    
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Configure self's view
    self.view.backgroundColor = [UIColor blackColor];
    
    //Configure subViews
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    RAC(imageView, image) = [RACObserve(self.photoModel, fullsizedData) map:^id (id value){
        return [UIImage imageWithData:value];
    }];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    
    //Fetch data
    [[FRPPhotoImporter fetchPhotoDetails:self.photoModel]
     subscribeError:^(NSError *error){
         [SVProgressHUD showErrorWithStatus:@"Error"];
     }
     completed:^{
         [SVProgressHUD dismiss];
     }];
}

@end
