//
//  main.m
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import <Foundation/Foundation.h>
#import "InputHandler.h"
#import "AmazonPaymentService.h"
#import "PaypalPaymentService.h"
#import "StripePaymentService.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {

    NSUInteger dollarValue = arc4random_uniform(900) + 100;
    NSLog(@"Your total today is $%lu",(unsigned long)dollarValue);

    InputHandler *inputHandler = [[InputHandler alloc] init];
    NSString *inputNumber = [inputHandler getUserInput:255 And: @"Enter 1 to 3"];

    PaymentGateway *payment = [[PaymentGateway alloc] init];
    AmazonPaymentService *amazon = [[AmazonPaymentService alloc] init];
    PaypalPaymentService *paypal = [[PaypalPaymentService alloc] init];
    StripePaymentService *stripe = [[StripePaymentService alloc] init];

    switch ([inputNumber intValue]) {
      case 1:
        [payment setDelegate:amazon];
        break;
      case 2:
        [payment setDelegate:paypal];
        break;
      case 3:
        [payment setDelegate:stripe];
        break;
      default:
        break;
    }

    [payment processPaymentAmount:dollarValue];
  }
  return 0;
}
