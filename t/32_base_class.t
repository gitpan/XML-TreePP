# ----------------------------------------------------------------
    use strict;
    use Test::More;
# ----------------------------------------------------------------
{
    plan tests => 10;
    use_ok('XML::TreePP');
    &test_base_class( force_array => [qw( six )], base_class => 'Data' );
}
# ----------------------------------------------------------------
sub test_base_class {
    my $tpp = XML::TreePP->new(@_);

    my $xml = <<"EOT";
<root>
    <one>1</one>
    <two attr="-2">2</two>
    <three>
        <four>4</four>
        <five>
            5
            <empty/>
            5
        </five>
    </three>
    <six><seven attr="-7">7</seven></six>
    <eight>8</eight>
    <eight><nine>9</nine></eight>
</root>
EOT

    my $tree = $tpp->parse( $xml );
    is( ref $tree->{root},                  'Data::root',       '/root' );
    is( ref $tree->{root}->{two},           'Data::root::two',  '/root/two' );
    is( ref $tree->{root}->{three},         'Data::root::three', '/root/three' );
    is( ref $tree->{root}->{three}->{five}, 'Data::root::three::five', '/root/three/five' );
    is( ref $tree->{root}->{six},           'ARRAY',            '/root/six (ARRAY)' );
    is( ref $tree->{root}->{six}->[0],      'Data::root::six',  '/root/six' );
    is( ref $tree->{root}->{six}->[0]->{seven},                 'Data::root::six::seven', '/root/six/seven' );
    is( ref $tree->{root}->{eight},         'ARRAY',            '/root/eight (ARRAY)' );
    is( ref $tree->{root}->{eight}->[1],   'Data::root::eight', '/root/eight' );
}
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
