use utf8;
package MyShop::Schema::Result::LockSetting;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyShop::Schema::Result::LockSetting

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<lock_settings>

=cut

__PACKAGE__->table("lock_settings");

=head1 ACCESSORS

=head2 firstlock

  data_type: 'bigint'
  is_nullable: 0

=head2 secondlock

  data_type: 'bigint'
  is_nullable: 0

=head2 timeafterfirstlock

  data_type: 'bigint'
  is_nullable: 0

=head2 timeaftersecondlock

  data_type: 'bigint'
  is_nullable: 0

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'lock_settings_id_seq'

=cut

__PACKAGE__->add_columns(
  "firstlock",
  { data_type => "bigint", is_nullable => 0 },
  "secondlock",
  { data_type => "bigint", is_nullable => 0 },
  "timeafterfirstlock",
  { data_type => "bigint", is_nullable => 0 },
  "timeaftersecondlock",
  { data_type => "bigint", is_nullable => 0 },
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "lock_settings_id_seq",
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-11-04 13:29:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KXCJ3ZTZYoh1CpZUBmM81A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
