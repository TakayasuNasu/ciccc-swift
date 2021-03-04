//
//  StripePaymentService.m
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import "StripePaymentService.h"

@implementation StripePaymentService


- (BOOL) canProcessPayment
{
  return true;
}

- (void) processPaymentAmount:(NSInteger) left
{
  NSLog(@"Stripe processed amount $%ld", (long)left);
}


@end
