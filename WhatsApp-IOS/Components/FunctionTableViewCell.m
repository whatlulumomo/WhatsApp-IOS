//
//  FunctionTableViewCell.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/18/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "FunctionTableViewCell.h"

@implementation FunctionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID = reuseIdentifier;
        
        _avatarImageView = UIImageView.new;
//        [_avatarImageView setBackgroundColor: UIColor.redColor];
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
        
        [self.contentView addSubview: _avatarImageView];
        [self.contentView addSubview: _nameLabel];
        
        NSDictionary *binding = @{
            @"avatar" : self.avatarImageView,
            @"name" : self.nameLabel
        };
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[avatar(==50)]-20-[name(>=100)]" options:0 metrics:nil views:binding]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-11-[avatar(==50)]-11-|" options:0 metrics:nil views:binding]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[name(==30)]-21-|" options:NSLayoutFormatAlignAllLeading metrics:nil views:binding]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
