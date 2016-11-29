say("Excercise 2.1");

grammar IrcLog {
    token timestamp { \d\d:\d\d }
    token nick { (\* )? \w* }
    token message { .*\n }
    token TOP {
        ^[<timestamp> <nick> <message>]+$ 
    }
}

my $m := IrcLog.parse(Q{
00:05 tadzik    waves from Oslo
00:05 colomon   waves from Midland
00:06 tadzik      The World of Perl 6
00:11 perigrin    Midgard?
00:12 timotimo    tadzik: the release has been done by moritz and lizmat. how are you feeling? travel went fine?
00:15 colomon     perigrin: yes?
00:17 colomon     perigrin: but we hope to make it to Camelhalla some day.
00:22 tadzik      timotimo: yeah, just long-ish :)
00:22 tadzik      moritz++ lizmat++
00:22 timotimo    this release is giving me butterflies in my stomach :P
00:22 tadzik      heheh
00:23 tadzik      sleep time, o/
00:23 colomon     \o
00:23 timotimo    have a good rest & week, tadzik!
04:32 lizmat      good *, #perl6!
04:43 sorear      o/
05:30 moritz      \o
});

