# ----------------------------------------------------------------
    use strict;
    use Test::More tests => 11;
    BEGIN { use_ok('XML::TreePP') };
# ----------------------------------------------------------------
    my $source = '<root><foo bar="hoge" /></root>';

    my $tpp = XML::TreePP->new();

    my $tree1 = $tpp->parse( $source );
    is( $tree1->{root}->{foo}->{'-bar'}, 'hoge', "parse: default" );

    my $test = $source;
    $test =~ s/\s+//sg;

    foreach my $prefix ( '-', '@', '__', '?}{][)(' ) {
        $tpp->set( attr_prefix => $prefix );
        my $tree = $tpp->parse( $source );
        is( $tree->{root}->{foo}->{$prefix.'bar'}, 'hoge', "parse: $prefix" );

        my $back = $tpp->write( $tree );
        $back =~ s/\s+//sg;
        $back =~ s/<\?.*?\?>//s;
        is( $test, $back, "write: $prefix" );
    }

    $tpp->set( "attr_prefix" );               # remove attr_prefix
    my $tree2 = $tpp->parse( $source );
    is( $tree2->{root}->{foo}->{'-bar'}, 'hoge', "parse: default (again)" );
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
