use v6;

=begin pod

=head1 NAME

JSON::Class - Role to allow a class to unmarshall/marshall itself from JSON

=head1 SYNOPSIS

=begin code

    use JSON::Class;

    class Something does JSON::Class {

        has Str $.foo;

    }

    my Something $something = Something.from-json('{ "foo" : "stuff" }');

    ...

    my Str $json = $something.to-json(); # -> '{ "foo" : "stuff" }'


=end code

Or with C<:opt-in> marshalling:

=begin code


    use JSON::Class;
    use JSON::OptIn;

    class Something does JSON::Class[:opt-in] {

        has Str $.foo is json;
        has Str $.secret = 'secret';

    }

    my Something $something = Something.from-json('{ "foo" : "stuff" }');

    ...

    my Str $json = $something.to-json(); # -> '{ "foo" : "stuff" }'

=end code

=head1 DESCRIPTION

This is a simple role that provides methods to instantiate a class from a
JSON string that (hopefully,) represents it, and to serialise an object of
the class to a JSON string.  The JSON created from an instance should
round trip to a new instance with the same values for the "public attributes".
"Private" attributes (that is ones without accessors,) will be ignored for
both serialisation and de-serialisation.  The exact behaviour depends on that
of L<JSON::Marshal|https://github.com/jonathanstowe/JSON-Marshal> and
L<JSON::Unmarshal|https://github.com/tadzik/JSON-Unmarshal> respectively.

The  L<JSON::Marshal|https://github.com/jonathanstowe/JSON-Marshal> and
L<JSON::Unmarshal|https://github.com/tadzik/JSON-Unmarshal> provide traits
for controlling the unmarshalling/marshalling of specific attributes which
are re-exported by this module.

If your application exposes the marshalled data via, for example, an API, then
you may choose to use the C<:opt-in> parameter to the role, which will cause only
those attributes that are explicitly marked to be marshalled, avoiding the risk
of inadvertently exposing sensitive data.  This is described in more detail in
L<JSON::Marshal|https://github.com/jonathanstowe/JSON-Marshal>.


=head1 METHODS

=head2 method from-json

    method from-json(Str $json) returns JSON::Class

Deserialises the provided JSON string, returning a new object, with the
public attributes initialised with the corresponding values in the JSON
structure.

If the JSON is not valid or the data cannot be coerced into the correct
type for the target class then an exception may be thrown.

=head2 method to-json

    method to-json(Bool :$skip-null, Bool :$sorted-keys, Bool :$pretty = True ) returns Str

Serialises the public attributes of the object to a JSON string that
represents the object, this JSON can be fed to the L<from-json> of the
class to create a new object with matching (public) attributes.

If the C<:skip-null> adverb is provided all attributes without a
defined value will be ignored in serialisation. If you need finer
grained control then you should apply the C<json-skip-null> attribute
trait (defined by L<JSON::Marshal> ) to the traits you want to skip
if they aren't defined (C<:json-skip> will still have the same effect
though.)

If the C<sorted-keys> adverb is provided this will eventually be passed
to the JSON generation and will cause the keys in the JSON object to be
sorted in the output.

The adverb C<pretty> is true by default, if you want to suppress I<pretty>
formatting of the output (that is no un-necessary white space,) then
you can supply C<:!pretty>.

=end pod

use JSON::Unmarshal:ver<0.14+>;
use JSON::Marshal:ver<0.0.25+>;

my package EXPORT::DEFAULT {
    OUR::{'&trait_mod:<is>'} := &trait_mod:<is>;
}

role JSON::Class:ver<0.0.21>:auth<zef:jonathanstowe>[Bool :$opt-in = False] {


    method from-json(Str $json --> JSON::Class ) {
        my $ret = unmarshal($json, self);
        if $ret !~~ JSON::Class {
            $ret does JSON::Class;
        }
        $ret;
    }

    method to-json(Bool :$skip-null, Bool :$sorted-keys = False, Bool :$pretty = True --> Str ) {
        marshal(self, :$skip-null, :$sorted-keys, :$pretty, :$opt-in);
    }
}

# vim: expandtab shiftwidth=4 ft=raku
