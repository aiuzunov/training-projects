use utf8;
package MyShop::Schema::Result::RolesPerm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyShop::Schema::Result::RolesPerm

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

=head1 TABLE: C<roles_perms>

=cut

__PACKAGE__->table("roles_perms");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'roles_perms_id_seq'

=head2 role_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 perm_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "roles_perms_id_seq",
  },
  "role_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "perm_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</role_id>

=item * L</perm_id>

=back

=cut

__PACKAGE__->set_primary_key("role_id", "perm_id");

=head1 RELATIONS

=head2 perm

Type: belongs_to

Related object: L<MyShop::Schema::Result::Permission>

=cut

__PACKAGE__->belongs_to(
  "perm",
  "MyShop::Schema::Result::Permission",
  { id => "perm_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 role

Type: belongs_to

Related object: L<MyShop::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "role",
  "MyShop::Schema::Result::Role",
  { id => "role_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-11-04 13:29:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sh6MC3rIUIybqxG8Z1GxNg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
