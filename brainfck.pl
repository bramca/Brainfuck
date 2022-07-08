use warnings;

$base = "+"x10;

@alphabet = ("a","b","c","d","e","f"
	,"g","h","i","j","k","l","m","n","o","p",
	"q","r","s","t","u","v","w","x","y","z");
@punctuation = ('!','"','#','$','%','&','\'','(',')','*','+'
	,',','-','.','/');
@specpunct = (':',';','<','=','>','?','@');

$specialstr = "éàèàæäâëâåïî";
$punctstr = '!"#\$%&\'()*+,-./';
$specpunctstr = ':;<=>?@';
$result = ">";
$number = 0;

%hash = ();
%hash1 = ();
%hash2 = ();
%hash3 = ();
%hash4 = ();

$teller = -3;
$telleruc = -15;
for $letter (@alphabet){
	$letteruc = uc $letter;
	if($telleruc < 0){
		$hash3{$letteruc} = "-"x-$telleruc;
	}else{
		$hash3{$letteruc} = "+"x$telleruc;
	}
	$telleruc++;
	if($teller < 0){
		$hash{$letter} = "-"x-$teller;
	}else{
		$hash{$letter} = "+"x$teller;
	}
	$teller++;
}

$teller = -2;
while($number < 10){
	if($teller < 0){
		$hash1{$number} = "-"x-$teller;
	}else{
		$hash1{$number} = "+"x$teller;
	}
	$teller++;
	$number++;
}

$teller = -7;
for $punct (@punctuation){
	if($teller < 0){
		$hash2{$punct} = "-"x-$teller;
	}else{
		$hash2{$punct} = "+"x$teller;
	}
	$teller++;
}

$teller = -2;
for $specpunct (@specpunct){
	if($teller < 0) {
		$hash4{$specpunct} = "-"x-$teller;
	}else{
		$hash4{$specpunct} = "+"x$teller;
	}
	$teller++;
}

if($#ARGV > 0){
	open FILEIN,$ARGV[0] or die "Couldn't open the file : $!";
	open FILEOUT,">$ARGV[1]" or die "Couldn't open the file : $!";
	while(<FILEIN>){
		@word = split //,$_;
		$result = ">";
		GenerateCode(@word);
		$result .= "[-]<[-]$base.\n";
		print FILEOUT $result;
	}
}else{
	print "input text: ";
	chomp($in = <STDIN>);
	@word = split //,$in;
	GenerateCode(@word);
	print "$result\n";
}

sub GenerateCode{
	for $letter (@_){
		if($letter =~ m/[a-z]/){
			$result .= "[-]<[-]".$base."[>".$base."<-]".">".$hash{$letter}.".";
		}elsif($letter =~ m/[A-Z]/){
			$result .= "[-]<[-]".$base."[>++++++++<-]".">".$hash3{$letter}.".";
		}elsif($letter =~ m/[0-9]/){
			$result .= "[-]<[-]".$base."[>+++++<-]".">".$hash1{$letter}.".";
		}elsif(index($punctstr,$letter) != -1){
			$result .= "[-]<[-]".$base."[>++++<-]".">".$hash2{$letter}.".";
		}elsif(index($specpunctstr,$letter) != -1){
			$result .= "[-]<[-]".$base."[>++++++<-]".
						">".$hash4{$letter}.".";
		}elsif(index($specialstr,$letter) != -1){
			$result .= "[-]<[-]".$base."[>++++<-]".">--.";
		}elsif($letter =~ m/\[/){
			$result .= "[-]<[-]".$base."[>+++++++++<-]".">+.";
		}elsif($letter =~ m/\]/){
			$result .= "[-]<[-]".$base."[>+++++++++<-]".">+++.";
		}elsif($letter =~ m/\{/){
			$result .= "[-]<[-]".$base."[>".$base."++<-]".">+++.";
		}elsif($letter =~ m/\}/){
			$result .= "[-]<[-]".$base."[>".$base."++<-]".">+++++.";
		}elsif($letter =~ m/\\/){
			$result .= "[-]<[-]".$base."[>+++++++++<-]".">++.";
		}else{
			$result .= "[-]<[-]".$base."[>+++<-]>++.";
		}
	}
}

