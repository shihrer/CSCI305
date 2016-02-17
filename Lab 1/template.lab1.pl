use feature 'say';
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
my @cleanedTitles;
my $line;
while($line = <INFILE>) {
	# YOUR CODE BELOW...

	# Extract song title
	my @lineSplit = split(/<SEP>/,$line);
	my $title = pop @lineSplit;

	# Remove after special characters
	$title =~ s/[\([\{\/\\_\-:\"\`\+=\*].*$//g;

	# Remove "feat" text
	$title =~ s/feat\..*$//g;

	# Remove punctuation
	$title =~ s/[\?¿!¡\.;&\$\@%#\|]+//g;

	# Lowercase song title
	$title = lc$title;

	#remove stop words
	$title =~ s/\b(an|a|and|by|for|from|in|of|on|or|out|the|to|with|you|are)\b//g;

	# Ignore foreign titles
	if ($title =~ m{^[[:ascii:]]+$}){
		$title =~ s/[\h]+/ /g;
		$title =~ s/^\s//;

		# Save title to array
		push @cleanedTitles, $title;
	}
}

# Create hash for bigrams
my %titleBigramHash;
foreach my $title (@cleanedTitles){

	#get words from title
	my @titleWords = split(" ", $title);


	for(my $i = 0; $i < scalar @titleWords - 1; $i++)
	{
		$titleBigramHash{@titleWords[$i]}{@titleWords[$i+1]} += 1;
	}
}

# Close the file handle
close INFILE; 

# At this point (hopefully) you will have finished processing the song 
# title file and have populated your data structure of bigram counts.
print "File parsed. Bigram model built.\n\n";


# User control loop
while ($input ne "q"){
	print "Enter a word [Enter 'q' to quit]: ";

	# Get user input
	$input = <STDIN>;
	chomp($input);
	print "\n";

	#Counter and song title variables
	my $counter = 0;
	my $songTitle = "";
	$songTitle = $input . " ";

	# Loop through song title.
	unless($input eq "q"){
		while($counter < 20)
		{
			# Get most common word
			my $result = mcw($input);
			if(defined $result)
			{
				$songTitle = $songTitle . $result . " ";
				$input = $result;
			}
			else
			{
				last;
			}

			$counter += 1;
		}
	}

	print $songTitle . "\n";
}

# MORE OF YOUR CODE HERE....
sub mcw{
	my $word = @_[0];
	my @keys = sort { $titleBigramHash{$word}{$a} <=> $titleBigramHash{$word}{$b} } keys %{$titleBigramHash{$word}};

    return pop @keys;
}