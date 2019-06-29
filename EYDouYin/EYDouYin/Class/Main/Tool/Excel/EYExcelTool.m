//
//  EYExcelTool.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/14.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYExcelTool.h"
#import <GDataXML_HTML/GDataXMLNode.h>
#import "EYExcelModel.h"

@implementation EYExcelTool

+ (void)startParseExcel {
    NSData *data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sheet1.xml" ofType:nil]];
    NSError *error;
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithData:data error:&error];
    if(error == nil){
        EYLog(@"读取数据成功:%@",xmlDoc.rootElement);
        int count = 0;
        EYExcelModel *model = [[EYExcelModel alloc] init];
        NSMutableArray *results = [NSMutableArray array];
        
        for (GDataXMLElement *XMLElement1 in xmlDoc.rootElement.children) {
            for (GDataXMLElement *XMLElement2 in XMLElement1.children) {
                for (GDataXMLNode *XMLNode2 in XMLElement2.children) {
                    GDataXMLNode *XMLNode3 = XMLNode2.children.firstObject;
                    if (count >= 3) {
                        NSString *stringValue = XMLNode3.stringValue;
                        if (count % 2) {
                            // NSLog(@" key ==%@", stringValue);
                            model.tt_name = stringValue;
                        } else {
                            // NSLog(@"value==%@", stringValue);
                            model.tt_count = stringValue;
                            [results addObject:model.copy];
                        }
                    }
                    count++;
                }
            }
        }
        
        for (EYExcelModel *model in results) {
            EYLog(@"model==%@:%@", model.tt_name, model.tt_count);
        }
    }
}

@end
