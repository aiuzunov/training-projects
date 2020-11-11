package MyShop::Controller::Admin;
use Moose;
use namespace::autoclean;
use utf8;
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

    if ( $c->request->path =~ /login/ ) {
        return 1;
      }

      if (!$c->user_in_realm('employees')) {
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
  if ($username && $password) {
    if ( $c->authenticate( { username => $username,
                       password => $password }, 'employees') ) {
          $c->response->redirect($c->uri_for(
              $c->controller('Admin')->action_for('products')));
          return;
      } else {
          $c->stash(error_msg => "Bad username or password.");
      }
  } else {
      $c->stash(error_msg => "Empty username or password.")
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

   if ($form->submitted_and_valid) {
       my $book = $c->model('DB::Product')->new_result({});
       $form->model->update($book);
       $c->flash->{status_msg} = 'Book created';
       $c->response->redirect($c->uri_for($self->action_for('products')));
       $c->detach;
   } else {
       my @tagObjs = $c->model("DB::Tag")->all();
       my @tags;


       foreach (@tagObjs) {
           push(@tags, [$_->id, $_->name]);
       }


       my $select = $form->get_element({type => 'Select'});
       $select->options(\@tags);
   }

   $c->stash->{template} = 'admin/create_update.tt2';
}

sub update :Local :FormConfig('admin/create_update.yml') {
    my ($self, $c, $id) = @_;
    my $book = $c->model('DB::Product')->find($id);
    $c->log->debug("Value of \$id is: ".$id);
    unless ($book) {
        $c->flash->{error_msg} = "Invalid book -- Cannot edit";
        $c->response->redirect($c->uri_for($self->action_for('products')));
        $c->detach;
    }

    my $form = $c->stash->{form};

    if ($form->submitted_and_valid) {
        $form->model->update($book);
        $c->flash->{status_msg} = 'Book edited';
        $c->response->redirect($c->uri_for($self->action_for('products')));
        $c->detach;
    } else {
        my @tagObjs = $c->model("DB::Tag")->all();
        my @tags;
        foreach (@tagObjs) {
            push(@tags, [$_->id, $_->name]);
        }
        my $select = $form->get_element({type => 'Select'});
        $select->options(\@tags);
        $form->model->default_values($book)
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
  if(looks_like_number($page)){
  $c->stash(books => [$c->model('DB::Product')->search(undef, {
         page => $page,
         rows => 10,
         join      => {'tags_products'=>'tag'},
         order_by => {-asc => 'id'},
         group_by => 'id',


    })]);


}else{
  $page = 1;
  $c->stash(books => [$c->model('DB::Product')->search(undef, {
         page => $page,
         rows => 10,
         join      => {'tags_products'=>'tag'},
         order_by => {-asc => 'id'},
         group_by => 'id',


    })]);
}
$c->stash(template => 'admin/products.tt2',page => $page);

}

sub employees :Local{
  my ($self, $c) = @_;
  my $page = $c->req->param('page');
  if(looks_like_number($page)){
  $c->stash(employees => [$c->model('DB::Employee')->search(undef, {
         page => $page,
         rows => 10,
         join      => {'employee_roles'=>'role'},
         order_by => {-asc => 'id'},
         group_by => 'id',


    })]);


}else{
  $page = 1;
  $c->stash(employees => [$c->model('DB::Employee')->search(undef, {
         page => $page,
         rows => 10,
         join      => {'employee_roles'=>'role'},
         order_by => {-asc => 'id'},
         group_by => 'id',


    })]);
}
$c->stash(template => 'admin/employees.tt2',page => $page);

}



sub users :Local{
  my ($self, $c) = @_;
  my $page = $c->req->param('page');
  if(looks_like_number($page)){
  $c->stash(users => [$c->model('DB::User')->search(undef, {
         page => $page,
         rows => 10,
         join      => 'addresses',
         order_by => {-asc => 'id'},
         group_by => 'id',
    })]);


}else{
  $page = 1;
  $c->stash(users => [$c->model('DB::User')->search(undef, {
         page => $page,
         rows => 10,
         join      => 'addresses',
         order_by => {-asc => 'id'},
         group_by => 'id',


    })]);
}
$c->stash(template => 'admin/users.tt2',page => $page);

}


sub create_user :Local :FormConfig('admin/create_update_users.yml') {
   my ($self, $c) = @_;

   my $form = $c->stash->{form};

   if ($form->submitted_and_valid) {
       my $user = $c->model('DB::User')->new_result({});
       $form->model->update($user);
       $c->flash->{status_msg} = 'User created';
       $c->response->redirect($c->uri_for($self->action_for('users')));
       $c->detach;
   }

   $c->stash->{template} = 'admin/create_update.tt2';
}

sub update_user :Local :FormConfig('admin/create_update_users.yml') {
    my ($self, $c, $id) = @_;
    my $user = $c->model('DB::User')->find($id);
    $c->log->debug("Value of \$id is: ".$id);
    $c->log->debug($user->name);
    unless ($user) {
        $c->flash->{error_msg} = "Invalid User -- Cannot edit";
        $c->response->redirect($c->uri_for($self->action_for('users')));
        $c->detach;
    }

    my $form = $c->stash->{form};

    if ($form->submitted_and_valid) {
        $form->model->update($user);
        $c->flash->{status_msg} = 'User edited';
        $c->response->redirect($c->uri_for($self->action_for('users')));
        $c->detach;
    }else{
      $form->model->default_values($user)
    }

    $c->stash->{template} = 'admin/create_update.tt2';
}

sub create_employee :Local :FormConfig('admin/create_update_employees.yml') {
   my ($self, $c) = @_;

   my $form = $c->stash->{form};

   if ($form->submitted_and_valid) {
       my $employee = $c->model('DB::Employee')->new_result({});
       $form->model->update($employee);
       $c->flash->{status_msg} = 'Employee created';
       $c->response->redirect($c->uri_for($self->action_for('employees')));
       $c->detach;
   } else {
       my @roleObjs = $c->model("DB::Role")->all();
       my @roles;


       foreach (@roleObjs) {
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
    unless ($employee) {
        $c->flash->{error_msg} = "Invalid employee -- Cannot edit";
        $c->response->redirect($c->uri_for($self->action_for('employees')));
        $c->detach;
    }

    my $form = $c->stash->{form};

    if ($form->submitted_and_valid) {
        $form->model->update($employee);
        $c->flash->{status_msg} = 'Employee edited';
        $c->response->redirect($c->uri_for($self->action_for('employees')));
        $c->detach;
    } else {
        my @roleObjs = $c->model("DB::Role")->all();
        my @roles;
        foreach (@roleObjs) {
            push(@roles, [$_->id, $_->name]);
        }
        my $select = $form->get_element({type => 'Select'});
        $select->options(\@roles);
        $form->model->default_values($employee)
    }

    $c->stash->{template} = 'admin/create_update.tt2';
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
