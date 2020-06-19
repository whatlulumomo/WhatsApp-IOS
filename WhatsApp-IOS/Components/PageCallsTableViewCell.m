//
//  PageCallsTableViewCell.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/18/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "PageCallsTableViewCell.h"
#import "Color.h"

@implementation PageCallsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID = reuseIdentifier;
        
        _avatarImageView = UIImageView.new;
        [_avatarImageView.layer setMasksToBounds: YES];
        [_avatarImageView setContentMode: UIViewContentModeScaleAspectFit];
        [_avatarImageView.layer setCornerRadius: 25];
        [_avatarImageView setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        _nameLabel = UILabel.new;
        _nameLabel.text = @"BestOreo";
        [_nameLabel setTextColor: UIColor.blackColor];
        [_nameLabel sizeToFit];
        _nameLabel.font = [UIFont boldSystemFontOfSize:19];
        [_nameLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        _timeLabel = UILabel.new;
        _timeLabel.text = @"Hey there! I'm using Whatsapp.";
        [_timeLabel setTextColor: MessageGrayColor];
        [_timeLabel setFont: [UIFont systemFontOfSize:16]];
        [_timeLabel sizeToFit];
        [_timeLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        _callTypeLabel = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
        _callTypeLabel.image = [[UIImage imageNamed:@"videocall"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
        [_callTypeLabel setTintColor: DarkTealGreenColor];
        [_callTypeLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        _inOutLabel = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 14)];
        _inOutLabel.image = [[UIImage imageNamed:@"incall"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
        [_inOutLabel setTintColor: LightGreenColor];
        [_inOutLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        _seperateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_seperateLine setBackgroundColor: [UIColor colorWithDisplayP3Red:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [_seperateLine setTranslatesAutoresizingMaskIntoConstraints: NO];
        [_seperateLine.layer setZPosition: 1];
        
        [self.contentView addSubview: _avatarImageView];
        [self.contentView addSubview: _nameLabel];
        [self.contentView addSubview: _timeLabel];
        [self.contentView addSubview: _callTypeLabel];
        [self.contentView addSubview: _seperateLine];
        [self.contentView addSubview: _inOutLabel];
        
        NSDictionary *binding = @{
            @"avatar" : self.avatarImageView,
            @"name" : self.nameLabel,
            @"time" : self.timeLabel,
            @"call": self.callTypeLabel,
            @"seperate": self.seperateLine
        };
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[avatar(==50)]-20-[name(>=100)]" options:0 metrics:nil views:binding]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[call(==24)]-20-|" options:0 metrics:nil views:binding]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[avatar(==50)]-15-|" options:0 metrics:nil views:binding]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[name(==20)]-4-[time(==20)]-18-|" options:0 metrics:nil views:binding]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_callTypeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_callTypeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:24]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_inOutLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_inOutLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_timeLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_inOutLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:14]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_inOutLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:14]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timeLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_inOutLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timeLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-20]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_seperateLine attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_seperateLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_seperateLine attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_timeLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_seperateLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:1]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
