# ----------------------------------------------------------------
    use strict;
    use Test::More tests => 5;
    BEGIN { use_ok('XML::TreePP') };
# ----------------------------------------------------------------
SKIP: {
    local $@;
    eval { require LWP::UserAgent; };
    if ( ! defined $LWP::UserAgent::VERSION ) {
        skip( "LWP::UserAgent is not loaded.", 4 );
    }
    &parsehttp_get();
    &parsehttp_post();
}
# ----------------------------------------------------------------
sub parsehttp_get {
    my $tpp = XML::TreePP->new();
    my $url = "http://use.perl.org/index.rss";
    my $tree = $tpp->parsehttp( GET => $url );
    ok( ref $tree, $url );
    like( $tree->{"rdf:RDF"}->{channel}->{link}, qr{^http://}, $url );
}
# ----------------------------------------------------------------
sub parsehttp_post {
    my $tpp = XML::TreePP->new( force_array => [qw( item )] );
    my $url = "http://search.hatena.ne.jp/keyword";
    my $query = "ajax";
    my $body = "mode=rss2&word=".$query;
    my $tree = $tpp->parsehttp( POST => $url, $body );
    ok( ref $tree, $url );
    like( $tree->{rss}->{channel}->{item}->[0]->{link}, qr{^http://}, $url );
}
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
