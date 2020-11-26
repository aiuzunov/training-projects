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
use lib qw(./Modules);
use MyAsserts;
use MyDBI;

#use open qw(:utf8 :std);

our $dbh;



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
      $dbh=connect();
      assert(defined $dbh,"No connection to the database");
      #MyAsserts::user_assert("scalar_type",\$scalar,"number");
      #MyAsserts::user_assert("defined",$page);
      #MyAsserts::user_assert("ref",\$scalar,"HASH");
      #my $dbh = DBI->connect('dbi:Pg:dbname=onlineshop', 'shopadmin', '1234', {AutoCommit => 1}) or die $DBI::errstr;
      my $page = $c->req->param('page') || 1;
      my $name = $c->request->param('name');
      my $price1 = $c->request->param('price1');
      my $price2 = $c->request->param('price2');
      my @tags = $c->request->param('tags');
      my $query_string;
      my @bind_params;
      my %filter;

    #  assert(defined $dbh);

      if(defined $name && $name ne "")
      {
        user_assert(!looks_like_number($name),"A500","Невалидни данни в полето за търсене по име");
        $filter{'name'} = { ilike => '%'.$name.'%' };
      }
      if(@tags != 0)
      {
        user_assert(ref(\@tags) eq "ARRAY","A501","Невалидни данни в полето за търсене по жанр");
        $filter{tag_id} = { in => [@tags] };
        $query_string = "$query_string and t.id = ANY(?)";
        push @bind_params, [@tags];
      }

      if(defined $price1 && $price1 ne "")
      {
        user_assert(looks_like_number($price1),"A502","Невалидни данни в полето за търсене по Цена[ОТ]");
        $query_string = "$query_string and price >= ?";
        $filter{price}{'>='} = $price1;
        push @bind_params, $price1;
      }

      if(defined $price2 && $price2 ne "")
      {
        user_assert(looks_like_number($price2),"A503","Невалидни данни в полето за търсене по Цена[ДО]");
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
                              p.id,
                              p.name,
                              p.image,
                              p.price,
                              p.count_in_stock,
                              p.has_image,
                              p.description,
                              p.currency_id,
                              p.create_date,
                              p.edit_time,
                              p.brand,
                              p.id_hash,
                              array_agg(t.name) as tagerinos
                              FROM products p
                              join tags_products tp
                              on tp.product_id = p.id
                              join tags t
                              on tp.tag_id = t.id
                              where p.name
                              ilike ? $query_string
                              group by p.id
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
      assert($sth->rows>0,"Грешка при взимането на жанрове от базата");

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
      elsif($error_type eq "internal")
      {
        my $error_msg = $_->{error};
        my $caller_info = $_->{caller_info};
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
      }
      else
      {
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("$_");
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
     $dbh=connect();
     assert(defined $dbh,"No connection to the database");
     my $id = $c->req->params->{id};
     assert(defined $id,"ID not defined");
     my $sth = $dbh->prepare("SELECT p.name,
                              p.image,
                              p.price,
                              p.count_in_stock,
                              p.description,
                              p.currency_id,
                              p.id_hash,
                              array_agg(t.name) as tagerinos
                              from products p
                              join tags_products tp
                              on tp.product_id = p.id
                              join tags t
                              on tp.tag_id = t.id
                              where id_hash = ?
                              group by p.name,
                              p.image,
                              p.price,
                              p.count_in_stock,
                              p.description,
                              p.currency_id,
                              p.id_hash");
     $sth->execute($id);
     assert($sth->rows>0,"Грешка при взимането на информацията за книгата");
     my @rows = ();
     while (my $row = $sth->fetchrow_hashref ) {
       push @rows, $row;
     }
     $c->stash(book => [@rows]);

     # try
     # {
     #   $c->stash(book => [$c->model('DB::Product')->search(
     #  { 'me.id_hash' => $id,},
     #  { join      => {'tags_products'=>'tag'},}
     #  )]);
     # }
     # catch
     # {
     #   $c->stash(error_msg =>  'Application Error!');
     #   $c->log->error($_);
     # };

     $c->stash(template => 'books/details.tt2');
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
       elsif($error_type eq "internal")
       {
         my $error_msg = $_->{error};
         my $caller_info = $_->{caller_info};
         $c->stash(error_msg =>  "Application Error!");
         $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
       }
       else
       {
         $c->stash(error_msg =>  "Application Error!");
         $c->log->error("$_");
       }

     }
     else
     {
       $c->stash(error_msg =>  "Application Error!");
       $c->log->error("$_");
     }
   };
}

__PACKAGE__->meta->make_immutable;




1;
