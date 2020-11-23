package MyShop::Controller::Admin;
use Moose;
use namespace::autoclean;
use utf8;
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use Try::Tiny;
use URI::Escape;
use MyShop::MyAsserts;
BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

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

sub test :Local{
  my ($self, $c) = @_;
  my $test = 0;
  MyAsserts::user_assert('whatever',1);
}

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


sub delete :Local{
  my ($self, $c, $id) = @_;
  try
  {
      $c->stash(object => $c->model('DB::Product')->find($id));
      $c->stash(relations => $c->model('DB::TagsProduct')->find({ product_id => $id })->delete);

        #$c->model('DB::TagsProduct')->find({ product_id => $id })->delete;
        #$c->model('DB::Product')->find({ product_id => $id })->delete;

      die "Book not found!" if !$c->stash->{object};
      $c->stash->{object}->delete;

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
    my $page = $c->req->param('page');
    my $name = $c->request->param('name');
    my $price1 = $c->request->param('price1');
    my $price2 = $c->request->param('price2');
    my @tags = $c->request->param('tags');
    my %filter;

    if(defined $name && $name ne "")
    {
      $filter{name} = { ilike => '%'.$name.'%' };
    }

    if(@tags != 0)
    {
      $filter{tag_id} = { in => [@tags] };
    }


    if(defined $price1 && $price1 ne ""){
      $filter{price}{'>='} = $price1;

    }

    if(defined $price2 && $price2 ne ""){
      $filter{price}{'<='} = $price2;
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
    try
    {
      $c->stash(books => [$c->model('DB::Product')->search({%filter}, {
             page => $page,
             rows => 10,
             join      => {'tags_products'=>'tag'},
             order_by => {-asc => 'id'},
             group_by => 'id',
        })]);
      $c->stash(select_tags => [$c->model('DB::Tag')->all()]);
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
    $c->stash(template => 'admin/products.tt2',page => $page);
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}

sub orders :Local{
  my ($self, $c) = @_;
  try
  {
    my $page = $c->req->param('page');
    my $id = $c->request->param('id');
    my $price1 = $c->request->param('price1');
    my $price2 = $c->request->param('price2');
    my @order_status = $c->request->param('order_status');
    my %filter;



    if(defined $id && $id ne '')
    {
      $filter{order_id} = { '=' , $id };
    }


    if(defined $price1 && $price1 ne ""){
      $filter{price}{'>='} = $price1;

    }

    if(defined $price2 && $price2 ne ""){
      $filter{price}{'<='} = $price2;
    }



    if(@order_status != 0)
      {
        $filter{order_status} = { in => [@order_status] };
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

    try
    {
      $c->stash(orders => [$c->model('DB::Order')->search({%filter}, {
             page => $page,
             rows => 10,
             join      => {'order_items'=>'product','user'},
             order_by => {-asc => 'me.order_status'},
             group_by => 'me.id',
        })]);
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };

    $c->stash(template => 'admin/orders.tt2',page => $page);
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
  }

sub employees :Local{
  my ($self, $c) = @_;
  try
  {
    my $page = $c->req->param('page');
    if(!looks_like_number($page))
    {
    $page = 1;
    }
    try
    {
    $c->stash(employees => [$c->model('DB::Employee')->search(undef, {
           page => $page,
           rows => 10,
           join      => {'employee_roles'=>'role'},
           order_by => {-asc => 'id'},
           group_by => 'id',
      })]);
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
    $c->stash(template => 'admin/employees.tt2',page => $page);
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}



sub users :Local{
  my ($self, $c) = @_;
  try
  {
    my $page = $c->req->param('page');

    if(!looks_like_number($page))
    {
    $page = 1;
    }
    try
    {
      $c->stash(users => [$c->model('DB::User')->search(undef, {
             page => $page,
             rows => 10,
             join      => 'addresses',
             order_by => {-asc => 'id'},
             group_by => 'id',
        })]);
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
    $c->stash(template => 'admin/users.tt2',page => $page);
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
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
