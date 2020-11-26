package MyShop::Controller::Admin;
use Moose;
use namespace::autoclean;
use utf8;
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use Try::Tiny;
use URI::Escape;
use JSON;
use DBI;
use lib qw(./Modules);
use MyAsserts;
use MyDBI;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

our $dbh;

=head1 NAME

MyShop::Controller::Admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    try
    {
      $c->response->body('Matched MyShop::Controller::Admin in Admin.');
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };

}
sub access_denied : Private {
    my ($self, $c) = @_;
    try
    {
      $c->stash->{error_msg} = 'Нямате достъп!';
      $c->forward('denied');
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };

}

sub auto :Private {
    my ($self, $c) = @_;
    try
    {
    if ( $c->request->path =~ /login/ )
    {
      return 1;
    }

    if (!$c->user_in_realm('employees'))
    {
      $c->redirect('/admin/login');
    }

    return 1;
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
}

# sub test :Local{
#   my ($self, $c) = @_;
#   my %hash = (hash=>"hash");
#
#   my $scalar;
#   try
#   {
#     MyAsserts::user_assert("defined",$scalar);
#   }
#   catch
#     {
#       my $error_msg = $_->{error};
#       $c->stash(error_msg =>  "$error_msg");
#       $c->log->error($error_msg);
#     };
# }

sub denied :Local{
  my ($self, $c) = @_;
  try
  {
    $c->stash(template => 'admin/denied.tt2');
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}

sub login :Local {
  my ($self, $c) = @_;
  try
  {
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};

    $c->logout();

    if ($username && $password)
    {
      if ( $c->authenticate( { username => $username,
                               password => $password }, 'employees') )
      {
        $c->response->redirect($c->uri_for(
        $c->controller('Admin')->action_for('products')));
        return;
      }
      else
      {
        $c->stash(error_msg => "Грешно име или парола.");
      }
    }
    else
    {
        $c->stash(error_msg => "Невъведено име или парола.")
        unless ($c->user_exists);
    }

    $c->stash(template => 'admin/login.tt2');
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}

sub logout :Local {
    my ($self, $c) = @_;
    try
    {
      $c->logout();
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
    # warn $c->user_in_realm('employees')
    # warn $c->user()->name;
    # warn $c->employee()

    # $c->response->redirect($c->uri_for('/'));
}


sub create :Local :FormConfig('admin/create_update.yml') {
   my ($self, $c) = @_;
   try
   {
     my $form = $c->stash->{form};

     if ($form->submitted_and_valid)
     {
       try
       {
          my $book = $c->model('DB::Product')->new_result({});
          $form->model->update($book);
          my $time = localtime;
          $book->update({create_date=>$time});
          $c->stash(status_msg => 'Успешно създадохте нова книга');
        }
        catch
        {
          $c->stash(error_msg =>  'Application Error!');
          $c->log->error($_);
        };
     }
     else
     {
       try
       {
           my @tagObjs = $c->model("DB::Tag")->all();
           my @tags;

           my @currObjs = $c->model("DB::Currency")->all();
           my @currencies;

           foreach (@tagObjs)
           {
               push(@tags, [$_->id, $_->name]);
           }
           foreach (@currObjs)
           {
               push(@currencies, [$_->currency_id, $_->currency_name]);
           }
           my $select = $form->get_element({type => 'Select'});
           $select->options(\@tags);
           my $curr_select = $form->get_element({name => 'currency_id'});
           $curr_select->options(\@currencies);
         }
         catch
         {
           $c->stash(error_msg =>  'Application Error!');
           $c->log->error($_);
         };
         }

     $c->stash->{template} = 'admin/create_update.tt2';
   }
   catch
   {
     $c->stash(error_msg =>  'Application Error!');
     $c->log->error($_);
   };
}

sub update :Local :FormConfig('admin/create_update.yml') {
    my ($self, $c) = @_;
    try
    {
      my $id = $c->request->param('id');
      my $page = $c->request->param('page');
      my $prev_name = $c->request->param('prev_name');
      my $price1 = $c->request->param('price1');
      my $price2 = $c->request->param('price2');
      my @prev_tags = $c->request->param('prev_tags');
      warn @prev_tags;
      try
      {
          my $book = $c->model('DB::Product')->find($id);
          $c->log->debug("Value of \$id is: ".$id);
          unless ($book)
          {
            $c->flash->{error_msg} = "Несъществуваща книга -- не може да се обнови";
            $c->response->redirect($c->uri_for($self->action_for('products')));
            $c->detach;
          }

        my $form = $c->stash->{form};
        if ($form->submitted_and_valid)
        {
          my $url = "http://localhost:3000/admin/products?name=$prev_name&page=$page&price1=$price1&price2=$price2";
          foreach my $tag (@prev_tags){
            warn $tag;
            $url ="$url&tags=$tag";
          }
          $form->model->update($book);
          $c->stash(status_msg => 'Успешно обновихте книгата!');
          $c->redirect($url);


          my @tagObjs = $c->model("DB::Tag")->all();
          my @tags;

          my @currObjs = $c->model("DB::Currency")->all();
          my @currencies;

          foreach (@tagObjs)
          {
            push(@tags, [$_->id, $_->name]);
          }

          foreach (@currObjs)
          {
              push(@currencies, [$_->currency_id, $_->currency_name]);
          }

          my $select = $form->get_element({type => 'Select'});
          $select->options(\@tags);
          my $curr_select = $form->get_element({name => 'currency_id'});
          $curr_select->options(\@currencies);
        }
        else
        {
          my @tagObjs = $c->model("DB::Tag")->all();
          my @tags;

          my @currObjs = $c->model("DB::Currency")->all();
          my @currencies;

          foreach (@tagObjs)
          {
            push(@tags, [$_->id, $_->name]);
          }

          foreach (@currObjs)
          {
            push(@currencies, [$_->currency_id, $_->currency_name]);
          }

          my $select = $form->get_element({type => 'Select'});
          $select->options(\@tags);
          my $curr_select = $form->get_element({name => 'currency_id'});
          $curr_select->options(\@currencies);
          $form->model->default_values($book);

          my $time = localtime;
          $book->update({edit_time=>$time});

        }
      }
      catch
      {
        $c->stash(error_msg =>  'Application Error!');
        $c->log->error($_);
      };
      $c->stash->{template} = 'admin/create_update.tt2';
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
}


sub delete :Private{
  my ($self, $c, $id) = @_;
  try
  {
      $dbh=connect();
      assert(defined $dbh,"No connection to the database");

      #$c->stash(relations => $c->model('DB::TagsProduct')->find({ product_id => $id })->delete);
      my $sth = $dbh->prepare("DELETE from tags_products where product_id = ?");
      $sth->execute($id);
      assert($sth->rows>0,"Грешка при изтриването на жанрове на книгата от базата");

        #$c->model('DB::TagsProduct')->find({ product_id => $id })->delete;
        #$c->model('DB::Product')->find({ product_id => $id })->delete;

      # $c->stash(object => $c->model('DB::Product')->find($id));
      # die "Book not found!" if !$c->stash->{object};
      # $c->stash->{object}->delete;
      $sth = $dbh->prepare("DELETE from products where id = ?");
      $sth->execute($id);
      assert($sth->rows>0,"Грешка при изтриването на книгата от базата");


      $c->response->redirect($c->uri_for($self->action_for('products'),
         {mid => $c->set_status_msg("Книгата с ID:$id беше успешно изтрита")}));
   }
   catch
   {
     $c->stash(error_msg =>  'Application Error!');
     $c->log->error($_);
   };
}


sub products :Local{
  my ($self, $c) = @_;
  try
  {
    $dbh=connect();
    assert(defined $dbh,"No connection to the database");
    my $page = $c->req->param('page');
    my $name = $c->request->param('name');
    my $price1 = $c->request->param('price1');
    my $price2 = $c->request->param('price2');
    my @tags = $c->request->param('tags');
    my $query_string;
    my @bind_params;
    my %filter;
    if(defined $name && $name ne "")
    {
      user_assert(!looks_like_number($name),"A493","Невалидни данни в полето за търсене по име");
      $filter{'name'} = { ilike => '%'.$name.'%' };
    }

    if(@tags != 0)
    {
      warn @tags;
      user_assert(ref(@tags) ne "ARRAY","A494","Невалидни данни в полето за търсене по жанр");
      $filter{tag_id} = { in => [@tags] };
      $query_string = "$query_string and t.id = ANY(?)";
      push @bind_params, [@tags];
    }

    if(defined $price1 && $price1 ne "")
    {
      user_assert(looks_like_number($price1),"A495","Невалидни данни в полето за търсене по Цена[ОТ]");
      $query_string = "$query_string and price >= ?";
      $filter{price}{'>='} = $price1;
      push @bind_params, $price1;
    }

    if(defined $price2 && $price2 ne "")
    {
      user_assert(looks_like_number($price2),"A496","Невалидни данни в полето за търсене по Цена[ДО]");
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
    warn $query_string;
    warn @bind_params;
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
                              array_agg(t.name) as tagerinos,
                              to_char(p.create_date, 'dd-Mon-YYYY HH24:MM:SS') as date_formatted
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
    $c->stash(books => [@rows],page => $page);
    # $c->stash(books => [$c->model('DB::Product')->search({%filter}, {
    #        page => $page,
    #        rows => 10,
    #        join      => {'tags_products'=>'tag'},
    #        order_by => {-asc => 'id'},
    #        group_by => 'id',
    #   })]);
    $sth = $dbh->prepare("SELECT * from tags");
    $sth->execute();
    assert($sth->rows>0,"Грешка при взимането на жанровете от базата");
    @rows = ();
    while (my $row = $sth->fetchrow_hashref ) {
      push @rows, $row;
    }
    $c->stash(select_tags => [@rows]);
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

sub orders :Local{
  my ($self, $c) = @_;
  try
  {
    $dbh=connect();
    assert(defined $dbh,"No connection to the database");
    my $page = $c->req->param('page');
    my $id = $c->request->param('id');
    my $price1 = $c->request->param('price1');
    my $price2 = $c->request->param('price2');
    my @order_status = $c->request->param('order_status');
    my $query_string;
    my @bind_params;
    my %filter;

    if(defined $id && $id ne '')
    {
      $filter{order_id} = { '=' , $id };
      user_assert(MyAsserts::is_int($id),"A505","Невалидни данни в полето за търсене по ID");
      $query_string = "$query_string and me.id = ?";
      push @bind_params, $id;
    }


    if(defined $price1 && $price1 ne "")
    {
      user_assert(looks_like_number($price1),"A506","Невалидни данни в полето за търсене по Цена[ОТ]");
      $filter{price}{'>='} = $price1;
      $query_string = "$query_string and me.price >= ?";
      push @bind_params, $price1;
    }

    if(defined $price2 && $price2 ne "")
    {
      user_assert(looks_like_number($price2),"A507","Невалидни данни в полето за търсене по Цена[ДО]");
      $filter{price}{'<='} = $price2;
      $query_string = "$query_string and me.price <= ?";
      push @bind_params, $price2;
    }



    if(@order_status != 0)
      {
        $filter{order_status} = { in => [@order_status] };
        $query_string = "$query_string and order_status = ANY(?)";
        push @bind_params, [@order_status];
      }


    if($c->req->param('submit') eq 'Submit')
    {
      $page = 1;
      $c->stash( price1 => $price1, price2 => $price2, order_status => [@order_status], order_id => $id);
    }
    else
    {
      $c->stash( price1 => $price1, price2 => $price2, order_status => [@order_status], order_id => $id);
    }



    if(!looks_like_number($page))
    {
      $page = 1;
    }
    my $offset = ($page-1)*10;

    my $sth = $dbh->prepare("SELECT o.id,
                            o.user_id,
                            o.address_id,
                            to_char(o.created, 'yyyy-mm-dd hh24:mi:ss') as created,
                            o.order_status,
                            o.price,
                            o.currency,
                            o.phone_number,
                            o.buyer_name,
                            o.payment_type,
                            u.name as name,
                            u.email as email,
                            to_char(pa.payment_timestamp, 'yyyy-mm-dd hh24:mi:ss') as payment_date,
                            array_agg(' [ ' || p.name || ': ' || oi.quantity || 'бр' || ' Цена: ' || oi.product_price*oi.quantity || ' ' || o.currency  || ' ] ') as producterinos
                            FROM orders o
                            left join payments pa on pa.order_id = o.id
                            join order_items oi on oi.order_id = o.id
                            join products p on oi.product_id = p.id
                            join users u on o.user_id = u.id
                            where true $query_string
                            group by o.id,u.name,u.email,payment_date
                            order by o.order_status,o.id desc
                            LIMIT 10 OFFSET ?");

    $sth->execute(@bind_params,$offset);
    my @rows;
    while ( my $row = $sth->fetchrow_hashref )
    {
        push @rows, $row;
    }
    $c->stash(orders => [@rows]);

    # $c->stash(orders => [$c->model('DB::Order')->search({%filter}, {
    #        page => $page,
    #        rows => 10,
    #        join      => {'order_items'=>'product','user'},
    #        order_by => {-asc => 'me.order_status'},
    #        group_by => 'me.id',
    #   })]);
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

sub employees :Local{
  my ($self, $c) = @_;
  try
  {
    $dbh = connect();
    assert(defined $dbh,"No connection to the database");

    my $page = $c->req->param('page');
    if(!looks_like_number($page))
    {
    $page = 1;
    }
    my $offset = ($page-1)*10;
    my $sth = $dbh->prepare("SELECT e.id,
                            e.name,
                            e.username,
                            e.email,
                            array_agg(' [ ' || r.name || ' ] ') as roles
                            FROM employees e
                            left join employee_roles er
                            on er.employee_id = e.id
                            left join roles r
                            on r.id = er.role_id
                            group by
                            e.id,
                            e.name,
                            e.username,
                            e.email
                            LIMIT 10
                            OFFSET ?");

    $sth->execute($offset);
    my @rows;
    while ( my $row = $sth->fetchrow_hashref )
    {
        push @rows, $row;
    }

    $c->stash(employees => [@rows],page => $page);
    #
    # $c->stash(employees => [$c->model('DB::Employee')->search(undef, {
    #        page => $page,
    #        rows => 10,
    #        join      => {'employee_roles'=>'role'},
    #        order_by => {-asc => 'id'},
    #        group_by => 'id',
    #   })]);
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



sub users :Local{
  my ($self, $c) = @_;
  try
  {
    $dbh = connect();
    assert(defined $dbh,"No connection to the database");
    my $page = $c->req->param('page');

    if(!looks_like_number($page))
    {
    $page = 1;
    }
    my $offset = ($page-1)*10;
    my $sth = $dbh->prepare("SELECT u.id,
                            u.name,
                            u.username,
                            u.email,
                            u.verified,
                            to_char(u.create_date, 'yyyy-mm-dd hh24:mi:ss') as create_date,
                            array_agg(' [ ' || a.address || ' ] ') as addresses
                            FROM users u
                            left join addresses a
                            on a.user_id = u.id
                            group by
                            u.id,
                            u.name,
                            u.username,
                            u.email,
                            u.verified
                            LIMIT 10
                            OFFSET ?");

    $sth->execute($offset);
    my @rows;
    while ( my $row = $sth->fetchrow_hashref )
    {
        push @rows, $row;
    }

    $c->stash(users => [@rows],page => $page);
    # $c->stash(users => [$c->model('DB::User')->search(undef, {
    #        page => $page,
    #        rows => 10,
    #        join      => 'addresses',
    #        order_by => {-asc => 'id'},
    #        group_by => 'id',
    #   })]);
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


sub create_user :Local :FormConfig('admin/create_update_users.yml') {
   my ($self, $c) = @_;
   try
   {

     my $form = $c->stash->{form};
     try
     {
       if ($form->submitted_and_valid)
       {
           my $user = $c->model('DB::User')->new_result({});
           $form->model->update($user);
           $c->stash(status_msg => 'Успешно създадохте нов потребител!');
       }
     }
     catch
     {
       $c->stash(error_msg =>  'Application Error!');
       $c->log->error($_);
     };
     $c->stash->{template} = 'admin/create_update.tt2';
   }
   catch
   {
     $c->stash(error_msg =>  'Application Error!');
     $c->log->error($_);
   };
}

sub update_user :Local :FormConfig('admin/create_update_users.yml') {
    my ($self, $c, $id) = @_;
    try
    {
      my $user = $c->model('DB::User')->find($id);
      unless ($user)
      {
          $c->stash(error_msg => "Несъществуващ потребител -- не може да се обнови");
      }

      my $form = $c->stash->{form};

      if ($form->submitted_and_valid)
      {
          $form->model->update($user);
          $c->stash(status_msg => 'Потребителят беше успешно обновен');
      }
      else
      {
        $form->model->default_values($user)
      }
      $c->stash->{template} = 'admin/create_update.tt2';
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
}

sub create_order :Local :FormConfig('admin/create_update_orders.yml') {
   my ($self, $c) = @_;
   try
   {
     my $form = $c->stash->{form};

     if ($form->submitted_and_valid)
     {
        try
         {
           my $order = $c->model('DB::Order')->new_result({});
           $form->model->update($order);
           $c->stash(status_msg => 'Успешно създадохте нова поръчка');
         }
         catch
         {
           $c->stash(error_msg =>  'Application Error!');
           $c->log->error($_);
         };
     }

     $c->stash->{template} = 'admin/create_update.tt2';
   }
   catch
   {
     $c->stash(error_msg =>  'Application Error!');
     $c->log->error($_);
   };

}


sub update_order :Local :FormConfig('admin/create_update_orders.yml') {
    my ($self, $c, $id) = @_;
    try
    {
      my $order = $c->model('DB::Order')->find($id);

      unless ($order)
      {
          $c->stash(error_msg => "Несъществуваща поръчка -- не може да се обнови");
      }

      my $form = $c->stash->{form};

      if ($form->submitted_and_valid)
      {
          $form->model->update($order);
          $c->stash(status_msg => 'Поръчката беше успешно обновена');
      }
      else
      {
        $form->model->default_values($order)
      }
      $c->stash->{template} = 'admin/create_update.tt2';
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
}


sub create_employee :Local :FormConfig('admin/create_update_employees.yml') {
   my ($self, $c) = @_;
   try
   {
     my $form = $c->stash->{form};

     if ($form->submitted_and_valid)
     {
       try
       {
         my $employee = $c->model('DB::Employee')->new_result({});
         $form->model->update($employee);
         $c->stash(status_msg => 'Успешно създадохте нов служител');
       }
       catch
       {
         $c->stash(error_msg =>  'Application Error!');
         $c->log->error($_);
       };
     }
     else
     {
       try
       {
         my @roleObjs = $c->model("DB::Role")->all();
         my @roles;


         foreach (@roleObjs)
         {
             push(@roles, [$_->id, $_->name]);
         }


         my $select = $form->get_element({type => 'Select'});
         $select->options(\@roles);
       }
       catch
       {
         $c->stash(error_msg =>  'Application Error!');
         $c->log->error($_);
       };
     }

     $c->stash->{template} = 'admin/create_update.tt2';
   }
   catch
   {
     $c->stash(error_msg =>  'Application Error!');
     $c->log->error($_);
   };
}

sub update_employee :Local :FormConfig('admin/create_update_employees.yml') {
    my ($self, $c, $id) = @_;
    try
    {
      my $employee = $c->model('DB::Employee')->find($id);
      unless ($employee)
      {
          $c->flash->{error_msg} = "Несъществуващ служител -- не може да се обнови";
          $c->response->redirect($c->uri_for($self->action_for('employees')));
          $c->detach;
      }

      my $form = $c->stash->{form};

      if ($form->submitted_and_valid)
      {
          $form->model->update($employee);
          $c->stash(status_msg => 'Служителят беше успешно обновен');
      }
      else
      {
          my @roleObjs = $c->model("DB::Role")->all();
          my @roles;
          foreach (@roleObjs)
          {
              push(@roles, [$_->id, $_->name]);
          }
          my $select = $form->get_element({type => 'Select'});
          $select->options(\@roles);
          $form->model->default_values($employee)
      }
      $c->stash->{template} = 'admin/create_update.tt2';
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };

}

sub order_stats :Local{
  my ($self, $c) = @_;
  try
  {

    my $sort_by = $c->request->param('sort_by') || 'me.id';

    my $order_status = $c->request->param('order_status');

    my $page = $c->req->param('page');
    my %filter;

    if($c->req->param('submit') eq 'Submit')
    {
      $page = 1;
      $c->stash(sort_by => $sort_by, order_status=>$order_status);
    }
    else
    {
      $c->stash(sort_by => $sort_by, order_status=>$order_status);
    }

    if(defined $order_status)
    {
      $filter{order_status} = { '=', $order_status };
    }

    if(!looks_like_number($page))
    {
    $page = 1;
    }
    try
    {
      if($sort_by eq 'me.user_id')
      {
        $c->stash(orders => [$c->model('DB::Order')->search({%filter},{
              columns  => [
                  { id  => \"COUNT(id)" },
                  { user_id      => \"user_id" },
                  { price => \"SUM(price)"},
                  { currency => \'MAX(currency)'}
                  ],
               page => $page,
               rows => 10,
               join => {'order_items'=>'product','user'},
               group_by => 'user_id'
          })]);
      }
      else
      {
        $c->stash(orders => [$c->model('DB::Order')->search({%filter},{
              columns  => [
                  { id  => \"COUNT(me.id)" },
                  { price => \"SUM(me.price)"},
                  { currency => \'MAX(currency)'},
                  { user_id => \'EXTRACT(MONTH from created)'},
                  ],
               page => $page,
               rows => 10,
               join => {'order_items'=>'product','user'},
               group_by => \'EXTRACT(MONTH from created)'
          })]);
      }
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
    $c->stash->{template} = 'admin/order_stats.tt2';
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}



sub user_stats :Local{
  my ($self, $c) = @_;
  try
  {
    my $sort_by = $c->request->param('sort_by') || 'me.id';

    my $verified = $c->request->param('verified');

    my $page = $c->req->param('page');
    my %filter;
    if($c->req->param('submit') eq 'Submit')
    {
      $page = 1;
      $c->stash(sort_by => $sort_by, verified=>$verified);
    }
    else
    {
      $c->stash(sort_by => $sort_by, verified=>$verified);
    }

    if($verified ne undef)
    {
      $filter{verified} = { '=', $verified };
    }

    if(!looks_like_number($page))
    {
      $page = 1;
    }
    try
    {
      if($sort_by eq 'me.create_date')
      {
        $c->stash(users => [$c->model('DB::User')->search({%filter}, {
              columns  => [
                  { id  => \"COUNT(me.id)" },
                  { email => \'EXTRACT(MONTH from create_date)'},
                  ],
               page => $page,
               rows => 10,
               join      => 'addresses',
               group_by => \'EXTRACT(MONTH from create_date)'
          })]);
      }
      else
      {
        $c->stash(users => [$c->model('DB::User')->search({%filter}, {
              columns  => [
                  { id  => \"COUNT(me.id)" },
                  { verified  => \"verified" },
                  ],
               page => $page,
               rows => 10,
               join      => 'addresses',
               group_by => 'verified',
          })]);
      }
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
    $c->stash->{template} = 'admin/user_stats.tt2';
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}

=encoding utf8

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;


1;
