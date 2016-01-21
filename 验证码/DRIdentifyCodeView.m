//
//  DRIdentifyCodeView.m
//  验证码
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "DRIdentifyCodeView.h"

const CGFloat DRFontSize = 26.0;

@interface DRIdentifyCodeView ()

/**
 *    @author
 *
 *    @brief  点击手势
 */
@property(nonatomic,retain) UITapGestureRecognizer *tap;
/**
 *    @author
 *
 *    @brief  生成的验证码
 */
@property(nonatomic,retain) NSString *nsCode;
@end
@implementation DRIdentifyCodeView
//考虑到 sb 关联 用此方法初始化
-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        if (_tap == nil) {
            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DRRefresh)];
            [self addGestureRecognizer:_tap];
        }
        _nLength = _nLength?:5;
    }
    return self;
}
//-(id)initWithFrame:(CGRect)frame {
//    if ([super initWithFrame:frame]) {
//        if (_tap == nil) {
//            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DRRefresh)];
//            [self addGestureRecognizer:_tap];
//        }
//        _nLength = 5;
//        _bJustNumber = NO;
//    }
//    return self;
//}
-(id)initWithFrame:(CGRect)frame andLen:(NSInteger)nLen bJustNumber:(BOOL)bJustNumber
{
    if ([self initWithFrame:frame])
    {
        _nLength = nLen;
        _bJustNumber = bJustNumber;
    }
    return self;
}
-(void)DRRefresh {
    if (self.clBackground) {
        [self setBackgroundColor:self.clBackground];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //下面是创建 随机 数字或 字母 作为 验证码，实际过程中也可以直接传入 str 作为验证码 来绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    char data[_nLength];
    for (NSInteger x = 0; x < _nLength; x++) {
        if (_bJustNumber) {
            //int j = '0' + (arc4random_uniform(10));
            int j = '0' + (arc4random()%10);
            data[x] = (char)j;
        } else {
            int j = '0' + (arc4random_uniform(75));
            if((j >= 58 && j <= 64) || (j >= 91 && j <= 96)) {
                --x;
            } else {
                data[x] = (char)j;
            }
        }
    }
    NSString *text = [[NSString alloc] initWithBytes:data length:_nLength encoding:NSUTF8StringEncoding];
    self.nsCode = text;
    //下面的 fontSize 也可以自定义传入\*也可以改写为根据 _nLength 和 CGRectGetWidth(rect) 来自动调整 字体的大小*\//
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:DRFontSize]}];
    int width = self.frame.size.width / (text.length) - cSize.width;
    int height = self.frame.size.height - cSize.height;
    CGPoint point;
    float pX, pY;
    for (NSInteger i = 0, count = text.length; i < count; i++) {
        pX = arc4random() % width + self.frame.size.width / text.length * i - 1;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        float red = arc4random() % 256 / 255.0;
        float green = arc4random() % 201 / 255.0;
        float blue = arc4random() % 256 / 255.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//        CGContextSetStrokeColorWithColor(context, color.CGColor);
//        CGContextSetFillColorWithColor(context, color.CGColor);
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        
        [textC drawInRect:CGRectMake(pX + (self.frame.size.width/_nLength - cSize.width) / 2, pY, self.frame.size.width / 4, self.frame.size.height) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:DRFontSize],NSForegroundColorAttributeName:color}];
    }
    
    // 干扰线
    CGContextSetLineWidth(context, .5f);
    
    CGFloat  lengths[] = {arc4random()%3,arc4random()%5,arc4random()%7,arc4random()%3,arc4random()%4};
    CGContextSetLineDash(context, 0, lengths, 5);
    for(int i = 0; i < 8; i++) {
        float red = arc4random() % 101 / 100.0;
        float green = arc4random() % 101 / 100.0;
        float blue = arc4random() % 101 / 100.0;
        UIColor* color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        float pX = arc4random() % (int)self.frame.size.width;
        float pY = arc4random() % (int)self.frame.size.height;
        CGContextMoveToPoint(context, pX, pY);
        float pXE = arc4random() % (int)self.frame.size.width;
        float pYE = arc4random() % (int)self.frame.size.height;
        CGContextAddLineToPoint(context, pXE, pYE);
        CGContextStrokePath(context);
    }
    return;
}

-(BOOL)isValid:(NSString *)nsData {
    if (nsData.length <= 0)
        return FALSE;
    if ([self.nsCode caseInsensitiveCompare:nsData] == NSOrderedSame)
        return TRUE;
    return FALSE;
}
- (NSString *)code {
    return self.nsCode;
}

@end