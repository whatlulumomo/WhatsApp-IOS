//
//  UIHighlightButton.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/16/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "UIHighlightButton.h"

@implementation UIHighlightButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    } else {
        self.backgroundColor = [UIColor colorWithRed:6/255.0 green:95/255.0 blue:84/255.0 alpha:1.0];
    }
}

@end
