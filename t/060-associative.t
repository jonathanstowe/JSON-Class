#!/usr/bin/env raku

use v6;

use Test;

use JSON::Class;

class C is JSON::Class {
	has Str %.bla{subset :: of Str where any("ble", "blob")}
};

my $res;
lives-ok {
    $res = C.from-json('{"bla": {"ble": "bli"}}');
    is $res.bla<ble>, 'bli', "and get the right value";
}, "from-json with shaped associative works";


done-testing;
# vim: expandtab shiftwidth=4 ft=raku
