//
//  UIButton+xxx.m
//  bottom
//
//  Created by Kuo-HsunShih on 2016/1/15.
//  Copyright © 2016年 funtek. All rights reserved.
//

#import "UIButton+xxx.h"
#import <objc/runtime.h>
@implementation UIButton (xxx)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIButton switchInstanceMethodFrom:@selector(touchesBegan:withEvent:)
                                        To:@selector(replacedTouchesBegan:withEvent:)];
        
    });
    
}

#pragma mark - Method swizzling

+ (void)switchInstanceMethodFrom:(SEL)from To:(SEL)to {
    Method fromMethod = class_getInstanceMethod(self, from);
    Method toMethod   = class_getInstanceMethod(self, to);
    method_exchangeImplementations(fromMethod, toMethod);
}

- (void)replacedTouchesBegan:(NSSet <UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self replacedTouchesBegan:touches withEvent:event];
    
    NSLog(@"new action");
    
    [self toGreen];
}

- (void)toGreen {
    if (self.backgroundColor == [UIColor redColor]) {
        self.backgroundColor = [UIColor greenColor];
    } else {
        self.backgroundColor = [UIColor redColor];
    }
}

@end
