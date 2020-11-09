use utf8;
package MyShop::Schema::Result::Tag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyShop::Schema::Result::Tag

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

=head1 TABLE: C<tags>

=cut

__PACKAGE__->table("tags");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'tags_id_seq'

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
    sequence          => "tags_id_seq",
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

=head1 UNIQUE CONSTRAINTS

=head2 C<tags_name_key>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("tags_name_key", ["name"]);

=head1 RELATIONS

=head2 tags_products

Type: has_many

Related object: L<MyShop::Schema::Result::TagsProduct>

=cut

__PACKAGE__->has_many(
  "tags_products",
  "MyShop::Schema::Result::TagsProduct",
  { "foreign.tag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 products

Type: many_to_many

Composing rels: L</tags_products> -> product

=cut

__PACKAGE__->many_to_many("products", "tags_products", "product");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-11-09 11:40:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ACy9xKLneSZLfe7mlArzIg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
