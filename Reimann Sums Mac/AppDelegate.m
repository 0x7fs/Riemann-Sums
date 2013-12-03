//
//  AppDelegate.m
//  Reimann Sums Mac
//
//  Created by Mick on 11/19/13.
//  Copyright (c) 2013 HappTech Development. All rights reserved.
//

#import "AppDelegate.h"
#import "CalculatorObject.h"

@implementation AppDelegate



- (IBAction)startApproximations:(NSButton *)sender
{
    CalculatorObject *calculator = [[CalculatorObject alloc] init];

    SumType direction = SumTypeNone;
    
    if (self.directionSegment.selectedSegment == 0) {
        direction = SumTypeReimannLeft;
    }else if (self.directionSegment.selectedSegment == 1) {
        direction = SumTypeReimannMiddle;
    }else if (self.directionSegment.selectedSegment == 2) {
        direction = SumTypeReimannRight;
    }else if (self.directionSegment.selectedSegment == 3) {
        direction = SumTypeReimannTrapezoidal;
    }else if (self.directionSegment.selectedSegment == 4) {
        direction = SumTypeSimpsonsRule;
    }

	NSString *start = [[self.startingField cell] placeholderString];
	NSString *finish = [[self.endingField cell] placeholderString];
	CGFloat number = [[self.numberOfRectanglesField cell] placeholderString].doubleValue;

	if (self.startingField.stringValue.length != 0) {
		start = self.startingField.stringValue;
	}

	if (self.endingField.stringValue.length != 0) {
		finish = self.endingField.stringValue;
	}

	if (self.numberOfRectanglesField.stringValue.length != 0) {
		number = self.numberOfRectanglesField.doubleValue;
	}

	NSString *fOfX = [[self.functionField cell] placeholderString];

	if (self.functionField.stringValue.length != 0) {
		fOfX = self.functionField.stringValue;
	}

	NSString *function = [calculator functionPreparedForMathParserFromString:fOfX];


    [calculator areaUnderCurveOfFunction:function
                             startingAtX:start
                            andEndingAtX:finish
                  withNumberOfRectangles:number
                             inDirection:direction
                       withProgressBlock:^(CGFloat progress) {
                           
                       } andCompletionBlock:^(CGFloat sum, NSError *error) {
                           if (!error) {
                               NSString *labelText = [calculator outputTextFromSum:sum];
                               [self.resultsField setStringValue:labelText];
                           }else{
                               [self.resultsField setStringValue:error.domain];
                           }                           
                       }];

}


- (IBAction)resetTextFields:(NSButton *)sender
{
    NSView *view = self.window.contentView;
    
    for (NSTextField *subview in view.subviews) {
        if (subview.tag == 5) {
            NSTextField *field = (NSTextField *)subview;
            if ([field respondsToSelector:@selector(setStringValue:)]) {
                [field setStringValue:@""];
            }
        }
    }
}



@end
