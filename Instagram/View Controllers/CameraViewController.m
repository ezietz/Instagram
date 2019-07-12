//
//  CameraViewController.m
//  Instagram
//
//  Created by ezietz on 7/9/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "CameraViewController.h"
#import "Post.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *captionField;
@property (weak, nonatomic) IBOutlet UIImageView *instaImage;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapCamera:(id)sender {
    
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.instaImage.image = originalImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)clickedPost:(id)sender {
    UIImage *imageToPost = [self resizeImage:self.instaImage.image withSize:CGSizeMake (400,400)];
    [Post postUserImage:imageToPost withCaption:self.captionField.text withCompletion:nil];
    [self.tabBarController setSelectedIndex:0];
}

@end
