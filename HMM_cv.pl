$train_file = shift;
open (IN,$train_file);
@train = <IN>;

@d= (0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5);
@e= (0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6);

$E = 0;
my @error = ([(0)*scalar(@gO)]);#,[(0)*scalar(@go)]);

for(my $i=0;$i<scalar(@train);  $i++) { 
	$unaligned = $train[$i];
	chomp($unaligned);
	$aligned = $unaligned;
	$aligned =~ s/.unaligned//g;
	print "$i";

	for (my $j=0;$j<scalar(@go);$j++) #for go value 
	{
	#	for (my $k=0;$k<scalar(@ge);$k++) # for ge value
		{
			$data=$unaligned; #Let data = unaligned data 
				$g=$go[$j]; #Let g=go[j]
				#$e=$ge[$k];
			system("perl HMM_original.pl  $data $g $e >| NW_alignment"); #call NW(g).pl on 
				$err = `perl alignment_accuracy.pl $aligned NW_alignment` ;#Get error
				$error[$j] += $err; 
		}
	}
#print error for different gaps  
}


#print "Error: $E\n";

my $maxG = $go[0];
#my $maxE = $ge[0];
my $maxAccuracy = 0;

for(my $i=0; $i<scalar(@go); $i++){
	#for(my $j =0; $j<scalar(@ge); $j++){
	print "here: $i, $j\n";

		my $avgAccuracy = $error[$i]/scalar(@train);
		if($maxAccuracy < $avgAccuracy)
		{
			$maxAccuracy = $avgAccuracy;
			$maxG = $go[$i];
			#$maxE = $ge[$j];
		}
		print "$avgError ";	
	
	print "\n";
        $error{$keys[$i]} = $error{$keys [$i]}/scalar(@train);
	#print "@keys[$i] $error{$keys[$i]}\n";
       
}

print "The maximum accuracy is: $maxAccuracy, $maxG,  $maxE\n";
