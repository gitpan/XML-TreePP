# ----------------------------------------------------------------
    use strict;
    use Test::More tests => 4;
    BEGIN { use_ok('XML::TreePP') };
# ----------------------------------------------------------------
    my $tpp = XML::TreePP->new();
    my $tree = { rss => { channel => { item => [ {
        title   => "The Perl Directory",
        link    => "http://www.perl.org/",
    }, { 
        title   => "The Comprehensive Perl Archive Network",
        link    => "http://cpan.perl.org/",
    } ] } } };
    my $xml = $tpp->write( $tree );
    like( $xml, qr{^<\?xml version="1.0" encoding="UTF-8"}, "xmldecl" );
    like( $xml, qr{<rss>.*</rss>}s, "rss" );

    my $back = $tpp->parse( $xml );
    is_deeply( $tree, $back, "write and parse" );
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
