//
//  ViewController.m
//  RacDemo
//
//  Created by jinxin on 2017/7/25.
//  Copyright © 2017年 jinxin. All rights reserved.
//

#import "ViewController.h"
#import "RWDummySignInService.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;

@property (weak, nonatomic) IBOutlet UILabel *invalidLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signalButton;

@property (nonatomic) BOOL passwordIsValid;
@property (nonatomic) BOOL usernameIsValid;

@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self updateUIState];
	self.invalidLabel.hidden = YES;
	
	_signInService = [[RWDummySignInService alloc] init];
	
	[self.usernameTextfield addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
	[self.passwordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
	
}

- (BOOL)isValidUsername:(NSString *)username {
	return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
	return password.length > 3;
}

- (IBAction)signInButtonTouched:(id)sender {
	self.signalButton.enabled = NO;
	self.invalidLabel.hidden = YES;
	
  // sign in
	[self.signInService signInWithUsername:self.usernameTextfield.text
								  password:self.passwordTextField.text
								  complete:^(BOOL success) {
									  self.signalButton.enabled = YES;
									  self.invalidLabel.hidden = success;
									  if (success) {
										  [self performSegueWithIdentifier:@"signInSuccess" sender:self];
									  }
								  }];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)updateUIState {
	self.usernameTextfield.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
	self.passwordTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
	self.signalButton.enabled = self.usernameIsValid && self.passwordIsValid;
}

- (void)usernameTextFieldChanged {
	self.usernameIsValid = [self isValidUsername:self.usernameTextfield.text];
	[self updateUIState];
}

- (void)passwordTextFieldChanged {
	self.passwordIsValid = [self isValidPassword:self.passwordTextField.text];
	[self updateUIState];
}

@end
