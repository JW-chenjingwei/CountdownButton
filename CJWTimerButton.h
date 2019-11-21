//
//  CJWTimerButton.h
//  HRM-iOS
//
//  Created by Chenjw on 2019/11/4.
//  Copyright © 2019 com.bonade.HRM-iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJWTimerButton : UIButton

/// 设置倒计时
/// @param seconds 时间，单位：秒
/// @param text 倒计时结束后显示的文字
- (void)cjw_startTimer:(NSInteger )seconds endTimerText:(NSString *)text;

- (void)removeObserver;
@end

NS_ASSUME_NONNULL_END
