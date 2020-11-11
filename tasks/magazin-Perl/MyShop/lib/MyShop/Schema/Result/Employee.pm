use utf8;
package MyShop::Schema::Result::Employee;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyShop::Schema::Result::Employee

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

=head1 TABLE: C<employees>

=cut

__PACKAGE__->table("employees");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'employees_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 username

  data_type: 'text'
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 password

  data_type: 'text'
  is_nullable: 0

=head2 role_id

  data_type: 'bigint'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "employees_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "username",
  { data_type => "text", is_nullable => 0 },
  "email",
  { data_type => "text", is_nullable => 0 },
  "password",
  { data_type => "text", is_nullable => 0 },
  "role_id",
  {
    data_type      => "bigint",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<employees_email_key>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("employees_email_key", ["email"]);

=head1 RELATIONS

=head2 employee_roles

Type: has_many

Related object: L<MyShop::Schema::Result::EmployeeRole>

=cut

__PACKAGE__->has_many(
  "employee_roles",
  "MyShop::Schema::Result::EmployeeRole",
  { "foreign.employee_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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

=head2 roles

Type: many_to_many

Composing rels: L</employee_roles> -> role

=cut

__PACKAGE__->many_to_many("roles", "employee_roles", "role");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-11-11 12:07:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CmqdZ597HCSc0F8d4+nZHg

__PACKAGE__->add_columns(
    'password' => {
        passphrase       => 'rfc2307',
        passphrase_class => 'SaltedDigest',
        passphrase_args  => {
            algorithm   => 'SHA-1',
            salt_random => 20,
        },
        passphrase_check_method => 'check_password',
    },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
