### 一款简单的倒计时按钮，支持回到home后，重新进入前台继续上次的倒计时，倒计时结束后自动销毁定时器。
### 使用方法：
```
/// 设置倒计时
/// @param seconds 时间，单位：秒
/// @param text 倒计时结束后显示的文字
- (void)cjw_startTimer:(NSInteger )seconds endTimerText:(NSString *)text;
```
#### 理论上来说是不用自己调用``` removeObserver ```方法，我内部会自动销毁了，如果你发现销毁不了那肯定是你的VC被其他东西循环引用销毁不了。
