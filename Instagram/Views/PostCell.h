//
//  PostCell.h
//  Instagram
//
//  Created by ezietz on 7/9/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userText;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *captionText;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
