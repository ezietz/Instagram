//
//  PostCell.m
//  Instagram
//
//  Created by ezietz on 7/9/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImage addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImage setUserInteractionEnabled:YES];
}
                                                           
- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate postCell:self didTap:self.post.author];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)didTapLike:(id)sender {
    PFUser *user = [PFUser currentUser];
    NSArray *likeArray = [[NSArray alloc]init];
    likeArray = [self.post objectForKey:@"likeArray"];
    NSString *username = [user objectForKey:@"username"];
    if (![likeArray containsObject:user.username]){
        NSLog(@"Successfully favorited!");
        [self.favoriteButton setSelected:YES];
        [self.post addObject:username forKey:@"likeArray"];
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        }];
        likeArray = [self.post objectForKey:@"likeArray"];
        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long) likeArray.count];
        self.countIncrement.text = likeCount;
    }
    else{
        NSLog(@"Successfully unfavorited!");
        [self.favoriteButton setSelected:NO];
        NSString *username = user.username;
        [self.post removeObject:username forKey:@"likeArray"];
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
        }];
        likeArray = [self.post objectForKey:@"likeArray"];
        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long) likeArray.count];
        self.countIncrement.text = likeCount;
    }
}

@end
