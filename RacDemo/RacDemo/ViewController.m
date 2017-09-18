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

@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.invalidLabel.hidden = YES;
	
	_signInService = [[RWDummySignInService alloc] init];
    
    RACSignal * validUsernameSignal = [self.usernameTextfield.rac_textSignal map:^id(NSString * text) {
        return @([self isValidUsername:text]);
    }];
    RACSignal * validPasswordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString * text) {
        return @([self isValidPassword:text]);
    }];
    
    RAC(self.passwordTextField, backgroundColor) = [validPasswordSignal map:^id(NSNumber * number) {
        return [number boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.usernameTextfield, backgroundColor) = [validUsernameSignal map:^id(NSNumber * number) {
        return [number boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RACSignal * signUpActiveSignal = [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal] reduce:^id(NSNumber * usernameValid, NSNumber * passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    [signUpActiveSignal subscribeNext:^(NSNumber * number) {
        self.signalButton.enabled = [number boolValue];
    }];
    
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


@end
