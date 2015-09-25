//
//  QXWordsButton.m
//  keyboardDemo
//
//  Created by 崇庆旭 on 15/9/18.
//  Copyright © 2015年 崇庆旭. All rights reserved.
//

#import "QXWordsButton.h"

@implementation QXWordsButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
    }
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}

- (void)setUp{
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
