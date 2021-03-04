//
//  PaymentGateway.m
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import "PaymentGateway.h"

@implementation PaymentGateway

- (void) processPaymentAmount:(NSInteger) left
{
  if ([[self delegate] canProcessPayment]){
    [[self delegate] processPaymentAmount:left];
  }else{
    NSLog(@"Sorry, something wrong happened. We couldn't succeed the process.");
  }

}

@end
