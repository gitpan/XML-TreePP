# ----------------------------------------------------------------
    use strict;
    use Test::More;
# ----------------------------------------------------------------
SKIP: {
    local $@;
    eval { require LWP::UserAgent; } unless defined $LWP::UserAgent::VERSION;
    if ( ! defined $LWP::UserAgent::VERSION ) {
        plan skip_all =>  'LWP::UserAgent is not loaded.';
    }
    if ( ! defined $ENV{MORE_TESTS} ) {
        plan skip_all => 'define $MORE_TESTS to test LWP::UserAgent.';
    }
    plan tests => 5;
    use_ok('XML::TreePP');
    &parsehttp_get();
    &parsehttp_post();
}
# ----------------------------------------------------------------
sub parsehttp_get {
    my $tpp = XML::TreePP->new();
    my $name = ( $0 =~ m#([^/:\\]+)$# )[0];
    $tpp->set( user_agent => "$name " );
    my $url = "http://rss.slashdot.org/Slashdot/slashdot";
    my $tree = $tpp->parsehttp( GET => $url );
    ok( ref $tree, $url );
    like( $tree->{"rss"}->{channel}->{link}, qr{^http://}, "$url link" );
}
# ----------------------------------------------------------------
sub parsehttp_post {
    my $tpp = XML::TreePP->new( force_array => [qw( item )] );
    my $name = ( $0 =~ m#([^/:\\]+)$# )[0];
    $tpp->set( user_agent => "$name " );
    my $url = "http://search.hatena.ne.jp/keyword";
    my $query = "ajax";
    my $body = "mode=rss2&word=".$query;
    my $tree = $tpp->parsehttp( POST => $url, $body );
    ok( ref $tree, $url );
    like( $tree->{rss}->{channel}->{item}->[0]->{link}, qr{^http://}, "$url link" );
}
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
