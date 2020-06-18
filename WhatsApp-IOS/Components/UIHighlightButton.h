//
//  UIHighlightButton.h
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/16/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIHighlightButton : UIButton
@property (strong, nonatomic) UIColor* normalColor;
@property (strong, nonatomic) UIColor* highlightMaskColor;
@property CGRect boundSize;
@property BOOL rounded;
@end

NS_ASSUME_NONNULL_END
