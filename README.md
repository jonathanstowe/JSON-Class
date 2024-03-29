# JSON::Class

A Role to allow Raku objects  to be constructed and serialised from/to JSON.

![Build Status](https://github.com/jonathanstowe/JSON-Class/workflows/CI/badge.svg)

## Synopsis

```raku

    use JSON::Class;

    class Something does JSON::Class {
 
        has Str $.foo;

    }

    my Something $something = Something.from-json('{ "foo" : "stuff" }');

    ...

    my Str $json = $something.to-json(); # -> '{ "foo" : "stuff" }'

```

or with 'opt-in' serialization:

```raku

    use JSON::Class;
    use JSON::OptIn;

    class Something does JSON::Class[:opt-in] {
 
        has Str $.foo is json;
        has Str $.secret = 'secret';

    }

    my Something $something = Something.from-json('{ "foo" : "stuff" }');

    ...

    my Str $json = $something.to-json(); # -> '{ "foo" : "stuff" }'

```

## Description

This is a simple role that provides methods to instantiate a class from a
JSON string that (hopefully,) represents it, and to serialise an object of
the class to a JSON string.  The JSON created from an instance should
round trip to a new instance with the same values for the "public attributes".
"Private" attributes (that is ones without accessors,) will be ignored for
both serialisation and de-serialisation.  The exact behaviour depends on that
of [JSON::Marshal](https://github.com/jonathanstowe/JSON-Marshal) and
[JSON::Unmarshal](https://github.com/tadzik/JSON-Unmarshal) respectively.


If the `:skip-null` adverb is provided to `to-json` all attributes
without a defined value will be ignored in serialisation. If you need
finer grained control then you should apply the `json-skip-null`
attribute trait (defined by `JSON::Marshal` ) to the attributes you
want to skip if they aren't defined (`:skip-null` will still have
the same effect though.)

If you don't need prettified, human readable JSON output then you can supply
the `:!pretty` adverb to `to-json`.

The  [JSON::Marshal](https://github.com/jonathanstowe/JSON-Marshal) and
[JSON::Unmarshal](https://github.com/tadzik/JSON-Unmarshal) provide traits
for controlling the unmarshalling/marshalling of specific attributes which are
re-exported by the module.

If your application exposes the marshalled data via, for example, an API, then
you may choose to use the `:opt-in` parameter to the role, which will cause only
those attributes that are explicitly marked to be marshalled, avoiding the risk
of inadvertently exposing sensitive data.  This is described in more detail in 
[JSON::Marshal](https://github.com/jonathanstowe/JSON-Marshal).

## Installation

Assuming you have a working Rakudo installation you should be able to install this with *zef* :

    # From the source directory
   
    zef install .

    # Remote installation

    zef install JSON::Class


## Support

Suggestions/patches are welcomed via github at:

https://github.com/jonathanstowe/JSON-Class

## Licence

This is free software.

Please see the (LICENCE)[LICENCE] file in the distribution for the details.

© Jonathan Stowe 2015, 2016, 2017, 2019, 2020, 2021
