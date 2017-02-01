//
//  FRPGalleryFlowLayout.m
//  FRPPractise
//
//  Created by cjfire on 2017/2/1.
//  Copyright © 2017年 cjfire. All rights reserved.
//

#import "FRPGalleryFlowLayout.h"

@implementation FRPGalleryFlowLayout

- (instancetype)init{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(145,145);
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    
    return self;
}

@end
