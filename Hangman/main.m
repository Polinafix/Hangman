//
//  main.m
//  Hangman
//
//  Created by Polina Fiksson on 6/8/18.
//  Copyright © 2018 PolinaFiksson. All rights reserved.
//

#import <Foundation/Foundation.h>

void printWord(NSString *word, NSMutableArray<NSString*> *usedLetters) {
    printf("\nWord: ");
    BOOL missingLetters = NO;

    for (NSInteger i = 0; i < [word length]; ++i) {
        unichar letter = [word characterAtIndex:i];
        NSString *letterString = [NSString stringWithFormat:@"%C", letter];

        //if we already guessed this letter
        if([usedLetters containsObject:letterString]) {
            printf("%C", letter);
        } else {
            printf("_");
            missingLetters = YES;
        }
    }

    printf("\nGuesses: %ld/8\n", [usedLetters count]);
    if (missingLetters == NO) {
        printf("It looks like you live on... for now.\n");
        exit(0);
    } else {
        if ([usedLetters count] == 8) {
            printf("Oops – you died! The word was %s.\n", [word cStringUsingEncoding:NSUTF8StringEncoding]);
            exit(0);
        } else {
            printf("Enter a guess: ");
        }
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *word = @"RHYTHM";
        NSMutableArray<NSString*> *usedLetters = [NSMutableArray arrayWithCapacity:8];

        printf("Welcome to Hangman!\n");
        printf("Press a letter to guess, or Ctrl+C to quit.\n");
        printWord(word, usedLetters);

        while (1) {
            //read a string from the user
            char cstring[256];
            scanf("%s", cstring);
            //convert to NSString
            NSString *input = [NSString stringWithCString:cstring encoding:NSUTF8StringEncoding];

            if ([input length] != 1) {
                printf("Please type exactly one letter, or Ctrl+C to quit.");
                       } else {
                           //this letter is new
                           //pull out the first letter from the input
                           unichar letter = [input characterAtIndex:0];
                           //convert it to an uppercase NSString
                           NSString *letterString = [[NSString stringWithFormat:@"%C", letter]uppercaseString];

                           if ([usedLetters containsObject:letterString]) {
                               printf("You used that letter already! \n");
                           } else {
                               [usedLetters addObject:letterString];
                           }
                       }
            //print the game state
            printWord(word, usedLetters);
        }
    }
    return 0;
}
