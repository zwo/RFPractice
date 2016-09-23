//
//  RFContactUtil.m
//  SuperCommunity
//
//  Created by zhouweiou on 16/9/14.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RFContactUtil.h"
#import "APContact.h"
#import <AddressBook/AddressBook.h>
#import "APAddressBook.h"

@interface RFContactUtil ()
@property (nonatomic,strong) APAddressBook *addressBook;
@property (nonatomic,strong) NSArray *apContacts;
@end

@implementation RFContactUtil

+ (instancetype)sharedInstance {
  static id sharedInstance = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  
  return sharedInstance;
}

- (instancetype)init
{
  self=[super init];
  if (self) {
    _addressBook=[APAddressBook new];
    _addressBook.fieldsMask = APContactFieldFirstName | APContactFieldLastName | APContactFieldCompositeName | APContactFieldPhones;
    _addressBook.filterBlock = ^BOOL(APContact *contact) {
      return contact.phones.count > 0 && contact.compositeName != nil;
    };
    WEAKSELF
    [_addressBook loadContacts:^(NSArray *contacts, NSError *error) {
      if (!error) {
        weakSelf.apContacts = contacts;
        [weakSelf parseContactData];
      } else {
        
      }
    }];
  }
  return self;
}

- (void)parseContactData
{
    NSMutableArray *rawContactArray=[NSMutableArray array];
    _pureContactArray=[NSMutableArray array];
    for (APContact *contact in self.apContacts) {
        NSString *name=contact.compositeName;
        NSArray *phones=contact.phones;
        for (NSString *phone in phones) {
            NSString *pureNumber=[self purePhoneNumberFromString:phone];
            if ([pureNumber length]>0) {
                [rawContactArray addObject:@{@"name":name,@"number":pureNumber}];
            }
        }
    }
    
    NSMutableArray *sectionTitles=[NSMutableArray array];
    //建立索引的核心, 返回27，是a－z和＃
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    [sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    
    NSInteger highSection = [sectionTitles count];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    for (NSDictionary *contactDict in rawContactArray) {
        NSString *firstLetter = [self firstCharacter:contactDict[@"name"]];
        NSInteger section = [indexCollation sectionForObject:firstLetter collationStringSelector:@selector(uppercaseString)];
        
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:contactDict];
    }
    
    //去掉空的section
    for (NSInteger i = [sortedArray count] - 1; i >= 0; i--) {
        NSArray *array = [sortedArray objectAtIndex:i];
        if ([array count] == 0) {
            [sortedArray removeObjectAtIndex:i];
            [sectionTitles removeObjectAtIndex:i];
        }
    }
    
    for (int j=0; j<[sectionTitles count]; j++) {
        NSString *title=sectionTitles[j];
        NSArray *array=sortedArray[j];
        NSDictionary *dict=@{@"section":title,@"data":array};
        [_pureContactArray addObject:dict];
    }
    
    RFLog(@"%@",_pureContactArray);
}

- (NSString *)purePhoneNumberFromString:(NSString *)string
{
  NSString *clearSeparator=[[string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789+"] invertedSet]] componentsJoinedByString:@""];
  if ([clearSeparator hasPrefix:@"+86"]) {
    clearSeparator=[clearSeparator substringFromIndex:3];
  }
  if ([clearSeparator length]==11) {
    return clearSeparator;
  } else {
    return nil;
  }
}

#pragma 获取字符串的首字符
- (NSString *)firstCharacter:(NSString *)aString

{
    
    //转成了可变字符串
    
    NSMutableString *str = [NSMutableString stringWithString:aString];
    
    //先转换为带声调的拼音
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    //转化为大写拼音
    
    NSString *pinYin = [str capitalizedString];
    
    //获取并返回首字母
    
    return [pinYin substringToIndex:1];
    
}

- (BOOL)canAccessToNativeAddressBook
{
  switch([APAddressBook access])
  {
    case APAddressBookAccessUnknown:
      return NO;
      break;
    case APAddressBookAccessGranted:
      return YES;
      break;
    case APAddressBookAccessDenied:
      return NO;
      break;
  }
}


@end
