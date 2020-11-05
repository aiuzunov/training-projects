use utf8;
package MyShop::Schema::Result::TagsProduct;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyShop::Schema::Result::TagsProduct

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

=head1 TABLE: C<tags_products>

=cut

__PACKAGE__->table("tags_products");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'tags_products_id_seq'

=head2 product_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 tag_id

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
    sequence          => "tags_products_id_seq",
  },
  "product_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "tag_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</product_id>

=item * L</tag_id>

=back

=cut

__PACKAGE__->set_primary_key("product_id", "tag_id");

=head1 RELATIONS

=head2 product

Type: belongs_to

Related object: L<MyShop::Schema::Result::Product>

=cut

__PACKAGE__->belongs_to(
  "product",
  "MyShop::Schema::Result::Product",
  { id => "product_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 tag

Type: belongs_to

Related object: L<MyShop::Schema::Result::Tag>

=cut

__PACKAGE__->belongs_to(
  "tag",
  "MyShop::Schema::Result::Tag",
  { id => "tag_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-11-04 13:29:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NGyL5fh4xFTx4cGTsO7qdg

__PACKAGE__->many_to_many(products => 'products', 'product');

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
