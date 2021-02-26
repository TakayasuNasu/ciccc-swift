//
//  InputCollector.h
//  Lab4
//
//  Created by Takayasu Nasu on 2021/02/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputCollector : NSObject

- (NSString *) inputForPrompt: (int) maxLength And: (NSString *) prompt;

@end

NS_ASSUME_NONNULL_END
