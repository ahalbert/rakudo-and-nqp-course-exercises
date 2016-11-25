#1.1 Hello, World
say('Hello, world');
# say 'Hello, world'; Incorrect

# 1.2 Variables 
my $a := 'Hello'; #1.2.1
say($a); #1.2.2
#my $b := 'Hello'; Incorrect #1.2.3
my @array := []; 
@array[0] := 100; 
@array[1] := 101; 
@array[3] := 103; 
say(@array[3]);
my @literalArray := [1,2,3,4,5];
my $scalarArray := [1,2,3,4,5];
$scalarArray[2];
#say(@array); Fails #1.2.4
my %hash := {};
%hash{'1'} := '1';
%hash{'2'} := '2';
%hash{'3'} := '3';
say(%hash{'2'}); #1.2.5

#1.3 Loops
for @literalArray {
    say($_);
}
#Note that @array does not have @array[2] assigned
for @array -> $val {
    say($val);
} # 1.3.1

for %hash -> $item {
    say($item.key, ":", $item.value);
}

sub fac($n) {
    if $n > 1 {
        return fac($n-1) * $n;
    }
    $n;
}
say(fac(10));
