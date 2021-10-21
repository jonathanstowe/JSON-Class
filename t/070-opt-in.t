#!/usr/bin/env raku

use Test;
use JSON::Class;
use JSON::OptIn;
use JSON::Name;
use JSON::Fast;

class TestOptIn does JSON::Class[:opt-in] {
    has Str $.secret = "secret";
    has Str $.public is json = "public";
    has Str $.named  is json-name('Named') = "named";
}

my $obj = TestOptIn.new;

my $json = $obj.to-json;

my %data = from-json($json);

is %data<public>, 'public', 'got opted-in attribute';
is %data<Named>, 'named', 'got implicit attribute';
ok not %data<secret>:exists, "Don't have the not opted in attribute";

done-testing;
# vim: ft=raku
