use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'XML-TreePP',
    VERSION_FROM        => 'lib/XML/TreePP.pm',
    PREREQ_PM           => {
        'Test::More'    => '0',
    },
);
