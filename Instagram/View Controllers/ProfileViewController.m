//
//  ProfileViewController.m
//  Instagram
//
//  Created by ezietz on 7/10/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "PostCollectionViewCell.h"
#import <Parse/Parse.h>
#import "TimelineViewController.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *postArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *numPosts;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.alwaysBounceVertical = YES;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);

    if (self.user == nil)
    {
        self.user = [PFUser currentUser]; // from Parse API
    }
    PFFileObject *image = [self.user objectForKey:@"image"];
    
//    cell.profileImage.image = [UIImage imageWithData:data];
//    cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.height/2;
//    cell.profileImage.clipsToBounds = YES;
//    
    
    self.profileView.layer.cornerRadius = self.profileView.frame.size.height/2;
    self.profileView.clipsToBounds = YES;
    
    [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!data){
            return NSLog(@"%@", error);
    }
        self.profileView.image = [UIImage imageWithData:data];
    }];
    
    self.username.text = self.user.username;
    self.navigationItem.title = [NSString stringWithFormat:@"@%@", self.user.username];
}

- (void) fetchPosts{
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:self.user];
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.postArray = posts;
            [self.collectionView reloadData];
        }
        else {
            NSLog(@"Error");
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.profileView.image = originalImage;
    self.profileView.image = editedImage;
    NSData *imageData = UIImageJPEGRepresentation(editedImage, 1);
    PFFileObject *imageFile = [PFFileObject fileObjectWithName:@"image.png" data: imageData];
    [imageFile saveInBackground];
    [self.user setObject:imageFile forKey:@"image"];
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickedEditProfile:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    //    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    Post *post = self.postArray[indexPath.item];
    
    cell.post = post;
    [post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        cell.imageView.image = [UIImage imageWithData:data];
    }];
    self.numPosts.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.postArray.count];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postArray.count;
}

@end
