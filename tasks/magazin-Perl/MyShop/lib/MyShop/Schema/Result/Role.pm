use utf8;
package MyShop::Schema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyShop::Schema::Result::Role

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

=head1 TABLE: C<roles>

=cut

__PACKAGE__->table("roles");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'roles_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "roles_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 employee_roles

Type: has_many

Related object: L<MyShop::Schema::Result::EmployeeRole>

=cut

__PACKAGE__->has_many(
  "employee_roles",
  "MyShop::Schema::Result::EmployeeRole",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 employees_2s

Type: has_many

Related object: L<MyShop::Schema::Result::Employee>

=cut

__PACKAGE__->has_many(
  "employees_2s",
  "MyShop::Schema::Result::Employee",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 roles_perms

Type: has_many

Related object: L<MyShop::Schema::Result::RolesPerm>

=cut

__PACKAGE__->has_many(
  "roles_perms",
  "MyShop::Schema::Result::RolesPerm",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 employees

Type: many_to_many

Composing rels: L</employee_roles> -> employee

=cut

__PACKAGE__->many_to_many("employees", "employee_roles", "employee");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-11-11 12:07:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:v6JhXqKIagT8gh346YmDiA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
