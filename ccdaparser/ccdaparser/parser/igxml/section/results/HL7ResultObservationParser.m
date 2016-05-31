/********************************************************************************
 * The MIT License (MIT)                                                        *
 *                                                                              *
 * Copyright (C) 2016 Alex Nolasco                                              *
 *                                                                              *
 *Permission is hereby granted, free of charge, to any person obtaining a copy  *
 *of this software and associated documentation files (the "Software"), to deal *
 *in the Software without restriction, including without limitation the rights  *
 *to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     *
 *copies of the Software, and to permit persons to whom the Software is         *
 *furnished to do so, subject to the following conditions:                      *
 *The above copyright notice and this permission notice shall be included in    *
 *all copies or substantial portions of the Software.                           *
 *                                                                              *
 *THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    *
 *IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      *
 *FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   *
 *AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        *
 *LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, *
 *OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     *
 *THE SOFTWARE.                                                                 *
 *********************************************************************************/


#import "HL7ResultObservationParser.h"
#import "HL7Const.h"
#import "HL7EntryRelationship.h"
#import "HL7ElementParser+Additions.h"
#import "HL7ResultObservation.h"
#import "HL7ResultReferenceRange.h"
#import "HL7Value.h"
#import "ParserContext.h"
#import "ParserPlan.h"
#import "IGXMlReader.h"
#import "IGXMLReader+Additions.h"

@implementation HL7ResultObservationParser
- (ParserPlan *)createParsePlan:(ParserContext *)context HL7Element:(HL7ResultObservation *)resultObservation error:(NSError *__autoreleasing *)error
{

    ParserPlan *plan = [super createParsePlan:context HL7Element:resultObservation error:error];

    // interpretationCode
    [plan when:HL7ElementInterpretationCode
        parseWithBlock:^(ParserContext *context, IGXMLReader *node, BOOL *stop) {
            [[resultObservation interpretationCodes] addObject:[HL7ElementParser interpretationCodeFromReader:node]];
        }];

    // reference range
    [plan when:HL7ElementReferenceRange
        parseWithBlock:^(ParserContext *context, IGXMLReader *node, BOOL *stop) {
            [self iterate:context
                untilEndOfElementName:HL7ElementReferenceRange
                           usingBlock:^(ParserContext *context, BOOL *stop) {
                               if ([node isStartOfElementWithName:HL7ElementObservationRange]) {
                                   [self iterate:context
                                       untilEndOfElementName:HL7ElementObservationRange
                                                  usingBlock:^(ParserContext *context, BOOL *stop) {
                                                      if ([node isStartOfElementWithName:HL7ElementValue]) {
                                                          [resultObservation addReferenceRangeWithValue:[HL7ElementParser valueFromReader:node]];
                                                      }
                                                  }];
                               }
                           }];
        }];
    return plan;
}

- (BOOL)parse:(ParserContext *)context error:(NSError *__autoreleasing *)error
{
    HL7ResultObservation *allergyObservation = (HL7ResultObservation *)[context element];

    ParserPlan *parserPlan = [self createParsePlan:context HL7Element:allergyObservation error:error];
    [self iterate:(ParserContext *)context
        usingBlock:^(ParserContext *context, BOOL *stop) {
            [self parse:context usingPlan:parserPlan stop:stop];
        }];
    return YES;
}
@end
