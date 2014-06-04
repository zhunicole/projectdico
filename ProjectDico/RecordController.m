////
////  RecordController.m
////  ProjectDico
////
////  Created by Nicole Zhu on 6/3/14.
////  Copyright (c) 2014 ProjectDico. All rights reserved.
////
//
//#import "RecordController.h"
//
//@implementation RecordController
//
//
//
//- (void)setUpSpeech
//{
//    if(!self.pocketsphinxController.isListening)
//    {
//        LanguageModelGenerator *lmGenerator = [[LanguageModelGenerator alloc] init];
//        
//        NSString *name = @"SpeechCommands";
//        NSError *err = [lmGenerator generateLanguageModelFromArray:words withFilesNamed:name forAcousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"]];
//
//        NSDictionary *languageGeneratorResults = nil;
//        
//        NSString *lmPath = nil;
//        NSString *dicPath = nil;
//        
//        if([err code] == noErr) {
//            
//            languageGeneratorResults = [err userInfo];
//            
//            lmPath = [languageGeneratorResults objectForKey:@"LMPath"];
//            dicPath = [languageGeneratorResults objectForKey:@"DictionaryPath"];
//            
//        } else
//            NSLog(@"Error: %@",[err localizedDescription]);
//        
//        [self.pocketsphinxController startListeningWithLanguageModelAtPath:lmPath dictionaryAtPath:dicPath acousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:NO];
//    }
//}
//
//- (void)stopListening
//{
//    if(self.pocketsphinxController.isListening)
//        [self.pocketsphinxController stopListening];
//}
//
//
////lazy accessor
//- (PocketsphinxController *)pocketsphinxController {
//	if (pocketsphinxController == nil) {
//		self.pocketsphinxController = [[PocketsphinxController alloc] init];
//	}
//	return self.pocketsphinxController;
//}
//@end
