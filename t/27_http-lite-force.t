# ----------------------------------------------------------------
    use strict;
    use Test::More;
# ----------------------------------------------------------------
SKIP: {
    local $@;
    eval { require HTTP::Lite; } unless defined $HTTP::Lite::VERSION;
    if ( ! defined $HTTP::Lite::VERSION ) {
        plan skip_all => 'HTTP::Lite is not loaded.';
    }
    eval { require LWP::UserAgent; } unless defined $LWP::UserAgent::VERSION;
    if ( ! defined $LWP::UserAgent::VERSION ) {
        # ok
    }
    if ( ! defined $ENV{MORE_TESTS} ) {
        plan skip_all => 'define $MORE_TESTS to test this.';
    }
    plan tests => 5;
    use_ok('XML::TreePP');

    my $tpp = XML::TreePP->new();

    my $http = HTTP::Lite->new();
    ok( ref $http, 'HTTP::Lite->new()' );
    $tpp->set( http_lite => $http );
    $tpp->set( user_agent => '' );
    &test_http_post( $tpp );     # use HTTP::Lite
}
# ----------------------------------------------------------------
sub test_http_post {
    my $tpp = shift;
    my $url = "http://www.kawa.net/works/perl/treepp/example/envxml.cgi";
    my( $tree, $xml ) = $tpp->parsehttp( POST => $url, '' );
    ok( ref $tree, $url );
    my $agent = $tree->{env}->{HTTP_USER_AGENT};
    ok( $agent, "User-Agent: $agent" );
    like( $agent, qr/HTTP::Lite/, "Test: HTTP::Lite" );
}
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
