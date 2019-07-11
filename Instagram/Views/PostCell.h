//
//  PostCell.h
//  Instagram
//
//  Created by ezietz on 7/9/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@protocol PostCellDelegate;

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userText;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *captionText;
@property (strong, nonatomic) Post *post;
@property (nonatomic, weak) id<PostCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

- (void) didTapUserProfile:(UITapGestureRecognizer *) sender;
@end

@protocol PostCellDelegate
- (void)postCell:(PostCell *)postCell didTap: (PFUser *) user;
@end
