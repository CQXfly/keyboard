//
//  QXPinViewController.h
//  keyboardDemo
//
//  Created by 崇庆旭 on 15/9/17.
//  Copyright © 2015年 崇庆旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pinyinDelegate <NSObject>

@optional

- (void) pinyinDelegateInputWithTitle:(NSString *)title;

- (void) pinyinDelegateAdvanceToNextInputMode;

- (void) pinyinDelegateDelete;

@end

@interface QXPinViewController : UIViewController

@property (nonatomic,weak) id pinDelegate;

@end
