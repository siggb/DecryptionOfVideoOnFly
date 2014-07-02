//
//  CustomBlocks.h
//  KeenListener
//
//  Created by Ildar Sibagatov on 02.07.14.
//  Copyright (c) 2014 Sig Inc. All rights reserved.
//

#ifndef CustomBlocks_h
#define CustomBlocks_h

typedef void (^VoidResponseBlock)();

typedef void (^ResponseBlock)(id data);

typedef void (^ArrayResponseBlock)(NSArray *data);
typedef void (^DictionaryResponseBlock)(NSDictionary *data);

typedef void (^StringResponseBlock)(NSString *data);
typedef void (^NumberResponseBlock)(NSNumber *number);
typedef void (^LogicalResponseBlock)(BOOL flag);

typedef void (^ErrorResponseBlock)(NSError *error);

typedef void (^TransmitProgressBlock)(NSInteger bytesTransmited, long long totalBytesTransmited, long long totalBytesExpectedToTransmit);

#endif
