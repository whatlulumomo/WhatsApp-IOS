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
    if(_normalColor == nil || _highlightMaskColor == nil){
        if (highlighted) {
            self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
        } else {
            self.backgroundColor = [UIColor colorWithRed:6/255.0 green:95/255.0 blue:84/255.0 alpha:1.0];
        }
    }else{
        // init mask view
        if(_maskview == nil){
            self.backgroundColor = _normalColor;
            if(CGRectIsEmpty(_boundSize)){
                _boundSize = self.bounds;
            }
            _maskview = [[UIView alloc]initWithFrame:CGRectMake(_boundSize.size.width/2, _boundSize.size.height/2, 0, 0)];
            [_maskview setBackgroundColor:_highlightMaskColor];
            if(self.rounded){
                _maskview.layer.cornerRadius = 0;
            }
            [self addSubview:_maskview];
        }
        if (highlighted) {
            [UIView animateWithDuration:0.15 animations:^{
                [self.maskview setFrame:CGRectMake(0, 0, self.boundSize.size.width, self.boundSize.size.height)];
                if(self.rounded){
                    self.maskview.layer.cornerRadius = self.boundSize.size.width/2;
                }
            }];
        } else {
            [UIView animateWithDuration:0.15 animations:^{
                [self->_maskview setFrame:CGRectMake(self.boundSize.size.width/2, self.boundSize.size.height/2, 0, 0)];
                if(self.rounded){
                    self->_maskview.layer.cornerRadius = 0;
                }
            }];
        }
    }
}

@end
