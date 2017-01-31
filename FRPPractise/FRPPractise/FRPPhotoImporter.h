//
//  FRPPhotoImporter.h
//  FRPPractise
//
//  Created by cjfire on 2017/1/31.
//  Copyright © 2017年 cjfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FRPPhotoImporter : NSObject

+ (RACSignal *)importPhotos;

@end
