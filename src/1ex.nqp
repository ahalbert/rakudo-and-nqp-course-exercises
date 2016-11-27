say('1.1 Hello, World');
say('Hello, world');
# say 'Hello, world'; Incorrect

say('1.2 Variables');
#1.2.1
my $a := 'Hello'; 
#1.2.2
say($a);
#1.2.3
#my $b := 'Hello'; Incorrect 
#1.2.4
my @array := []; 
@array[0] := 100; 
@array[1] := 101; 
@array[3] := 103; 
say(@array[3]);
#1.2.5
my @literalArray := [1,2,3,4,5];
my $scalarArray := [1,2,3,4,5];
$scalarArray[2];
#say(@array); Fails 
#1.2.6
my %hash := {};
%hash{'1'} := '1';
%hash{'2'} := '2';
%hash{'3'} := '3';
say(%hash{'2'}); 

say('1.3 Loops');
for @literalArray {
    say($_);
}
#Note that @array does not have @array[2] assigned
# 1.3.1
@array[2] := 102; 
for @array -> $val {
    say($val);
} 
#1.3.2
for @array -> $val1, $val2 {
    say($val1, "+", $val2);
} 
#1.3.3
for %hash -> $item {
    say($item.key, ":", $item.value);
}

say('1.4 Subroutines');
sub fac($n) {
    if $n > 1 {
        return fac($n-1) * $n;
    }
    $n;
}
say(fac(10));

say("1.5 classes and 1.6 Multi Methods");
class BarTab {
    has $!table;
    has @!items;

    method table() { return $!table; }

    proto method add_order($name, $price) {*} #d

    multi method add_order($name, $price) {
        my %itemHash;
        %itemHash{'name'} := $name;
        %itemHash{'price'} := $price;
        nqp::push(@!items, %itemHash);
    }


    # ILLEGAL
    # multi method add_order($name, $price, :$qty) {
    #     my %itemHash;
    #     %itemHash{'name'} := $name;
    #     %itemHash{'price'} := $price;
    #     while $qty > 0 {
    #         nqp::push(@!items, %itemHash);
    #         $qty--;
    #     }
    # }
    
    method render_tab() {
        my $sum := 0.0;
        for @!items {
            say($_{'name'}, ":", $_{'price'}); 
            $sum := $sum + $_{'price'};
        }
        say($sum);
        $sum;
    }
}

my $tab := BarTab.new(table => 42);
$tab.add_order("Lord Hobo", 1.00);
$tab.add_order("Lord Hobo Lite", 2.00);
$tab.add_order("Vodka Gimlet", 6.00);
ok($tab.table(), 42);
ok($tab.render_tab(), 9.00);

say("1.7 Extra Credit");

class LexBarTab {
    has $!table;
    has @!items;
    class Item {
        has $!name;
        has $!price;
        method name() {$!name;}
        method value() {$!price;}
    }

    method table() { return $!table; }

    proto method add_order($name, $qty) {*}

    multi method add_order(Item $item) {
        nqp::push(@!items, $item);
    }
    
    method render_tab() {
        my $sum := 0.0;
        for @!items {
            say($_.name(), ":", $_.price()); 
            $sum := $sum + $_.price();
        }
        say($sum);
        $sum;
    }
}

my $ltab := LexBarTab.new(table => 42);
$ltab.add_order("Lord Hobo", 1.00);
$ltab.add_order("Lord Hobo Lite", 2.00);
$ltab.add_order("Vodka Gimlet", 6.00);
ok($ltab.table(), 42);
ok($ltab.render_tab(), 9.00);
