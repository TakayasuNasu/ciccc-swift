//
//  Boss.h
//  ProtocolDelegate
//
//  Created by Takayasu Nasu on 2021/02/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AccountantDelegate

@required

- (float) calcTax;

@optional

@end

@interface Boss : NSObject

@property (nonatomic) id<AccountantDelegate> delegate;

- (void) calculateTax;

@end

NS_ASSUME_NONNULL_END
