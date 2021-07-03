//
//  TipViewController.m
//  Tippy
//
//  Created by Jacqueline DiMonte on 6/22/21.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentageControl;
@property (weak, nonatomic) IBOutlet UIView *labelsContainerView;
@property (strong, nonatomic) IBOutlet UIStepper *numberOfPeople;
@property (strong, nonatomic) IBOutlet UILabel *splitBill;
@property (strong, nonatomic) IBOutlet UILabel *totalBillSplit;
@property double totalBill;

@end

bool isEmpty = FALSE;

@implementation TipViewController
// +: class methods -: instance methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}

- (IBAction)updateLabels:(id)sender {
    if(self.billAmountField.text.length == 0) {
        [self hideLabels];
        isEmpty = TRUE;
    }
    else {
        if(isEmpty){
            [self showLabels];
            isEmpty = FALSE;
        }
    }
    
    [self calculateTip];
    [self updateSplittingBill];
}

- (void)calculateTip {
    double tipPercentages[] = {0.15, 0.2, 0.25};
    double tipPercentage = tipPercentages[self.tipPercentageControl.selectedSegmentIndex];
    if(self.customPercentOn){
        // NOTE: how can I avoid problems with NSNumber and double?
        tipPercentage = [self.customPercent doubleValue];
    }
    if(self.customTipOn){
        tipPercentage = [self.customTip doubleValue];
    }
    NSLog(@"%@", self.customTipOn);
    NSLog(@"%@", self.customPercentOn);

    double bill = [self.billAmountField.text doubleValue];
    
    //save bill
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    [defaults2 setDouble:bill forKey:@"default_tip_percentage"];
    [defaults2 synchronize];
    
    double tip = bill * tipPercentage;
    double total = bill + tip;
    self.totalBill = total;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}

- (void)hideLabels {
    [UIView animateWithDuration: 0.7 animations:^{
        CGRect billFrame = self.billAmountField.frame;
        billFrame.origin.y += 200;
        
        self.billAmountField.frame = billFrame;
        
        CGRect labelsFrame = self.labelsContainerView.frame;
        labelsFrame.origin.y += 200;
        
        self.labelsContainerView.frame = labelsFrame;
        
        self.labelsContainerView.alpha = 0;
    }];
}

-(void)showLabels {
    [UIView animateWithDuration: 0.7 animations:^{
        CGRect billFrame = self.billAmountField.frame;
        billFrame.origin.y -= 200;
        
        self.billAmountField.frame = billFrame;
        
        CGRect labelsFrame = self.labelsContainerView.frame;
        labelsFrame.origin.y -= 200;
        
        self.labelsContainerView.frame = labelsFrame;
        
        self.labelsContainerView.alpha = 1;
    }];
}
- (IBAction)changePeopleCount:(id)sender {
    if(self.numberOfPeople.value <=1){
        self.numberOfPeople.value = 2;
    }
    //update labels
    NSString *first = @"Split the bill by ";
    NSString *second = [NSString stringWithFormat:@"%.f", self.numberOfPeople.value];
    self.splitBill.text = [first stringByAppendingString:second];
    NSLog(@"%f", self.numberOfPeople.value);
    [self updateSplittingBill];
}

- (void) updateSplittingBill {
    double splittingBill = self.totalBill/self.numberOfPeople.value;
    self.totalBillSplit.text = [NSString stringWithFormat:@"$%.2f", splittingBill];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"View will appear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"View did appear");
    NSLog(@"%@", self.customPercent);
    [self calculateTip];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    NSLog(@"View will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    NSLog(@"View did disappear");
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SettingsViewController *settingsViewController = [segue destinationViewController];
    settingsViewController.bill = (NSNumber *)self.billAmountField.text;
}

@end
