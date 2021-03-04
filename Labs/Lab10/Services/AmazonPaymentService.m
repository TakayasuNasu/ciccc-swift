//
//  AmazonPaymentService.m
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import "AmazonPaymentService.h"

@implementation AmazonPaymentService

- (BOOL) canProcessPayment
{
  return true;
}

- (void) processPaymentAmount:(NSInteger) left
{
  NSLog(@"Amazon processed amount $%ld", (long)left);
}

@end
