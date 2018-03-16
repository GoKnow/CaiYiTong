

#import "NSString+Hashing.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSString_Hashing)

- (NSString *)MD5Hash
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

//- (NSString *)URLEncode
//{
//    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
//}
//
//- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
//{
//    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)self,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]%",CFStringConvertNSStringEncodingToEncoding(encoding)));
//}

- (NSString *)URLEncode
{
    NSMutableString * output = [NSMutableString string];
    const char * source = [self UTF8String];
    int sourceLen = strlen(source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = (const unsigned char)source[i];
        if (false && thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSString *)decoderUrlEncodeStr{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}

@end
