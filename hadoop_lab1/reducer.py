#!/usr/bin/env python3
import sys

current_word = None
current_count = 0

for line in sys.stdin:
    line = line.strip()
    
    # Skip empty lines
    if not line:
        continue
    
    # Split the line on tab
    try:
        word, count = line.split('\t', 1)
        count = int(count)
    except ValueError:
        # Skip lines that don't have the expected format
        continue
    
    # If we're still on the same word, add to the count
    if current_word == word:
        current_count += count
    else:
        # New word encountered - output the previous word (if any)
        if current_word:
            print('%s\t%s' % (current_word, current_count))
        # Reset for the new word
        current_word = word
        current_count = count

# Don't forget to output the last word!
if current_word:
    print('%s\t%s' % (current_word, current_count))