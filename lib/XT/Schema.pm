use strict;
use warnings;
 
package XT::Schema;

use Moose;

extends 'DBIx::Class::Schema';

__PACKAGE__->meta->make_immutable;

1;
