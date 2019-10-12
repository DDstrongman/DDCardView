//
//  DDCardView.m
//  ThousandsWords
//
//  Created by DDLi on 2019/5/17.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "DDCardView.h"

#import "UIView+DDExtension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DDCardView ()

{
    UITapGestureRecognizer *tap;///< 卡片点击手势
}

@property (nonatomic, strong) UIView *cardFront;///< 卡片正面view
@property (nonatomic, strong) UIView *cardBack;///< 卡片背部view
@property (nonatomic, strong) UIImageView *cardBackImage;///< 卡片背部组合动画的图
@property (nonatomic, strong) UIImageView *cardBackCharacter;///< 卡片背部组合动画的字
@property (nonatomic, strong) UIImageView *resultImg;///< 配合显示结果的图片view

@end

@implementation DDCardView

- (instancetype)initWithFrame:(CGRect)frame
                        front:(id)front
                         back:(id)back
                     tapBlock:(void(^)(BOOL isBack,UIView *tapView))tapBlock {
    if (self = [super initWithFrame:frame]) {
        _tapCardBlock = tapBlock;
        self.back = back;
        self.front = front;
        // 设置阴影
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.15;
        self.layer.shadowRadius = 20;
        self.userInteractionEnabled = YES;
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
        [self addGestureRecognizer:tap];
        
        [self addSubview:self.resultImg];
    }
    return self;
}

- (void)resetResultView {
    self.resultImg.frame = CGRectMake(0, self.bottom, self.width, 0);
}

- (void)resetCardView {
    _cardFront.frame = CGRectMake(0, 0, self.width, self.height);
    _cardBack.frame = CGRectMake(0, 0, self.width, self.height);
}
#pragma mark - lazyLoading
- (void)setIsBack:(BOOL)isBack {
    if (_isBack != isBack) {
        _isBack = isBack;
        [self rotate];
        if (_isBack) {
            self.layer.shadowOpacity = 0;
            self.layer.shadowRadius = 0;
        } else {
            self.layer.shadowOpacity = 0.15;
            self.layer.shadowRadius = 20;
        }
    }
}

- (void)setCanNotTap:(BOOL)canNotTap {
    if (_canNotTap != canNotTap) {
        _canNotTap = canNotTap;
        if (_canNotTap) {
            [self removeGestureRecognizer:tap];
        } else {
            if (![self.gestureRecognizers containsObject:tap]) {
                [self addGestureRecognizer:tap];
            }
        }
    }
}

- (void)setFront:(id)front {
    if (_front != front) {
        _front = front;
        // 牌的正面
        if (!_cardFront) {
            _cardFront = [[UIView alloc] initWithFrame:CGRectMake(_cardBack.x, _cardBack.y, _cardBack.width, _cardBack.height)];
            _cardFront.backgroundColor = [UIColor whiteColor];
            _cardFront.layer.cornerRadius = 15;
            _cardFront.clipsToBounds = YES;
            [self addSubview:_cardFront];
        }
        [[_cardFront subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if ([_front isKindOfClass:[UIImage class]]) {
            UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _cardFront.width, _cardFront.height)];
            backImg.contentMode = UIViewContentModeCenter;
            backImg.image = _front;
            [_cardFront addSubview:backImg];
        } else if ([_front isKindOfClass:[UIView class]]) {
            [_cardFront addSubview:_front];
        } else if ([_front isKindOfClass:[NSString class]]) {
            UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _cardFront.width, _cardFront.height)];
            [_cardFront addSubview:backImg];
            UILabel *text = [[UILabel alloc]initWithFrame:_cardBack.frame];
            text.textAlignment = NSTextAlignmentCenter;
            if (self.width > 200) {
                text.font = [UIFont fontWithName:@"FZKTJW--GB1-0" size:200.0];
                backImg.image = [UIImage imageNamed:@"tian_big"];
                backImg.frame = CGRectMake(0, 0, _cardFront.width, _cardFront.width);
                text.frame = backImg.frame;
            } else {
                if (self.width > 100) {
                    text.font = [UIFont fontWithName:@"FZKTJW--GB1-0" size:100.0];
                } else {
                    backImg.image = [UIImage imageNamed:@"img_tian_class_small"];
                    text.font = [UIFont fontWithName:@"FZKTJW--GB1-0" size:34.0];
                }
            }
            text.textColor = [UIColor blackColor];
            text.text = _front;
            [_cardFront addSubview:text];
        } else {
            NSLog(@"=========正面错误添加type=========");
        }
    }
}

- (void)setBack:(id)back {
    if (_back != back) {
        _back = back;
        if (!_cardBack) {
            // 牌的背面
            _cardBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            _cardBack.layer.cornerRadius = 15;
            _cardBack.clipsToBounds = YES;
            _cardBack.backgroundColor = [UIColor whiteColor];
            [self addSubview:_cardBack];
        }
        [[_cardBack subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if ([_back isKindOfClass:[UIImage class]]) {
            UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _cardBack.width, _cardBack.height)];
            [_cardBack addSubview:backImg];
            backImg.image = _back;
        } else if ([_back isKindOfClass:[UIView class]]) {
            [_cardBack addSubview:_back];
            _cardBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -self.height, self.width, self.width)];
            _cardBackImage.contentMode = UIViewContentModeScaleAspectFit;
            _cardBackCharacter = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height, self.width, self.width)];
            _cardBackCharacter.contentMode = UIViewContentModeScaleAspectFit;
            [_cardBack addSubview:_cardBackImage];
            [_cardBack addSubview:_cardBackCharacter];
        } else if ([_back isKindOfClass:[NSString class]]) {
            UILabel *text = [[UILabel alloc]initWithFrame:_cardBack.frame];
            text.textAlignment = NSTextAlignmentCenter;
            text.text = _back;
            [_cardBack addSubview:text];
        } else {
            NSLog(@"=========背面错误添加type=========");
        }
        _cardBack.hidden = YES;
    }
}

- (void)setShowCornor:(BOOL)showCornor {
    _showCornor = showCornor;
    if (_showCornor) {
        // 设置阴影
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.15;
        self.layer.shadowRadius = 20;
        _cardFront.layer.cornerRadius = 15;
        _cardFront.clipsToBounds = YES;
        _cardBack.layer.cornerRadius = 15;
        _cardBack.clipsToBounds = YES;
    } else {
        // 设置阴影
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0;
        self.layer.shadowRadius = 0;
        _cardFront.layer.cornerRadius = 0;
        _cardFront.clipsToBounds = NO;
        _cardBack.layer.cornerRadius = 0;
        _cardBack.clipsToBounds = NO;
    }
}

- (void)setTapCardBlock:(void (^)(BOOL, UIView * _Nonnull))tapCardBlock {
    if (tapCardBlock) {
        _tapCardBlock = tapCardBlock;
        [self removeGestureRecognizer:tap];
        [self addGestureRecognizer:tap];
    }
}

- (void)setPanOrSwipeBack:(BOOL)panOrSwipeBack {
    _panOrSwipeBack = panOrSwipeBack;
    if (_panOrSwipeBack) {
        _cardBack.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
    }
}

- (void)setBackImageUrl:(NSString *)backImageUrl {
    _backImageUrl = backImageUrl;
    [_cardBackImage sd_setImageWithURL:[NSURL URLWithString:_backImageUrl] placeholderImage:[UIImage imageNamed:@"empty"]];
}

- (void)setBackCharacterUrl:(NSString *)backCharacterUrl {
    _backCharacterUrl = backCharacterUrl;
    [_cardBackCharacter sd_setImageWithURL:[NSURL URLWithString:_backCharacterUrl] placeholderImage:[UIImage imageNamed:@"empty"]];
}

- (UIImageView *)resultImg {
    if (!_resultImg) {
        _resultImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bottom, self.width, 0)];
        [_resultImg.layer setMasksToBounds:YES];
        [_resultImg.layer setCornerRadius:15.0];
    }
    return _resultImg;
}
#pragma mark - methods
- (void)rotate {
    _cardBack.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    CATransform3D  transform = CATransform3DIdentity;
    transform.m34 = 4.5/-2000;
    _cardBack.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.isBack) {
            self.layer.transform = CATransform3DRotate(transform,M_PI, 0, 1, 0);
        } else {
            self.layer.transform = CATransform3DRotate(transform,0, 0, 1, 0);
        }
        self.cardBack.hidden = !self.isBack;
        self.cardFront.hidden = self.isBack;
    } completion:^(BOOL finished) {
        if (self.isBack) {
            self.cardBackImage.hidden = NO;
            if (self.width > 200) {
                ((UIView *)self.back).hidden = YES;
            }
            [UIView animateWithDuration:1.0 animations:^{
                self.cardBackImage.frame = CGRectMake(0, 0, self.width, self.width);
            } completion:^(BOOL finished) {
                self.cardBackCharacter.hidden = NO;
                [UIView animateWithDuration:1.2 animations:^{
                    self.cardBackCharacter.frame = CGRectMake(0, 0, self.width, self.width);
                } completion:^(BOOL finished) {
                    ((UIView *)self.back).hidden = NO;
                    self.cardBackImage.frame = CGRectMake(0, -self.height, self.width, self.width);
                    self.cardBackCharacter.frame = CGRectMake(0, self.height, self.width, self.width);
                    self.cardBackCharacter.hidden = YES;
                    self.cardBackImage.hidden = YES;
                }];
            }];
        }
    }];
}

- (void)tapGes:(UITapGestureRecognizer *)sender {
    if (!_canNotTurn) {
        self.isBack = !_isBack;
    }
    if (_tapCardBlock) {
        _tapCardBlock(_isBack,self);
    }
}

@end
