//
//  CJWTimerButton.m
//  HRM-iOS
//
//  Created by Chenjw on 2019/11/4.
//  Copyright © 2019 com.bonade.HRM-iOS. All rights reserved.
//

#import "CJWTimerButton.h"
@interface CJWTimerButton()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, copy) NSString *endTimerText;
@property (nonatomic, assign) NSTimeInterval lasetTimeInterval;
@end

@implementation CJWTimerButton

- (void)removeObserver{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)addObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationWillEnterForeground{
    if (!self.timer || self.seconds <= 0) {
        return;
    }
    
    NSTimeInterval newTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval reduse = newTime - self.lasetTimeInterval;

    if (self.seconds - reduse < 0) {
        [self setTitle:self.endTimerText forState:0];
        self.userInteractionEnabled = YES;
    }else{
        [self countDown];
    }
    
}

- (void)applicationDidEnterBackground{
    self.lasetTimeInterval = [[NSDate date] timeIntervalSince1970];
}


- (void)cjw_startTimer:(NSInteger )seconds endTimerText:(NSString *)text{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.seconds = seconds;
        self.endTimerText = text;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self  selector:@selector(countDown ) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
        
        
    });
    
    [self addObserver];
}

- (void)countDown{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        self.seconds -=1;
        if (self.seconds>0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = NO;
                [self setTitle:NSStringFormat(@"%zd",self.seconds) forState:0];
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:self.endTimerText forState:0];
                self.userInteractionEnabled = YES;
            });
            
            [self.timer invalidate];
            self.timer = nil;
        }

    });
    
}

@end
