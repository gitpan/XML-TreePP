# ----------------------------------------------------------------
    use strict;
    use Test::More tests => 4;
    BEGIN { use_ok('XML::TreePP') };
# ----------------------------------------------------------------
    my $tpp = XML::TreePP->new( force_array => [qw( one two three )] );
    my $source = '<root><one>CCC</one><two>DDD</two><two>EEE</two><three/><three/><three/></root>';
    my $tree = $tpp->parse( $source );

#use Data::Dumper;
#warn Dumper( $tree );

    ok( 1 == scalar @{$tree->{root}->{one}}, "one force_array node" );
    ok( 2 == scalar @{$tree->{root}->{two}}, "two child nodes" );
    ok( 3 == scalar @{$tree->{root}->{three}}, "three empty nodes" );
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
