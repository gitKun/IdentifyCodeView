//
//  DRIdentifyCodeView.h
//  验证码
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *    @author
 *
 *    @brief  验证码控件
 */
@interface DRIdentifyCodeView : UIView

@property(nonatomic,assign) NSInteger nLength;
@property(nonatomic,assign) BOOL bJustNumber;

/**
 *    @author
 *
 *    @brief  背景色
 */
@property(nonatomic,retain)UIColor *clBackground;
/**
 *    @author
 *
 *    @brief  初始化创建验证码控件
 *
 *    @param frame 显示区域
 *    @param nLen  验证码长度
 *    @param bJustNumber 仅仅数字验证码
 *
 *    @return DRIdentifyCodeView
 */
-(id)initWithFrame:(CGRect)frame andLen:(NSInteger)nLen bJustNumber:(BOOL)bJustNumber;
/**
 *    @author
 *
 *    @brief  刷新显示，重新显示验证码
 */
-(void)DRRefresh;
/**
 *    @author
 *
 *    @brief  校验输入的验证码是否正确
 *
 *    @param nsData 输入的验证码
 *
 *    @return 正确=TRUE
 */
-(BOOL)isValid:(NSString*)nsData;

- (NSString *)code;

@end
