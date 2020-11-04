use utf8;
package MyShop::Schema::Result::Product;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyShop::Schema::Result::Product

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

=head1 TABLE: C<products>

=cut

__PACKAGE__->table("products");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'products_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 image

  data_type: 'text'
  is_nullable: 0

=head2 price

  data_type: 'numeric'
  is_nullable: 0

=head2 count_in_stock

  data_type: 'integer'
  is_nullable: 0

=head2 has_image

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 0

=head2 currency_id

  data_type: 'text'
  default_value: 'EUR'
  is_foreign_key: 1
  is_nullable: 0

=head2 create_date

  data_type: 'timestamp'
  is_nullable: 0

=head2 edit_time

  data_type: 'text'
  is_nullable: 1

=head2 brand

  data_type: 'text'
  default_value: 'No brand'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "products_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "image",
  { data_type => "text", is_nullable => 0 },
  "price",
  { data_type => "numeric", is_nullable => 0 },
  "count_in_stock",
  { data_type => "integer", is_nullable => 0 },
  "has_image",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "currency_id",
  {
    data_type      => "text",
    default_value  => "EUR",
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "create_date",
  { data_type => "timestamp", is_nullable => 0 },
  "edit_time",
  { data_type => "text", is_nullable => 1 },
  "brand",
  { data_type => "text", default_value => "No brand", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<products_name_key>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("products_name_key", ["name"]);

=head1 RELATIONS

=head2 cart_items

Type: has_many

Related object: L<MyShop::Schema::Result::CartItem>

=cut

__PACKAGE__->has_many(
  "cart_items",
  "MyShop::Schema::Result::CartItem",
  { "foreign.product_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 currency

Type: belongs_to

Related object: L<MyShop::Schema::Result::Currency>

=cut

__PACKAGE__->belongs_to(
  "currency",
  "MyShop::Schema::Result::Currency",
  { currency_id => "currency_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 order_items

Type: has_many

Related object: L<MyShop::Schema::Result::OrderItem>

=cut

__PACKAGE__->has_many(
  "order_items",
  "MyShop::Schema::Result::OrderItem",
  { "foreign.product_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 products_details

Type: has_many

Related object: L<MyShop::Schema::Result::ProductsDetail>

=cut

__PACKAGE__->has_many(
  "products_details",
  "MyShop::Schema::Result::ProductsDetail",
  { "foreign.product_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags_products

Type: has_many

Related object: L<MyShop::Schema::Result::TagsProduct>

=cut

__PACKAGE__->has_many(
  "tags_products",
  "MyShop::Schema::Result::TagsProduct",
  { "foreign.product_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-11-04 13:29:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VqUeuim0dpLD8DlmWytYfQ

__PACKAGE__->many_to_many(tags => 'tags_products', 'tag');

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
