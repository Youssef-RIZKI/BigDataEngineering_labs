import sys
# input comes from standard input STDIN
for line in sys.stdin:
    line = line.strip() #remove leading and trailing whitespaces
    words = line.split() #split the line into words and returns as a list
    for word in words:
        #print('%s\t%s'%(word,1)) #print the results
        #write the results to standard output STDOUT
        #print(word+"\t"+str(1)) #print the results
        print(f"{word}\t1")