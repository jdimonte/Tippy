//
//  SettingsViewController.m
//  Tippy
//
//  Created by Jacqueline DiMonte on 6/22/21.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *customPercentage;
@property (weak, nonatomic) IBOutlet UITextField *tipAmount;
@property (weak, nonatomic) IBOutlet UILabel *percentAmount;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onTap:(id)sender {
    NSLog(@"test");
    
    [self.view endEditing:true];
}
- (IBAction)updateCustomPercentage:(id)sender {
    NSLog(@"here");
    
    double customPercentage = [self.customPercentage.text doubleValue];
    
    //save value
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:customPercentage forKey:@"default_tip_percentage"];
    [defaults synchronize];
}
- (IBAction)tipAmountChanged:(id)sender {
    double tip = [self.percentAmount.text doubleValue];
    
    //load bill
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    double bill = [defaults2 doubleForKey:@"default_tip_percentage"];
    
    double percent = (tip / bill) * 100;
    self.percentAmount.text = [NSString stringWithFormat:@"$%.2f", percent];
    
    NSLog(@"bill");
    NSLog(@"percent");

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
