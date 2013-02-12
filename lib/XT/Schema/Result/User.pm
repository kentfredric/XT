use strict;
use warnings;

package XT::Schema::Result::User;

use Moose;

extends 'DBIx::Class::Core';

__PACKAGE__->table('user');
__PACKAGE__->add_column(
    'id' => {
        is_numeric         => 1,
        is_nullable        => 0,
        is_auto_increment  => 1,
        sequence           => 'user_id_seq',
        retrieve_on_insert => 1,
        auto_nextval       => 1,
    },
);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( user_id_unique => ['id'] );
__PACKAGE__->meta->make_immutable;

1;

