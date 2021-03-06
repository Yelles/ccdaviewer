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


#import "HL7Observation.h"
#import "HL7ElementContainerProtocol.h"

@class HL7Participant;
@class HL7Text;

@interface HL7AllergyObservation : HL7Observation <HL7ElementContainerProtocol>
@property (nullable, nonatomic, strong) HL7Participant *participant;
@property (nonnull, nonatomic, strong) NSMutableArray<__kindof HL7Element *> *descendants;

/** severity of the observation */
- (HL7AllergyObservation *_Nullable)severity;

/** indicates if no known allergies entries was found */
- (BOOL)noKnownAllergiesFound;

/** indicates if no known medication entries was found */
- (BOOL)noKnownMedicationAllergiesFound;

- (BOOL)isObservation;
- (BOOL)isReactionObservation;
- (BOOL)isSeverityObservation;

- (NSString *_Nullable)getTextFromValueOrSectionText;
@end
