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


#import "HL7AllergyEntryRelationshipParser.h"
#import "HL7Const.h"
#import "HL7Act.h"
#import "HL7AllergyConcernAct.h"
#import "HL7AllergyObservation.h"
#import "HL7AllergyObservationParser.h"
#import "HL7EntryRelationship.h"
#import "HL7ActParser.h"
#import "ParserContext.h"
#import "ParserPlan.h"
#import "IGXMlReader.h"

@implementation HL7AllergyEntryRelationshipParser
- (NSString *)designatedElementName
{
    return HL7ElementEntryRelationship;
}

- (ParserPlan *)createParsePlan:(ParserContext *)context HL7Element:(HL7EntryRelationship *)entryRelationship error:(NSError *__autoreleasing *)error
{

    ParserPlan *plan = [super createParsePlan:context HL7Element:entryRelationship error:error];

    // Observation
    [plan when:HL7ElementObservation
        parseWithBlock:^(ParserContext *context, IGXMLReader *node, BOOL *stop) {
            HL7AllergyObservation *allergyObsevation = [[HL7AllergyObservation alloc] init];
            [context setElement:allergyObsevation];
            [[[HL7AllergyObservationParser alloc] init] parse:context error:error];
            [entryRelationship addChildElement:allergyObsevation];
        }];

    // Activity
    [plan when:HL7ElementAct
        parseWithBlock:^(ParserContext *context, IGXMLReader *node, BOOL *stop) {
            HL7Act *act = [[HL7Act alloc] init];
            [context setElement:act];
            [[[HL7ActParser alloc] init] parse:context error:error];
            [entryRelationship addChildElement:act];
        }];
    return plan;
}

- (BOOL)parse:(ParserContext *)context error:(NSError *__autoreleasing *)error
{
    HL7EntryRelationship *entryRelationship = (HL7EntryRelationship *)[context element];
    ParserPlan *parserPlan = [self createParsePlan:context HL7Element:entryRelationship error:error];

    [self iterate:(ParserContext *)context
        usingBlock:^(ParserContext *context, BOOL *stop) {
            [self parse:context usingPlan:parserPlan stop:stop];
        }];
    return YES;
}

@end
