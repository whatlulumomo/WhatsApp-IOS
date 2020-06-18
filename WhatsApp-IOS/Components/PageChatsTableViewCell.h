//
//  PageChatsTableViewCell.h
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/18/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageChatsTableViewCell : UITableViewCell {
    NSString *reuseID;
}

@property UIImageView *avatarImageView;
@property UILabel *nameLabel;
@property UILabel *messageLabel;
@property UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
