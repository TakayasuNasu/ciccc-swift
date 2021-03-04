//
//  PaymentGateway.h
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol PaymentDelegate <NSObject>
- (BOOL) canProcessPayment;
- (void) processPaymentAmount:(NSInteger) left;
@end


@interface PaymentGateway : NSObject

@property (nonatomic, weak) id<PaymentDelegate> delegate;

- (void) processPaymentAmount:(NSInteger) left;

@end

NS_ASSUME_NONNULL_END
