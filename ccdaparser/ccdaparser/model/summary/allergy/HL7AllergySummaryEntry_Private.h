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


#import "HL7AllergySummaryEntry.h"
@class HL7CodeSummary;
@class HL7DateRange;

@interface HL7AllergySummaryEntry ()

@property (nullable, nonatomic, strong) HL7CodeSummary *allergenCode;
@property (nullable, nonatomic, strong) HL7CodeSummary *allergenValue;
@property (nullable, nonatomic, strong) HL7CodeSummary *reactionCode;
@property (nullable, nonatomic, strong) HL7CodeSummary *statusCode;
@property (nullable, nonatomic, strong) HL7CodeSummary *severityCode;
@property (nonatomic, assign) HL7ProblemSeverityCode problemSeverityCode;
@property (nullable, nonatomic, strong) NSMutableArray<HL7AllergyReactionSummary *> *reactions;

//! Low reflects the date of onset, the high reflects when the allergy was known to be resolved (generally absent) */
@property (nullable, nonatomic, strong) HL7DateRange *dateOfOnsetRange;

//! Represents when the allergy was first recorded in the patient's chart
@property (nullable, nonatomic, strong) NSDate *dateRecorded;
@property (nonatomic, assign) BOOL noKnownMedicationAllergiesFound;
@property (nonatomic, assign) BOOL noKnownAllergiesFound;
@end
