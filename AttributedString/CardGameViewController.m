//
//  CardGameViewController.m
//  AttributedString
//
//  Created by Issam Bendaas on 02.02.13.
//  Copyright (c) 2013 LetsGrow. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stringLabel;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLable;

@property (weak, nonatomic) IBOutlet UIStepper *fontSizeStepper;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLable;

@end

@implementation CardGameViewController

- (IBAction)underline
{
    NSRange range = [[self.stringLabel.attributedText string]rangeOfString:[self selectedWord]];
    
    if (range.location != NSNotFound) {
        NSMutableAttributedString *matt = [self.stringLabel.attributedText mutableCopy];
        NSDictionary *underlineDictAtt = @{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)};
        
        [matt addAttributes:underlineDictAtt range:range];
        
        self.stringLabel.attributedText = matt;
    }
}



-(NSArray *)wordList
{
    NSArray *wordList = [[self.stringLabel.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([wordList count]) {
        return wordList;
    } else
    {
        return @[@""];
    }
}
-(NSString *)selectedWord
{
    NSString *selectedString = [self wordList][(int)self.selectedWordStepper.value];
    return selectedString;
}

- (IBAction)updateSelectedWord {
    self.selectedWordStepper.maximumValue = [[self wordList]count]-1;
    self.selectedWordLable.text = [self selectedWord];
}
- (IBAction)updateFontSize {
    self.fontSizeStepper.minimumValue = 10;
    
    self.fontSizeLable.text =[NSString stringWithFormat:@"Font size: %d", (int)self.fontSizeStepper.value];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateSelectedWord];
    
    NSString *string = @"Hallo!";
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSDictionary *dictOfAttributs = @{NSFontAttributeName : [UIFont systemFontOfSize:22], NSForegroundColorAttributeName : [UIColor greenColor]};
    
    NSString *stringRange = @"Ha";
    NSRange range = [string rangeOfString:stringRange];
    
    [attributedString addAttributes:dictOfAttributs range:range];
    
    
    //self.stringLabel.text = [attributedString string];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
