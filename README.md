# DDCardView


## Example

类似qq卡片封装的双面卡片view，可设置正反双面，点击产生翻面动画，卡片自带阴影和圆角<br>
***一行代码即可生成想要的双面动效卡片view***

# ![img](https://github.com/DDstrongman/DDCardView/blob/master/github.gif)

instance函数：

```objective-c
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
                     tapBlock:(void(^)(BOOL isBack,UIView *tapView))tapBlock
```

***举个栗子：***

```objective-c
    UIView *test = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    test.backgroundColor = [UIColor blackColor];
    
    UIView *testTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    testTwo.backgroundColor = [UIColor blackColor];
    
    
    DDCardView *testCard = [[DDCardView alloc]initWithFrame:CGRectMake(10, 10, 200, 200) 
                            													front:test 
                           														 back:testTwo 
                          												  tapBlock:^(BOOL isBack, UIView * _Nonnull tapView) {
        
   																								 }];
    [self.view addSubview:testCard];
```



## Requirements

直接加载网络url依赖于SDWebimage

## Installation

HttpSupportSpec is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DDCardView'
```

## Author

DDStrongman, lishengshu232@gmail.com

## License

DDCardView is available under the MIT license. See the LICENSE file for more info.
