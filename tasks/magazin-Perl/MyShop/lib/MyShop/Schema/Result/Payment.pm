use utf8;
package MyShop::Schema::Result::Payment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyShop::Schema::Result::Payment

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

=head1 TABLE: C<payments>

=cut

__PACKAGE__->table("payments");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'payments_id_seq'

=head2 cancelled

  data_type: 'text'
  is_nullable: 0

=head2 paid

  data_type: 'text'
  is_nullable: 0

=head2 time_of_payment

  data_type: 'text'
  is_nullable: 0

=head2 recipient_name

  data_type: 'text'
  is_nullable: 0

=head2 recipient_email

  data_type: 'text'
  is_nullable: 0

=head2 payerid

  data_type: 'text'
  is_nullable: 0

=head2 paymentid

  data_type: 'text'
  is_nullable: 0

=head2 paymenttoken

  data_type: 'text'
  is_nullable: 0

=head2 payment_sum

  data_type: 'numeric'
  is_nullable: 0

=head2 currency

  data_type: 'text'
  is_nullable: 0

=head2 order_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "payments_id_seq",
  },
  "cancelled",
  { data_type => "text", is_nullable => 0 },
  "paid",
  { data_type => "text", is_nullable => 0 },
  "time_of_payment",
  { data_type => "text", is_nullable => 0 },
  "recipient_name",
  { data_type => "text", is_nullable => 0 },
  "recipient_email",
  { data_type => "text", is_nullable => 0 },
  "payerid",
  { data_type => "text", is_nullable => 0 },
  "paymentid",
  { data_type => "text", is_nullable => 0 },
  "paymenttoken",
  { data_type => "text", is_nullable => 0 },
  "payment_sum",
  { data_type => "numeric", is_nullable => 0 },
  "currency",
  { data_type => "text", is_nullable => 0 },
  "order_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<payments_paymentid_key>

=over 4

=item * L</paymentid>

=back

=cut

__PACKAGE__->add_unique_constraint("payments_paymentid_key", ["paymentid"]);

=head1 RELATIONS

=head2 order

Type: belongs_to

Related object: L<MyShop::Schema::Result::Order>

=cut

__PACKAGE__->belongs_to(
  "order",
  "MyShop::Schema::Result::Order",
  { id => "order_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-11-16 16:07:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5581CkJkd3hTaksyLN787g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
