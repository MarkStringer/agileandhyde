use strict;

## read in the whole file
my $tweet = "";

my $flip = 1;

while (my $filename = pop)
{
	open(my $fh, '<:encoding(UTF-8)', $filename)||die "failed to open file";
	my $content;
	while (<$fh>) { $content .= $_ }

        $content =~ s/[^\x00-\x7f]//g;

	my @lines = split(/\./, $content);

        my $singleLine = $lines[rand(scalar @lines)];
        my @words = split /\W+/, $singleLine;
        ## add a word and a space until the string is 70 characters
        my $finalString = "";
	while (length $finalString <= 65)
	{
        	if ($flip > 0)
		{	
	        	my $singleWord = shift @words;
			$finalString .= " ".$singleWord;
		}
		else
		{
			my $singleWord = pop @words;
			$finalString = " ".$singleWord." ".$finalString;
		}
	}

	$tweet .= $finalString;

        $flip *= -1;
}

## make sure only the first letter is capitalised
$tweet = lc($tweet);
$tweet =~ s/\s+(.*)/$1/;

$tweet = ucfirst $tweet;

## replace mutiple spaces with single spaces
$tweet =~ s/\s+/ /g;

print $tweet."\n";
