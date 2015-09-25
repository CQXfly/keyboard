//
//  UIImage+Color.h
//  网易彩票2014MJ版
//
//  Created by 崇庆旭  on 14-9-13.
//  Copyright (c) 2014年 崇庆旭  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Extend.h"

@interface UIImage (Color)

//给我一种颜色，一个尺寸，我给你返回一个UIImage:不透明
+(UIImage *)imageFromContextWithColor:(UIColor *)color;
+(UIImage *)imageFromContextWithColor:(UIColor *)color size:(CGSize)size;




- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;


/**
 *  图片裁圆（无边框）
 *  cut image into circle
 */
+(UIImage *)imageCutInToCircle:(NSString *)imageName;
/**
 *  图片裁圆（有边框）
 *  cut image into circle with border
 */
+(UIImage *)imageCutInToCircle:(NSString *)imageName withBorderWidth:(CGFloat)width color:(UIColor *)color;
/**
 *  图片添加水印图片
 *  add Logo to Image
 */
+(UIImage *)image:(NSString *)imageName addLOGO:(NSString *)logoName;
/**
 *  图片添加水印文字
 *  add text toImage
 */
+(UIImage *)image:(NSString *)imageName addText:(NSString *)text attributes:(NSDictionary *)attributes;
/**
 *  capture
 *  截屏
 */
+(UIImage *)captureImageFromLayer:(CALayer *)layer;

/**
 * 从中间裁剪一张图片
 */
+(instancetype)resizeImageWithImageName:(NSString *)name;

/**
 *  返回一张纯色图片
 *
 *  @param color 颜色
 *
 *  @param size  尺寸
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  图片抗锯齿，来自http://adad184.com/2015/08/31/image-rotate-with-antialiasing/
 *
 *  @return 添加了透明边的图片
 */
- (UIImage *)antiAlias;

@end
