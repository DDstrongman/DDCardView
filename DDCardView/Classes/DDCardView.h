//
//  DDCardView.h
//  ThousandsWords
//
//  Created by DDLi on 2019/5/17.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCardView : UIView


@property (nonatomic, assign) BOOL isBack;///< 正面还是反面，默认0为正面，1为反面，设置会触发翻面

@property (nonatomic, assign) BOOL canNotTap;///< 是否可以响应点击，默认0为可以，1为不可以

@property (nonatomic, assign) BOOL canNotTurn;///< 是否可以翻转，默认0为可以，1为不可以

@property (nonatomic, assign) BOOL panOrSwipeBack;///< 是否正处于pan状态，此状态下要把背面图片变回去，否则会变成反的。在

@property (nonatomic, assign) BOOL showCornor;///< 是否显示阴影和圆角

@property (nonatomic, strong) id front;///< 卡片正面，可以传入image,string或者view
@property (nonatomic, strong) id back;///< 卡片背面，可以传入image,nil,string或者view

@property (nonatomic, copy) void(^tapCardBlock)(BOOL isBack,UIView *view);///< 点击卡片的block

@property (nonatomic, copy) NSString *backImageUrl;///< 卡片背面解释的背景图url
@property (nonatomic, copy) NSString *backCharacterUrl;///< 卡片背面解释的文字图url

/**
 生成双面cardView

 @param frame frame
 @param front 正面，可以传入image,string或者view
 @param back 反面，可以传入image,string,nil或者view
 @param tapBlock 点击block,处理翻转，传回idBack状态和view
 @return 返回生成的双面cardview
 */
- (instancetype)initWithFrame:(CGRect)frame
                        front:(__nonnull id)front
                         back:(__nullable id)back
                     tapBlock:(void(^)(BOOL isBack,UIView *tapView))tapBlock;

- (void)resetResultView;///< 将结果显示的图片重置

- (void)resetCardView;///< 重置前后卡片view

@end

NS_ASSUME_NONNULL_END
