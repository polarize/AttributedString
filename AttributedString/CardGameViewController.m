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


-(void)addLableAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    if (range.location != NSNotFound) {
        NSMutableAttributedString *matt = [self.stringLabel.attributedText mutableCopy];
        [matt addAttributes:attributes range:range];
        self.stringLabel.attributedText = matt;
    }

}
-(void)addSelectedWordAttributes:(NSDictionary *)attributes
{
    NSRange range = [[self.stringLabel.attributedText string]rangeOfString:[self selectedWord]];
    [self addLableAttributes:attributes range:range];
}



- (IBAction)underline
{
    NSDictionary *underlineDictAtt = @{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)};
    [self addSelectedWordAttributes:underlineDictAtt];
}

- (IBAction)unUnderline
{
    
    NSDictionary *unUnderlinAttrDict = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    [self addSelectedWordAttributes:unUnderlinAttrDict];
}



- (IBAction)changeFontSize {
   
    /*
    CGFloat fontSize = [UIFont systemFontSize];
    //
    int index = self.selectedWordStepper.value;
    
    NSDictionary *attributes = [self.stringLabel.attributedText attributesAtIndex:index effectiveRange:NULL];
    
    UIFont *existingFont = attributes[NSFontAttributeName];
    if (existingFont) {
        fontSize = existingFont.pointSize;
    }
    
    */
   self.fontSizeStepper.minimumValue = 20;
    double newFontSize = self.fontSizeStepper.value;
    
    
    self.fontSizeLable.text =[NSString stringWithFormat:@"Font size: %d", (int)newFontSize];
    NSDictionary *fontSizeAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:newFontSize]};
    [self addSelectedWordAttributes:fontSizeAttr];
}

- (IBAction)changeColor:(UIButton *)sender
{
    NSDictionary *colorAttribute = @{NSForegroundColorAttributeName: sender.backgroundColor};
    [self addSelectedWordAttributes:colorAttribute];
}

- (IBAction)changeFontStyle:(UIButton *)sender
{
    CGFloat fontSize = [UIFont systemFontSize];
    
   // int index = self.selectedWordStepper.value;
    
    NSDictionary *attributes = [self.stringLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName];
    
    if (existingFont) {
        fontSize = existingFont.pointSize;
    }
    
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    NSDictionary *newForntAtt = @{NSFontAttributeName: font};
    
    [self addSelectedWordAttributes:newForntAtt];
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



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateSelectedWord];
    
    NSString *string = @"The new string attributes will help make labels even more amazing. \nWelcome NSMutableAttributedString!";
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSDictionary *dictOfAttributs = @{NSFontAttributeName : [UIFont systemFontOfSize:22], NSForegroundColorAttributeName : [UIColor greenColor]};
    
    NSString *stringRange = @"Ha";
    NSRange range = [string rangeOfString:stringRange];
    
    [attributedString addAttributes:dictOfAttributs range:range];
    
    
    self.stringLabel.text = string;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
