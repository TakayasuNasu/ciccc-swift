//
//  PaypalPaymentService.m
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import "PaypalPaymentService.h"

@implementation PaypalPaymentService


- (BOOL) canProcessPayment
{
  return true;
}

- (void) processPaymentAmount:(NSInteger) left
{
  NSLog(@"Paypal processed amount $%ld", (long)left);
}


@end
