//
//  SettingsViewController.m
//  Tippy
//
//  Created by Jacqueline DiMonte on 6/22/21.
//

#import "SettingsViewController.h"
#import "TipViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *customPercentage;
@property (weak, nonatomic) IBOutlet UITextField *tipAmount;
@property (weak, nonatomic) IBOutlet UILabel *percentAmount;
@property (strong, nonatomic) IBOutlet UISwitch *customPercentTop;
@property (strong, nonatomic) IBOutlet UISwitch *customPercentBottom;
@property (strong, nonatomic) NSNumber *percent;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePercent];
    // Do any additional setup after loading the view.
}
- (IBAction)onTap:(id)sender {
    NSLog(@"test");
    
    [self.view endEditing:true];
}
- (IBAction)updateCustomPercentage:(id)sender {
    NSLog(@"here");
    
    double customPercentage = [self.customPercentage.text doubleValue];
    NSLog(@"%@", self.customPercentage.text);
    //save value
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:customPercentage forKey:@"default_tip_percentage"];
    [defaults synchronize];
}
- (IBAction)tipAmountChanged:(id)sender {
    [self updatePercent];
}

- (void) updatePercent {
    double tip = [self.tipAmount.text doubleValue];
    
    if(self.bill != 0){
        double p = [self.percent doubleValue];
        p = (tip / [self.bill doubleValue]) * 100;
        NSString *percentString = [NSString stringWithFormat:@"%.02f", p];
        self.percentAmount.text = [percentString stringByAppendingString: @"%"];
    }
}

- (IBAction)topSwitched:(id)sender {
    if (self.customPercentBottom.isOn) {
        [self.customPercentBottom setOn:!self.customPercentBottom.isOn];
        
    }
    
}

- (IBAction)bottomSwitched:(id)sender {
    if (self.customPercentTop.isOn) {
        [self.customPercentTop setOn:!self.customPercentTop.isOn];
        
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TipViewController *tipViewController = [segue destinationViewController];
    tipViewController.customPercent = (NSNumber *)self.customPercentage.text;
    tipViewController.customTip = self.percent;
    // NOTE: send a state instead of two booleans?
    tipViewController.customPercentOn = self.customPercentTop.isOn;
    tipViewController.customTipOn = self.customPercentBottom.isOn;
    NSLog(@"%@", self.customPercentTop.isOn);
    NSLog(@"%@", self.customPercentBottom.isOn);

}

@end
