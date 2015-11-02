//
//  FISViewController.m
//  validatedSignUp
//
//  Created by Joe Burgess on 7/2/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.userName.delegate = self;
    self.password.delegate = self;

}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)firstNameEndAction:(UITextField *)sender{
    
    if([self checkName:sender] == NO)
     {
       NSLog(@"Hello, firstName");
       [self alertViewActive:sender];
     }
}

-(IBAction)lastName:(UITextField *)sender
{
    if([self checkName:sender] == NO)
    {
        [self alertViewActive:sender];
        NSLog(@"Hello, lastName");
    }
}

-(IBAction)emailAction:(UITextField *)sender
{
    if (sender.text.length == 0 || (![sender.text containsString:@"@"])){
        [self alertViewActive:sender];
        NSLog(@"Hello, email");
    }
}
-(IBAction)userNamaAction:(UITextField *)sender{
    if([self checkName:sender] == NO)
    {
        NSLog(@"Hello, firstName");
        [self alertViewActive:sender];
    }
}

-(IBAction)passwordAction:(UITextField *)sender{
    
    if (sender.text.length > 6){
        [self alertViewActive:sender];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.firstName)
    {
        self.lastName.enabled = YES;
        [self.lastName becomeFirstResponder];
        return YES;
    }
    
    if(textField == self.lastName)
    {
        self.email.enabled = YES;
        [self.email becomeFirstResponder];
        return YES;
    }
    
    if(textField == self.email)
    {
        self.userName.enabled = YES;
        [self.userName becomeFirstResponder];
        return YES;
    }
    if(textField == self.userName)
    {
        self.password.enabled = YES;
        [self.password becomeFirstResponder];
        return YES;
    }
    if(textField == self.password)
    {
        [textField resignFirstResponder];
        self.submitButton.enabled = YES;
        self.submitButton.hidden = NO;
        return YES;
    }
    
    return NO;
}

-(BOOL)checkName:(UITextField *)textField{
    
    NSString * text = textField.text;
    NSCharacterSet *invalidCharacters = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange invalidCharacterRange = [text rangeOfCharacterFromSet:invalidCharacters];
    
    if (text.length == 0 || invalidCharacterRange.length >0) {
        return NO; // checkName not valid
    }
    return YES;
}

-(void)alertViewActive: (UITextField *)textField{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Not valid text" message:@"You are so cool" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * resetAction = [UIAlertAction actionWithTitle:@"Clear" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        textField.text = @"";
        NSLog(@"reset action");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

    [alert addAction:resetAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
