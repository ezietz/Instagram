//
//  LoginViewController.m
//  Instagram
//
//  Created by ezietz on 7/8/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius = 3;
    self.registerButton.layer.cornerRadius = 3;
}

- (IBAction)clickedLogin:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            // display view controller that needs to shown after successful login
        }
    }];
}

@end
