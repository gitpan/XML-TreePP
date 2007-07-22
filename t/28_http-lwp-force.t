# ----------------------------------------------------------------
    use strict;
    use Test::More;
# ----------------------------------------------------------------
SKIP: {
    local $@;
    eval { require HTTP::Lite; } unless defined $HTTP::Lite::VERSION;
    if ( ! defined $HTTP::Lite::VERSION ) {
        # ok
    }
    eval { require LWP::UserAgent; } unless defined $LWP::UserAgent::VERSION;
    if ( ! defined $LWP::UserAgent::VERSION ) {
        plan skip_all => 'LWP::UserAgent is not loaded.';
    }
    if ( ! defined $ENV{MORE_TESTS} ) {
        plan skip_all => 'define $MORE_TESTS to test this.';
    }
    plan tests => 13;
    use_ok('XML::TreePP');

    my $name = ( $0 =~ m#([^/:\\]+)$# )[0];

    {
        my $tpp = XML::TreePP->new();
        my $http = LWP::UserAgent->new();
        ok( ref $http, 'LWP::UserAgent->new()' );
        $tpp->set( lwp_useragent => $http );
        &test_http_post( $tpp, 'libwww-perl' );
    }
    {
        my $tpp = XML::TreePP->new();
        my $http = LWP::UserAgent->new();
        ok( ref $http, 'LWP::UserAgent->new()' );
        $tpp->set( lwp_useragent => $http );
        $http->agent( "$name " );
        &test_http_post( $tpp, $name );
    }
    {
        my $tpp = XML::TreePP->new();
        my $http = LWP::UserAgent->new();
        ok( ref $http, 'LWP::UserAgent->new()' );
        $tpp->set( user_agent => "$name " );
        &test_http_post( $tpp, $name );
    }
}
# ----------------------------------------------------------------
sub test_http_post {
    my $tpp = shift;
    my $name = shift;
    my $url = "http://www.kawa.net/works/perl/treepp/example/envxml.cgi";
    my( $tree, $xml ) = $tpp->parsehttp( POST => $url, '' );
    ok( ref $tree, $url );
    my $agent = $tree->{env}->{HTTP_USER_AGENT};
    ok( $agent, "User-Agent: $agent" );
    like( $agent, qr/\Q$name\E/, "Test: $name" );
}
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
