package MyShop::Controller::Books;
use Moose;
use namespace::autoclean;
use utf8;
use Scalar::Util qw(looks_like_number);
use Data::Paginator;
use strict;
use warnings;
use DBI;
use Try::Tiny;
use MyShop::MyAsserts;
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



sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MyShop::Controller::Books in Books.');
}




sub list :Local {
    my ($self, $c) = @_;

    try
    {
      my $dbh = DBI->connect('dbi:Pg:dbname=onlineshop', 'shopadmin', '1234', {AutoCommit => 1}) or die $DBI::errstr;

      #MyAsserts::user_assert("scalar_type",\$scalar,"number");
      #MyAsserts::user_assert("defined",$page);
      #MyAsserts::user_assert("ref",\$scalar,"HASH");

      my $page = $c->req->param('page') || 1;
      my $name = $c->request->param('name');
      my $price1 = $c->request->param('price1');
      my $price2 = $c->request->param('price2');
      my @tags = $c->request->param('tags');
      my $query_string;
      my @bind_params;
      my %filter;
      if(defined $name && $name ne "")
      {
        MyAsserts::user_assert(!looks_like_number($name),"Невалидни данни в полето за търсене по име","user");
        $filter{'name'} = { ilike => '%'.$name.'%' };
      }

      if(@tags != 0)
      {
        MyAsserts::user_assert(ref(\@tags) eq "ARRAY","Невалидни данни в полето за търсене по жанр","user");
        $filter{tag_id} = { in => [@tags] };
        $query_string = "$query_string and tags.id = ANY(?)";
        push @bind_params, [@tags];
      }

      if(defined $price1 && $price1 ne "")
      {
        MyAsserts::user_assert(looks_like_number($price1),"Невалидни данни в полето за търсене по Цена[ОТ]","user");
        $query_string = "$query_string and price >= ?";
        $filter{price}{'>='} = $price1;
        push @bind_params, $price1;
      }

      if(defined $price2 && $price2 ne "")
      {
        MyAsserts::user_assert(looks_like_number($price2),"Невалидни данни в полето за търсене по Цена[ДО]","user");
        $query_string = "$query_string and price <= ?";
        $filter{price}{'<='} = $price2;
        push @bind_params, $price2;
      }


      if($c->req->param('submit') eq 'Submit')
      {
        $page = 1;
        $c->stash(search_name => $name, price1 => $price1, price2 => $price2, tags => [@tags]);
      }
      else
      {
        $c->stash(search_name => $name, price1 => $price1, price2 => $price2, tags => [@tags]);
      }

      if(!looks_like_number($page))
      {
        $page = 1;
      }
      my $offset = ($page-1)*10;

      my $sth = $dbh->prepare("SELECT
                              me.id,
                              me.name,
                              me.image,
                              me.price,
                              me.count_in_stock,
                              me.has_image,
                              me.description,
                              me.currency_id,
                              me.create_date,
                              me.edit_time,
                              me.brand,
                              me.id_hash,
                              array_agg(tags.name) as tagerinos
                              FROM products me
                              join tags_products
                              on tags_products.product_id = me.id
                              join tags
                              on tags_products.tag_id = tags.id
                              where me.name
                              ilike ? $query_string
                              group by me.id
                              LIMIT 10
                              OFFSET ?");
      $sth->execute('%'.$name.'%',@bind_params, $offset);
      my @rows;
      while ( my $row = $sth->fetchrow_hashref ) {
          push @rows, $row;
      }
      $c->stash(books => [@rows]);
      # $c->stash(books => [$c->model('DB::Product')->search({%filter}, {
      #        page => $page,
      #        rows => 10,
      #        join      => {'tags_products'=>'tag'},
      #        order_by => {-asc => 'id'},
      #        group_by => 'id',
      #   })]);
      $sth = $dbh->prepare("SELECT * from tags");
      $sth->execute();
      @rows = ();
      while (my $row = $sth->fetchrow_hashref ) {
        push @rows, $row;
      }
      $c->stash(select_tags => [@rows]);

      # $c->stash(select_tags => [$c->model('DB::Tag')->all()]);
      $c->stash(template => 'books/list.tt2',page => $page);
  }
  catch
  {
    if(ref($_) eq "HASH")
    {
      my $error_type =$_->{type};
      if($error_type eq "user")
      {
        my $error_msg = $_->{error};
        my $caller_info = $_->{caller_info};
        $c->stash(error_msg =>  "$error_msg");
        $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
      }
    }
    else
    {
      $c->stash(error_msg =>  "Application Error!");
      $c->log->error("$_");
    }
  };
}


sub details :Local {
   my ($self, $c) = @_;
   try
   {
     my $id = $c->req->params->{id};

     try
     {
       $c->stash(book => [$c->model('DB::Product')->search(
      { 'me.id_hash' => $id,},
      { join      => {'tags_products'=>'tag'},}
      )]);
     }
     catch
     {
       $c->stash(error_msg =>  'Application Error!');
       $c->log->error($_);
     };

     $c->stash(template => 'books/details.tt2');
   }
   catch
   {
     $c->stash(error_msg =>  'Application Error!');
     $c->log->error($_);
   };
}

__PACKAGE__->meta->make_immutable;


    #my $page = $c->req->params->{page};

#     $c->stash(tset => [$c->model('DB::Product')->all]);
#     $c->stash(books => [$c->model('DB::Product')->search({
#   name => 'Книга18'
# })]);


1;
