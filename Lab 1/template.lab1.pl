######################################### 	
#    CSCI 305 - Programming Lab #1		
#										
#  Michael Shihrer, Matthew Wentz			
#  michael.shihrer@gmail.com, mattwentz@sbcglobal.net		
#										
#########################################

# Replace the string value of the following variable with your names.
my $name = "<Replace with your name>";
my $partner = "<Replace with your partner's name>";
print "CSCI 305 Lab 1 submitted by $name and $partner.\n\n";

# Checks for the argument, fail if none given
if($#ARGV != 0) {
    print STDERR "You must specify the file name as the argument.\n";
    exit 4;
}

# Opens the file and assign it to handle INFILE
open(INFILE, $ARGV[0]) or die "Cannot open $ARGV[0]: $!.\n";


# YOUR VARIABLE DEFINITIONS HERE...

# This loops through each line of the file
my @cleanedTitles
while($line = <INFILE>) {
	# YOUR CODE BELOW...
	@lineSplit = split(/<SEP>/,$line);
	my $title = pop @lineSplit;
	$title =~ s/[\([\{\/\\_\-:\"\`\+=\*].*$//g;
	$title =~ s/feat\..*$//g;
	$title =~ s/[\?¿!¡\.;&\$\@%#\|]+//g;
	$title = lc$title;

	#test
	if ($title =~ m{^[[:ascii:]]+$}){
		$title =~ s/[\h]+/ /g;
		$title =~ s/^\s//;
		push @cleanedTitles, $title;

}
#self-check 1
print scalar @titles;

#Create hash for bigrams


# Close the file handle
close INFILE; 

# At this point (hopefully) you will have finished processing the song 
# title file and have populated your data structure of bigram counts.
print "File parsed. Bigram model built.\n\n";


# User control loop
print "Enter a word [Enter 'q' to quit]: ";
$input = <STDIN>;
chomp($input);
print "\n";	
while ($input ne "q"){
	# Replace these lines with some useful code
	print "Not yet implemented.  Goodbye.\n";
	$input = 'q';
}

# MORE OF YOUR CODE HERE....
