//
//  UIHighlightButton.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/16/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "UIHighlightButton.h"

@interface UIHighlightButton()
@property UIView* maskview;
@end

@implementation UIHighlightButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(_normalColor == nil || _highlightColor == nil){
        if (highlighted) {
            self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
        } else {
            self.backgroundColor = [UIColor colorWithRed:6/255.0 green:95/255.0 blue:84/255.0 alpha:1.0];
        }
    }else{
        // init mask view
        if(_maskview == nil){
            _maskview = [[UIView alloc]initWithFrame:CGRectMake(30, 30, 0, 0)];
            [_maskview setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
            _maskview.layer.cornerRadius = 0;
            [self addSubview:_maskview];
        }
        if (highlighted) {
            [UIView animateWithDuration:0.15 animations:^{
                [self->_maskview setFrame:CGRectMake(0, 0, 60, 60)];
                self->_maskview.layer.cornerRadius = 30;
            }];
        } else {
            [UIView animateWithDuration:0.15 animations:^{
                [self->_maskview setFrame:CGRectMake(30, 30, 0, 0)];
                self->_maskview.layer.cornerRadius = 0;
            }];
        }
    }
}

@end
