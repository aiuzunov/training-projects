package MyShop::Controller::Books;
use Moose;
use namespace::autoclean;
use utf8;
use Scalar::Util qw(looks_like_number);
use Data::Paginator;
#use open qw(:utf8 :std);

BEGIN { extends 'Catalyst::Controller'; }
__PACKAGE__->config(

    root_dir => 'static/images',


    cache_dir => undef,


    default_format => 'jpg',

    max_size => 1000,

    thumbnail_size => 80,

    jpeg_quality => 95,
);

=head1 NAME

MyShop::Controller::Books - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MyShop::Controller::Books in Books.');
}



=encoding utf8

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

=head2 list


=cut
sub list :Local {
    my ($self, $c) = @_;
    my $page = $c->req->param('page');
    my $name = $c->request->param('name');
    my $price1 = $c->request->param('price1') || 0;
    my $price2 = $c->request->param('price2') || 100;
    my @tags = $c->request->param('tags');
    my %filter;
    
    if($name ne undef){
      $filter{name} = { like => '%'.$name.'%' };
    }

    if(@tags != 0){
      $filter{tag_id} = { in => [@tags] };
    }

    $filter{price} = { '>=', $price1,'<=', $price2 };

    warn @tags;
    if($c->req->param('submit') eq 'Submit'){
      $page = 1;
      $c->stash(search_name => $name, price => $price1, price2 => $price2, tags => [@tags]);
    }else{
      $c->stash(search_name => $name, price1 => $price1, price2 => $price2, tags => [@tags]);
    }

    if(!looks_like_number($page)){
    $page = 1;
    }

    $c->stash(books => [$c->model('DB::Product')->search({%filter}, {
           page => $page,
           rows => 10,
           join      => {'tags_products'=>'tag'},
           order_by => {-asc => 'id'},
           group_by => 'id',
      })]);
    $c->stash(select_tags => [$c->model('DB::Tag')->all()]);

    $c->stash(template => 'books/list.tt2',page => $page);
}

=head2 details


=cut
sub details :Local {

   my ($self, $c) = @_;
   my $id = $c->req->params->{id};


   $c->stash(book => [$c->model('DB::Product')->search(
  { 'me.id' => $id,
  },
  { join      => {'tags_products'=>'tag'},
  }
)]);


   $c->stash(template => 'books/details.tt2');
}
    #my $page = $c->req->params->{page};

#     $c->stash(tset => [$c->model('DB::Product')->all]);
#     $c->stash(books => [$c->model('DB::Product')->search({
#   name => 'Книга18'
# })]);


1;
