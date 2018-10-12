#import "ImageIdentify.h"
#import <CommonCrypto/CommonDigest.h>

@interface ImageIdentify()

@property (strong, nonatomic) NSMutableArray *assetInfo;

@end

@implementation ImageIdentify

+ (NSArray*)imagePaths
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *pngPaths = [bundle pathsForResourcesOfType:@"png" inDirectory:nil];
    NSArray *jpgPaths = [bundle pathsForResourcesOfType:@"jpg" inDirectory:nil];
    NSDictionary *info;
    NSString *path;
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:5];
    
    for (path in pngPaths) {
        info = @{@"rep":@"png",@"path":path};
        [paths addObject:info];
    }
    
    for (path in jpgPaths) {
        info = @{@"rep":@"jpg",@"path":path};
        [paths addObject:info];
    }
    
    return paths;
}

+ (NSString*)shaForData:(NSData*)input
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

+ (NSMutableArray*)assetInfo
{
    NSArray *imagePaths;
    NSMutableArray *assetInfo = [NSMutableArray arrayWithCapacity:5];
    
    imagePaths = [self imagePaths];
    for (NSDictionary *nextInfo in imagePaths) {
        NSString *sha = nil;
        NSData *imageData = nil;
        NSString *nextPath = nextInfo[@"path"];
        NSString *rep = nextInfo[@"rep"];
        UIImage *image = [UIImage imageNamed:nextPath];
        
        if ([rep isEqualToString:@"png"]) {
            imageData = UIImagePNGRepresentation(image);
        }else if ([rep isEqualToString:@"jpg"]) {
            imageData = UIImageJPEGRepresentation(image,0.9);
        }
            
        sha = [self shaForData:imageData];
        if (sha) {
            NSDictionary *info = nil;
            
            info = @{@"filename":[nextPath lastPathComponent],@"image_sha":sha};
            [assetInfo addObject:info];
        }
    }
    
    return assetInfo;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        //capture info about all the images in the app bundle
        self.assetInfo = [[self class] assetInfo];
    }
    
    return self;
}

/**
 view is expected to be a UIImageView, normally we would want to be sure of that
 
 This method extracts the image from view and tries to determine if it matches any image in the app bundle
 If there is a match, returns the name of the image, otherwise returns an empty string
 **/
- (NSString*)identifyImage:(UIView*)view
{
    UIImageView *imageView = (id)view;
    UIImage *image = imageView.image;
    NSDictionary *info;
    NSData *imageDataJpgRep;
    NSString *imageName;
    BOOL isMatch = NO;
    NSPredicate *q;
    
    imageDataJpgRep = UIImageJPEGRepresentation(image, 0.9);
    q = [NSPredicate predicateWithFormat:@"image_sha = %@", [[self class] shaForData:imageDataJpgRep]];
    info = [[self.assetInfo filteredArrayUsingPredicate:q] lastObject];
    if (!info) {
        NSData *imageDataPngRep;

        imageDataPngRep = UIImagePNGRepresentation(image);
        q = [NSPredicate predicateWithFormat:@"image_sha = %@", [[self class] shaForData:imageDataPngRep]];
        info = [[self.assetInfo filteredArrayUsingPredicate:q] lastObject];

        if (info) {
            isMatch = YES;
            imageName = info[@"filename"];
        }
    }else{
        isMatch = YES;
        imageName = info[@"filename"];
    }
    
    return isMatch ? imageName : @"";
}

@end
