//
//  CFXMLProcessor.m
//  ShopifyCamFind
//
//  Created by Alexandr Chernov on 1/28/14.
//  Copyright (c) 2014 Alexandr Chernov. All rights reserved.
//

#import "CFXMLProcessor.h"

typedef enum {
    XMLStatusNothing,
    XMLStatusImagePathBlock,
    XMLStatusTitleBlock,
    XMLStatusInfoBlock,
} XMLParserStatus;

@interface CFXMLProcessor () <NSXMLParserDelegate>
@property (nonatomic, retain) NSMutableArray    *result;
@property (nonatomic, retain) NSXMLParser       *parser;
@property (nonatomic, retain) CFRecordModel     *currentRecord;
@property (nonatomic, retain) NSMutableString   *mutableString;

@property (nonatomic, assign) XMLParserStatus xmlStatus;
@end

@implementation CFXMLProcessor

#pragma mark -
#pragma mark Class methods

+ (NSArray *)arrayFromXMLData:(NSData *)xmlData {
    return [[CFXMLProcessor object] arrayFromXMLData:xmlData];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.result = nil;
    self.parser = nil;
    self.currentRecord = nil;
    self.mutableString = nil;
  
    [super dealloc];
}

- (id)init {
    if (self=[super init]) {
        self.result = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark Accessor methods

- (void)setCurrentRecord:(CFRecordModel *)currentRecord {
    if (_currentRecord) {
        [self.result addObject:_currentRecord];
    }
    IDPNonatomicRetainPropertySynthesize(_currentRecord, currentRecord);
}

#pragma mark -
#pragma mark Private methods

- (NSArray *)arrayFromXMLData:(NSData *)xmlData {
    self.parser = [[[NSXMLParser alloc] initWithData:xmlData] autorelease];
    self.parser.delegate = self;
    [self.parser parse];
    return [[self.result copy] autorelease];
}

#pragma mark -
#pragma mark NSXMLParserDelegate

-(void)parserDidStartDocument:(NSXMLParser *)parser {
//    NSLog(@"parser started");
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    self.currentRecord = nil;
//    NSLog(@"parser end");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([attributeDict[@"class"] isEqualToString:@"row results"]) {
        self.currentRecord = [CFRecordModel object];
        return;
    }
    if ([attributeDict[@"class"] isEqualToString:@"search-result"]) {
        self.xmlStatus = XMLStatusTitleBlock;
        self.mutableString = [NSMutableString string];
        return;
    }
    if ([attributeDict[@"class"] isEqualToString:@"thumbnail"]) {
        self.xmlStatus = XMLStatusImagePathBlock;
        self.mutableString = [NSMutableString string];
        return;
    }
    if ([elementName isEqualToString:@"p"] &&  self.xmlStatus==XMLStatusTitleBlock) {
        self.currentRecord.title = [[self.mutableString copy] autorelease];
        self.xmlStatus = XMLStatusInfoBlock;
        self.mutableString = [NSMutableString string];
        return;
    }
    if ([elementName isEqualToString:@"img"] && attributeDict[@"src"] && self.xmlStatus == XMLStatusImagePathBlock) {
        self.currentRecord.imagePath = [@"http:" stringByAppendingString:attributeDict[@"src"]];
        self.xmlStatus = XMLStatusNothing;
        return;
    }
    if ([attributeDict[@"class"] isEqualToString:@"divider"] && self.xmlStatus==XMLStatusInfoBlock) {
        self.currentRecord.info = [[self.mutableString copy] autorelease];
        self.mutableString = nil;
        self.xmlStatus = XMLStatusNothing;
    }
    if (attributeDict[@"href"]) {
        self.currentRecord.url = [kCFImpctfulHost stringByAppendingPathComponent:attributeDict[@"href"]];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSString *s = [string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \n"]];
    [self.mutableString appendString:s];
}

@end
