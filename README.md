# JSON-Class

A Role to allow Perl 6 objects  to be constructed and serialised from/to JSON.

## Synopsis

```

    use JSON::Class;

    class Something does JSON::Class {
 
        has Str $.foo;

    }

    my Something $something = Something.from-json('{ "foo" : "stuff" }');

    ...

    my Str $json = $something.to-json(); # -> '{ "foo" : "stuff" }'

```

## Description

