//
//  QXPinViewController.m
//  keyboardDemo
//
//  Created by 崇庆旭 on 15/9/17.
//  Copyright © 2015年 崇庆旭. All rights reserved.
//

#import "QXPinViewController.h"
#import "QXWordsButton.h"



@interface QXPinViewController ()

//记录每个按钮的宽度
@property (nonatomic,assign) CGFloat btnWidth;

//记录最后一行最大Y值
@property (nonatomic,assign) CGFloat thirdBtnMaxY;
@end

@implementation QXPinViewController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor darkGrayColor];
    //创建各行按钮
    
    NSArray *firstArray = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"];
    NSArray *secondArray = @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"];
    NSArray *thirdArray = @[@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    
    
    CGFloat leftMargin = 3.0f;
    CGFloat middleMargin = 6.0f;
    CGFloat topMargin = 15.0f;

    
    [self addButtonsWithArray:firstArray withLeftMargin:leftMargin middleMargin:middleMargin topMargin:topMargin rowCount:1];
    
    [self addButtonsWithArray:secondArray withLeftMargin:(leftMargin + self.btnWidth / 2) middleMargin:middleMargin topMargin:topMargin rowCount:2];
    
    [self addButtonsWithArray:thirdArray withLeftMargin:(leftMargin + self.btnWidth*3 / 2 + middleMargin) middleMargin:middleMargin topMargin:topMargin rowCount:3];
    
    [self addButtonsWithArray:firstArray withLeftMargin:3.0f middleMargin:6.0f topMargin:15.0f rowCount:4];
    
    
    
}

- (void) addButtonsWithArray:(NSArray *)arrary withLeftMargin:(CGFloat )leftMargin middleMargin:(CGFloat) middleMargin topMargin:(CGFloat )topMargin rowCount:(NSInteger ) row
{
    
    NSInteger buttonsCount = arrary.count;
    CGFloat kWdith = self.view.frame.size.width;
    

    
    CGFloat width = (kWdith - 2*leftMargin - (buttonsCount - 1)*middleMargin) / buttonsCount;
    if (row == 1) {
         self.btnWidth = width;
    }
   
    CGFloat height = (216 - 4*topMargin - 1) / 4;
    for (int i = 0; i < arrary.count; i ++) {
        CGFloat btnX = leftMargin + (middleMargin + self.btnWidth)*i;
        CGFloat btnY = topMargin + (height + topMargin) *(row - 1);
        QXWordsButton *btn = [[QXWordsButton alloc] init];
        btn.frame = CGRectMake(btnX, btnY, self.btnWidth, height);
        [self.view addSubview:btn];
        
        NSString *title = arrary[i];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        
        [btn addTarget:self action:@selector(pinyinButtonClicked:) forControlEvents:UIControlEventTouchDown];
    }
}

- (void) pinyinButtonClicked:(QXWordsButton *)btn
{
    NSString *title = btn.titleLabel.text;
    
    if ([self.pinDelegate respondsToSelector:@selector(pinyinDelegateInputWithTitle:)]) {
        [self.pinDelegate pinyinDelegateInputWithTitle:title];
    }
    
    if ([title isEqualToString:@"q"]) {
        
        [self.pinDelegate pinyinDelegateAdvanceToNextInputMode];
    }
}



@end
