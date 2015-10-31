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

=head1 DESCRIPTION

=head1 METHODS


=end pod

role JSON::Class {
   use JSON::Unmarshal;
   use JSON::Marshal;

   method from-json(Str $json) {
      unmarshal($json, self);
   }

   method to-json() {
       marshal(self);
   }
}

# vim: expandtab shiftwidth=4 ft=perl6
