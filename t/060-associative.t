#!/usr/bin/env perl6

use v6.c;

use Test;

use JSON::Class;

class C is JSON::Class {
	has Str %.bla{subset :: of Str where any("ble", "blob")}
};

my $res;
lives-ok {
    $res = C.from-json('{"bla": {"ble": "bli"}}');
}, "from-json with shaped associative works";

is $res.bla<ble>, 'bli', "and get the right value";

done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
