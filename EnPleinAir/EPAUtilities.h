//
// Created by Sean Brady on 8/17/14.
// Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPAUtilities : NSObject
+ (NSString *)cloudinaryScaleImage:(NSString *)imageStr forFrame:(CGRect)rect retina:(BOOL)retina;

+ (NSString *)cloudinaryToJPG:(NSString *)imageStr;
@end