//
//  MAOpenCV.h
//  instaoverlay
//
//  Created by Maximilian Mackh on 11/10/12.
//  Copyright (c) 2012 mackh ag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <opencv2/core/core.hpp>
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/imgproc/imgproc.hpp>




@interface MAOpenCV : NSObject

+ (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;

+ (cv::Mat)cvMatFromAdjustedUIImage:(UIImage *)image;
+ (cv::Mat)cvMatFromUIImage:(UIImage *)image;
+ (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image;
+ (cv::Mat)cvMatGrayFromAdjustedUIImage:(UIImage *)image;

@end
