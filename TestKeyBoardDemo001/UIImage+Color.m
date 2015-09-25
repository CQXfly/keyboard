//
//  UIImage+Color.m
//  网易彩票2014MJ版
//
//  Created by 崇庆旭  on 14-9-13.
//  Copyright (c) 2014年 崇庆旭  All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)


//给我一种颜色，一个尺寸，我给你返回一个UIImage
+(UIImage *)imageFromContextWithColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect=(CGRect){{0.0f,0.0f},size};
    
    //开启一个图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    //获取图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    //获取图像
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();

    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *)imageFromContextWithColor:(UIColor *)color{
    
    CGSize size=CGSizeMake(1.0f, 1.0f);
    
    return [self imageFromContextWithColor:color size:size];
}


- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+(UIImage *)imageCutInToCircle:(NSString *)imageName{
    //要裁圆的图片
    UIImage *image = [UIImage imageNamed:imageName];
    //图形上下文的尺寸就是图片的尺寸
    UIGraphicsBeginImageContextWithOptions(image.size, 0, 0.0);
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, image.size.width, image.size.height));
    //将当前的图形上下文剪切出来，后面的图形都会限制在这个圆中
    CGContextClip(ctx);
    //从0点开始画图
    [image drawAtPoint:CGPointMake(0, 0)];
    //获得当前图形上下文的图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return result;
}
+(UIImage *)imageCutInToCircle:(NSString *)imageName withBorderWidth:(CGFloat)borderWidth color:(UIColor *)color{
    //要裁圆的图片
    UIImage *image = [UIImage imageNamed:imageName];
    //边框的宽度，由传进来的参数决定
    CGFloat margin = borderWidth;
    //图形上下文的宽度 ＝ 图片的宽度 ＋ 2倍的边框宽度
    CGFloat width = 2*margin + image.size.width;
    //图形上下文的高度 ＝ 图片的高度 ＋ 2倍的边框宽度
    CGFloat height = 2*margin + image.size.height;
    //图形上下文的尺寸就是包括了边框的尺寸
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), 0, 0.0);
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画大圆，即边框所形成的圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, width, height));
    //设置边框的颜色，由传进来的参数决定
    [color set];
    //渲染这个圆，此时是一个设置的颜色的圆
    CGContextFillPath(ctx);
    //画小圆，即图片所形成的圆
    CGContextAddEllipseInRect(ctx, CGRectMake(margin, margin, image.size.width, image.size.height));
    //裁剪当前的图形上下文，
    CGContextClip(ctx);
    //为了不被边框挡住，所以要从x,y值都为边框宽度的点开始画图片
    [image drawAtPoint:CGPointMake(margin,margin)];
    //获得当前图形上下文的图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}

+(UIImage *)image:(NSString *)imageName addLOGO:(NSString *)logoName{
    //水印图片距离背景图片右下角x,y均＝10，根据需要自行更改
    CGFloat margin = 10;
    //背景图片
    UIImage *image = [UIImage imageNamed:imageName];
    //水印图片
    UIImage *logo = [UIImage imageNamed:logoName];
    //以背景图片的尺寸去开启图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, 0, 0.0);
    //背景图片就从0点开始画
    [image drawAtPoint:CGPointMake(0, 0)];
    //计算水印图片绘画时的起点的X值
    CGFloat width = image.size.width - logo.size.width - margin;
    //计算水印图片绘画时的起点的Y值
    CGFloat height = image.size.height - logo.size.height - margin;
    //画水印图片
    [logo drawAtPoint:CGPointMake(width, height)];
    //从当前的图形上下文获得图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}

+(UIImage *)image:(NSString *)imageName addText:(NSString *)text attributes:(NSDictionary *)attributes{
    //要处理的图片
    UIImage *image = [UIImage imageNamed:imageName];
    //水印文字
    NSString *string = text;
    //获得的图形上下文以图片的尺寸为准
    UIGraphicsBeginImageContextWithOptions(image.size, 0, 0.0);
    //画图
    [image drawAtPoint:CGPointMake(0, 0)];
    //把字添加到图形上下文，字体的属性需要传值
    [string drawAtPoint:CGPointMake(10, 10) withAttributes:attributes];
    //从当前的图形上下文获得图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}

+(UIImage *)captureImageFromLayer:(CALayer *)layer{
    //开启图形上下文，尺寸以要截的图层为准
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, 0, 0.0);
    //获得当前的图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //将要截的图层描绘到图形上下文上
    [layer renderInContext:ctx];
    //从当前的图形上下文得到图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}

//从中间裁剪一张图片
+(instancetype)resizeImageWithImageName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}
//颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = (CGRect){0,0,size};
    CGContextAddRect(ctx, rect);
    [color set];
    CGContextFillRect(ctx, rect);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

//抗锯齿
- (UIImage *)antiAlias {
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border,border,self.size.width - 2*border,self.size.height - 2*border);
    UIImage *img = nil;
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [self drawInRect:CGRectMake(-1,-1,self.size.width,self.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage *antiImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return antiImg;
}

@end
