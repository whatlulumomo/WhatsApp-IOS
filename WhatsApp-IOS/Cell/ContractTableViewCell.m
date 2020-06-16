//
//  ChatTableViewCell.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/15/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "ContractTableViewCell.h"

NSArray<NSLayoutConstraint *> *allConstraints;

@implementation ContractTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID = reuseIdentifier;
        allConstraints = NSArray.new;
//        [self setBackgroundColor: UIColor.blueColor];
        
        _avatarImageView = UIImageView.new;
        [_avatarImageView setBackgroundColor: UIColor.redColor];
        [_avatarImageView.layer setMasksToBounds: YES];
        [_avatarImageView setContentMode: UIViewContentModeScaleAspectFit];
//        [_avatarImageView setExclusiveTouch: YES];
        [_avatarImageView.layer setCornerRadius: 25];
        [_avatarImageView setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        _nameLabel = UILabel.new;
        _nameLabel.text = @"BestOreo";
        [_nameLabel setTextColor: UIColor.blackColor];
        [_nameLabel sizeToFit];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        [_nameLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        _messageLabel = UILabel.new;
        _messageLabel.text = @"Hey there! I'm using Whatsapp.";
        [_messageLabel setTextColor: [UIColor colorWithRed:89/255.0 green:94/255.0 blue:98/255.0 alpha:1]];
        [_messageLabel sizeToFit];
        [_messageLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        [self.contentView addSubview: _avatarImageView];
        [self.contentView addSubview: _nameLabel];
        [self.contentView addSubview: _messageLabel];
        
        NSDictionary *binding = @{
            @"avatar" : self.avatarImageView,
            @"name" : self.nameLabel,
            @"message" : self.messageLabel
        };
        
//        NSDictionary *metrics = @{@"height" : @(self.height)};
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[avatar(==50)]-20-[name(>=100)]" options:0 metrics:nil views:binding]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[avatar(==50)]-15-|" options:0 metrics:nil views:binding]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[name(==20)]-4-[message(==20)]-18-|" options:NSLayoutFormatAlignAllLeading metrics:nil views:binding]];


//        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem: _avatarImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:50];
//        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem: _avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:50];
//        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:_avatarImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant: 20];
//        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_avatarImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant: 15];
//        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_avatarImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant: -15];
//        [self.contentView addConstraints:@[widthConstraint, heightConstraint, leadingConstraint, topConstraint, bottomConstraint]];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
