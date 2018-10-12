#import "ImageIdentify.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ImageIdentify

+ (NSArray*)imagePaths
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *pngPaths = [bundle pathsForResourcesOfType:@"png" inDirectory:nil];
    NSArray *jpgPaths = [bundle pathsForResourcesOfType:@"jpg" inDirectory:nil];
    NSString *path;
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:5];
    
    for (path in pngPaths) {
        [paths addObject:path];
    }
    
    for (path in jpgPaths) {
        [paths addObject:path];
    }
    
    return paths;
}

+ (NSString *)shaForData:(NSData*)input
{
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    // This is an iOS5-specific method.
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA256(input.bytes, (CC_LONG)input.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    // Parse through the CC_SHA256 results (stored inside of digest[]).
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

//- (NSString*)identifyImage:(UIView*)view
//{
//}

@end
