//
//  GCDWebServerFileResponseWithDecryption.m
//  DecryptionOfVideoOnFly
//
//  Created by Ildar Sibagatov on 02.07.14.
//  Copyright (c) 2014 Sig Inc. All rights reserved.
//

#import "GCDWebServerFileResponseWithDecryption.h"
#import "GCDWebServerPrivate.h"

@implementation GCDWebServerFileResponseWithDecryption

- (NSData*)readData:(NSError**)error
{
    NSData* data = [super readData:error];
    
    // decoding part
    NSData *key_data = [@"KEYKEYKEYKEYKEYKEYKEYKEYKEY" dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t *bytes = (uint8_t *)data.bytes;
    uint8_t *key_bytes = (uint8_t *)key_data.bytes;
    
    NSMutableData *m_file_data = [NSMutableData dataWithCapacity:data.length];
    for (int i = 0, j= 0; i < data.length; i++, j++) {
        
        if (j >= key_data.length)
            j = 0;
        
        uint8_t m_byte = bytes[i] ^ key_bytes[j];
        [m_file_data appendBytes:&m_byte length:1];
    }
    
    return ARC_AUTORELEASE(m_file_data);
}

@end
