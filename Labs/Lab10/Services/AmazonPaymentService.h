//
//  AmazonPaymentService.h
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import <Foundation/Foundation.h>
#import "PaymentGateway.h"

NS_ASSUME_NONNULL_BEGIN

@interface AmazonPaymentService : NSObject <PaymentDelegate>

@end

NS_ASSUME_NONNULL_END
