//
//  ChatTableViewCell.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/15/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID = reuseIdentifier;
//        [self setBackgroundColor: UIColor.blueColor];
        
        UIImageView *avatarImageView = UIImageView.new;
        [avatarImageView setBackgroundColor: UIColor.redColor];
        [avatarImageView setContentMode: UIViewContentModeScaleAspectFit];
        [avatarImageView setExclusiveTouch: YES];
        [avatarImageView.layer setCornerRadius: 25];
        [avatarImageView setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        [self.contentView addSubview: avatarImageView];
        
//        NSDictionary *views = NSDictionaryOfVariableBindings(avatarImageView);
//        NSArray *horizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[avatarImageView]-20-|" options:0 metrics:nil views:views];
//        NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[avatarImageView]-20-|" options:0 metrics:nil views:views];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem: avatarImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:50];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem: avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:50];
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant: 20];
//        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant: 0];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant: 15];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant: -15];
//        [self.contentView addConstraints: horizontalConstraints];
//        [self.contentView addConstraints: verticalConstraints];
        [self.contentView addConstraints:@[widthConstraint, heightConstraint, leadingConstraint, topConstraint, bottomConstraint]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
