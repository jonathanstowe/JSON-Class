use v6;

=begin pod

=head1 NAME

JSON::Class - Role to allow a class to unmarshall/marshall itself from JSON

=head1 SYNOPSIS

=begin code

=end code

=head1 DESCRIPTION

=head1 METHODS


=end pod

role JSON::Class {
   use JSON::Unmarshal;

   method from-json(Str $json) {
      unmarshal($json, self);
   }

   method to-json() {

   }

}

# vim: expandtab shiftwidth=4 ft=perl6
