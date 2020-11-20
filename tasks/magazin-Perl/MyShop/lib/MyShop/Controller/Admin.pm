package MyShop::Controller::Admin;
use Moose;
use namespace::autoclean;
use utf8;
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

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

    $c->response->body('Matched MyShop::Controller::Admin in Admin.');
}
sub access_denied : Private {
    my ($self, $c) = @_;

    $c->stash->{error_msg} = 'Unauthorized!';

    $c->forward('denied');
}

sub auto :Private {
    my ($self, $c) = @_;

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

sub denied :Local{
  my ($self, $c) = @_;

  $c->stash(template => 'admin/denied.tt2');
}

sub login :Local {
  my ($self, $c) = @_;
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

sub logout :Local {
    my ($self, $c) = @_;
    # warn $c->user_in_realm('employees')
    # warn $c->user()->name;
    # warn $c->employee()
    $c->logout();

    # $c->response->redirect($c->uri_for('/'));
}


sub create :Local :FormConfig('admin/create_update.yml') {
   my ($self, $c) = @_;

   my $form = $c->stash->{form};

   if ($form->submitted_and_valid)
   {
      my $book = $c->model('DB::Product')->new_result({});
      $form->model->update($book);
      my $time = localtime;
      $book->update({create_date=>$time});
      $c->stash(status_msg => 'Успешно създадохте нова книга');
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
   }

   $c->stash->{template} = 'admin/create_update.tt2';
}

sub update :Local :FormConfig('admin/create_update.yml') {
    my ($self, $c, $id) = @_;
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
      $c->stash(status_msg => 'Успешно обновихте книгата!');
      $form->model->update($book);


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

    $c->stash->{template} = 'admin/create_update.tt2';
}


sub delete :Local{
  my ($self, $c, $id) = @_;
  $c->stash(object => $c->model('DB::Product')->find($id));
  $c->stash(relations => $c->model('DB::TagsProduct')->find({ product_id => $id })->delete);

    #$c->model('DB::TagsProduct')->find({ product_id => $id })->delete;
    #$c->model('DB::Product')->find({ product_id => $id })->delete;

  die "Book not found!" if !$c->stash->{object};
  $c->stash->{object}->delete;

  $c->response->redirect($c->uri_for($self->action_for('products'),
     {mid => $c->set_status_msg("Книгата с ID:$id беше успешно изтрита")}));

}


sub products :Local{
  my ($self, $c) = @_;
  my $page = $c->req->param('page');
  my $name = $c->request->param('name');
  my $price1 = $c->request->param('price1');
  my $price2 = $c->request->param('price2');
  my @tags = $c->request->param('tags');
  my %filter;

  if(defined $name && $name ne "")
  {
    $filter{name} = { like => '%'.$name.'%' };
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
    $c->stash(search_name => $name, price => $price1, price2 => $price2, tags => [@tags]);
  }
  else
  {
    $c->stash(search_name => $name, price1 => $price1, price2 => $price2, tags => [@tags]);
  }

  if(!looks_like_number($page))
  {
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

  $c->stash(template => 'admin/products.tt2',page => $page);
}

sub orders :Local{
  my ($self, $c) = @_;
  my $page = $c->req->param('page');
  my $id = $c->request->param('id');
  my $price1 = $c->request->param('price1');
  my $price2 = $c->request->param('price2');
  my $order_status = $c->request->param('order_status') || !defined;
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



  if(defined $order_status && $order_status ne "")
  {
    $filter{order_status} = { '=',  $order_status };
  }



  if($c->req->param('submit') eq 'Submit')
  {
    $page = 1;
    $c->stash( price1 => $price1, price2 => $price2, order_status => $order_status, order_id => $id);
  }
  else
  {
    $c->stash( price1 => $price1, price2 => $price2, order_status => $order_status, order_id => $id);
  }



  if(!looks_like_number($page))
  {
    $page = 1;
  }


  $c->stash(orders => [$c->model('DB::Order')->search({%filter}, {
         page => $page,
         rows => 10,
         join      => {'order_items'=>'product','user'},
         order_by => $order_status ne "" ? {-asc => 'order_status'} : {-asc => 'me.id'},
         group_by => 'me.id',
    })]);



  $c->stash(template => 'admin/orders.tt2',page => $page);
  }

sub employees :Local{
  my ($self, $c) = @_;
  my $page = $c->req->param('page');

  if(!looks_like_number($page))
  {
  $page = 1;
  }

  $c->stash(employees => [$c->model('DB::Employee')->search(undef, {
         page => $page,
         rows => 10,
         join      => {'employee_roles'=>'role'},
         order_by => {-asc => 'id'},
         group_by => 'id',
    })]);

  $c->stash(template => 'admin/employees.tt2',page => $page);
}



sub users :Local{
  my ($self, $c) = @_;
  my $page = $c->req->param('page');

  if(!looks_like_number($page))
  {
  $page = 1;
  }

  $c->stash(users => [$c->model('DB::User')->search(undef, {
         page => $page,
         rows => 10,
         join      => 'addresses',
         order_by => {-asc => 'id'},
         group_by => 'id',
    })]);

  $c->stash(template => 'admin/users.tt2',page => $page);
}


sub create_user :Local :FormConfig('admin/create_update_users.yml') {
   my ($self, $c) = @_;

   my $form = $c->stash->{form};

   if ($form->submitted_and_valid)
   {
       my $user = $c->model('DB::User')->new_result({});
       $form->model->update($user);
       $c->stash(status_msg => 'Успешно създадохте нов потребител!');
   }

   $c->stash->{template} = 'admin/create_update.tt2';
}

sub update_user :Local :FormConfig('admin/create_update_users.yml') {
    my ($self, $c, $id) = @_;
    my $user = $c->model('DB::User')->find($id);
    $c->log->debug("Value of \$id is: ".$id);
    $c->log->debug($user->name);
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

sub create_order :Local :FormConfig('admin/create_update_orders.yml') {
   my ($self, $c) = @_;

   my $form = $c->stash->{form};

   if ($form->submitted_and_valid)
   {
       my $order = $c->model('DB::Order')->new_result({});
       $form->model->update($order);
       $c->stash(status_msg => 'Успешно създадохте нова поръчка');
   }

   $c->stash->{template} = 'admin/create_update.tt2';
}


sub update_order :Local :FormConfig('admin/create_update_orders.yml') {
    my ($self, $c, $id) = @_;
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


sub create_employee :Local :FormConfig('admin/create_update_employees.yml') {
   my ($self, $c) = @_;

   my $form = $c->stash->{form};

   if ($form->submitted_and_valid)
   {
       my $employee = $c->model('DB::Employee')->new_result({});
       $form->model->update($employee);
       $c->stash(status_msg => 'Успешно създадохте нов служител');
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
   }

   $c->stash->{template} = 'admin/create_update.tt2';
}

sub update_employee :Local :FormConfig('admin/create_update_employees.yml') {
    my ($self, $c, $id) = @_;
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

sub order_stats :Local{
  my ($self, $c) = @_;

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
  $c->stash->{template} = 'admin/order_stats.tt2';
}



sub user_stats :Local{
  my ($self, $c) = @_;

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



  $c->stash->{template} = 'admin/user_stats.tt2';
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
