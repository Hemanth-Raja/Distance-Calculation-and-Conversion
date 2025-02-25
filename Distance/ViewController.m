//
//  ViewController.m
//  Distance
//
//  Created by Hemanth Raja on 21/06/18.
//  Copyright © 2018 Hemanth Raja. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *startLocation;
@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;
@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UILabel *distanceC;
@property (weak, nonatomic) IBOutlet UITextField *endLocationC;
@property (weak, nonatomic) IBOutlet UILabel *distanceD;
@property (weak, nonatomic) IBOutlet UITextField *endLocationD;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitconverter;

@end

@implementation ViewController



- (IBAction)buttontapped:(id)sender {
    
    self.calculateButton.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startLocation.text;
    NSString *destA = self.endLocationA.text;
    NSString *destB = self.endLocationB.text;
    NSString *destC = self.endLocationC.text;
    NSString *destD = self.endLocationD.text;
    NSArray *dests = @[destA,destB,destC,destD];
    
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    __weak ViewController *weakSelf = self;
    self.req.callback = ^(NSArray *distances) {
        ViewController *strongSelf = weakSelf;
        if(!strongSelf) return;
        
        NSNull *badResult = [NSNull null];
        if((distances[0] != badResult)||(distances[1] != badResult)||(distances[2] != badResult)||(distances[3] != badResult)){
            double num0 , num1 , num2 , num3;
            if(strongSelf.unitconverter.selectedSegmentIndex == 0){
                num0 = ([distances[0] floatValue]/1);
                NSString *x = [NSString stringWithFormat:@"%.2f M",num0];
                strongSelf.distanceA.text = x;
                num1 = ([distances[1] floatValue]/1);
                NSString *x1 = [NSString stringWithFormat:@"%.2f M",num1];
                strongSelf.distanceB.text = x1;
                num2 = ([distances[2] floatValue]/1);
                NSString *x2 = [NSString stringWithFormat:@"%.2f M",num2];
                strongSelf.distanceC.text = x2;
                num3 = ([distances[3] floatValue]/1);
                NSString *x3 = [NSString stringWithFormat:@"%.2f M",num3];
                strongSelf.distanceD.text = x3;
            }
            else if (strongSelf.unitconverter.selectedSegmentIndex == 1){
                num0 = ([distances[0] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km",num0];
                strongSelf.distanceA.text = x;
                num1 = ([distances[1] floatValue]/1000.0);
                NSString *x1 = [NSString stringWithFormat:@"%.2f Km",num1];
                strongSelf.distanceB.text = x1;
                num2 = ([distances[2] floatValue]/1000.0);
                NSString *x2 = [NSString stringWithFormat:@"%.2f Km",num2];
                strongSelf.distanceC.text = x2;
                num3 = ([distances[3] floatValue]/1000.0);
                NSString *x3 = [NSString stringWithFormat:@"%.2f Km",num3];
                strongSelf.distanceD.text = x3;
            }
            else{
                num0 = ([distances[0] floatValue]/1609.34);
                NSString *x = [NSString stringWithFormat:@"%.2f Miles",num0];
                strongSelf.distanceA.text = x;
                num1 = ([distances[1] floatValue]/1609.34);
                NSString *x1 = [NSString stringWithFormat:@"%.2f Miles",num1];
                strongSelf.distanceB.text = x1;
                num2 = ([distances[2] floatValue]/1609.34);
                NSString *x2 = [NSString stringWithFormat:@"%.2f Miles",num2];
                strongSelf.distanceC.text = x2;
                num3 = ([distances[3] floatValue]/1609.34);
                NSString *x3 = [NSString stringWithFormat:@"%.2f Miles",num3];
                strongSelf.distanceD.text = x3;
            }

        }
        else{
            strongSelf.distanceA.text = @"Error";
            strongSelf.distanceB.text = @"Error";
            strongSelf.distanceC.text = @"Error";
            strongSelf.distanceD.text = @"Error";
        }
        strongSelf.req = nil;
        
        strongSelf.calculateButton.enabled = YES;
    };
    
    
    [self.req start];

    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}



@end


