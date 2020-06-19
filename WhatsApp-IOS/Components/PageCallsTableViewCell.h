//
//  PageCallsTableViewCell.h
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/18/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageCallsTableViewCell : UITableViewCell {
    NSString *reuseID;
}

@property UIImageView *avatarImageView;
@property UILabel *nameLabel;
@property UILabel *timeLabel;
@property UIImageView *inOutLabel;
@property UIImageView *callTypeLabel;
@property UIView *seperateLine;

@end

NS_ASSUME_NONNULL_END
