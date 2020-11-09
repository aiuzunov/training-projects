Script started on 2020-11-09 18:07:59+02:00 [TERM="xterm-256color" TTY="/dev/pts/1" COLUMNS="80" LINES="23"]
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# script/myshop_server.pl -rcreate.pl controller Register[17Pserver.pl -r[Kscript/myshop_server.pl -r
[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
syntax error at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 13, near "package MyShop::Controller::Checkout"
BEGIN not safe after errors--compilation aborted at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 14.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /index               | MyShop::Controller::Root             | index        |
| /end                 | MyShop::Controller::Root             | end          |
| /default             | MyShop::Controller::Root             | default      |
| /auto                | MyShop::Controller::Root             | auto         |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/details       | MyShop::Controller::Books            | details      |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/index      | MyShop::Controller::Register         | index        |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
^[[A^C
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# script/myshop_server.pl -rcreate.pl controller Register[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[1P Register[1P Register[1P Register[1P Register[1P Register[1P Register[1P Register[1P Register[1P Register[1P Registerm Registero Registerd Registere Registerl Register[C[C[C[C[C[C[C[C[C[K[K[K[K[K[K[K[KPayPal
 exists "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Model"
 exists "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../t"
created "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Model/PayPal.pm"
created "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../t/model_PayPal.t"
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# ~~script/myshop_create.pl model PayPal[10Pserver.pl -r
[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /default             | MyShop::Controller::Root             | default      |
| /end                 | MyShop::Controller::Root             | end          |
| /index               | MyShop::Controller::Root             | index        |
| /auto                | MyShop::Controller::Root             | auto         |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
[info] *** Request 1 (0.038/s) [141789] [Mon Nov  9 18:11:52 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.015873s (63.000/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001531s |
| /checkout/index                                            | 0.001921s |
| /end                                                       | 0.000214s |
'------------------------------------------------------------+-----------'


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /index               | MyShop::Controller::Root             | index        |
| /auto                | MyShop::Controller::Root             | auto         |
| /default             | MyShop::Controller::Root             | default      |
| /end                 | MyShop::Controller::Root             | end          |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/index         | MyShop::Controller::Books            | index        |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
[info] *** Request 1 (0.019/s) [142644] [Mon Nov  9 18:12:19 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.016237s (61.588/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001643s |
| /checkout/index                                            | 0.002027s |
| /end                                                       | 0.000222s |
'------------------------------------------------------------+-----------'

[info] *** Request 2 (0.037/s) [142644] [Mon Nov  9 18:12:20 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011807s (84.696/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000947s |
| /checkout/index                                            | 0.001808s |
| /end                                                       | 0.000171s |
'------------------------------------------------------------+-----------'

[info] *** Request 3 (0.055/s) [142644] [Mon Nov  9 18:12:21 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.01499s (66.711/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001478s |
| /checkout/index                                            | 0.002977s |
| /end                                                       | 0.000182s |
'------------------------------------------------------------+-----------'

[info] *** Request 4 (0.073/s) [142644] [Mon Nov  9 18:12:21 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.014297s (69.945/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001175s |
| /checkout/index                                            | 0.002478s |
| /end                                                       | 0.000144s |
'------------------------------------------------------------+-----------'

[info] *** Request 5 (0.091/s) [142644] [Mon Nov  9 18:12:21 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.013356s (74.873/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001707s |
| /checkout/index                                            | 0.002475s |
| /end                                                       | 0.000166s |
'------------------------------------------------------------+-----------'

[info] *** Request 6 (0.109/s) [142644] [Mon Nov  9 18:12:21 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011881s (84.168/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000948s |
| /checkout/index                                            | 0.001846s |
| /end                                                       | 0.000148s |
'------------------------------------------------------------+-----------'

[info] *** Request 7 (0.125/s) [142644] [Mon Nov  9 18:12:22 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011585s (86.319/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000929s |
| /checkout/index                                            | 0.001766s |
| /end                                                       | 0.000162s |
'------------------------------------------------------------+-----------'

[info] *** Request 8 (0.143/s) [142644] [Mon Nov  9 18:12:22 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.01438s (69.541/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001305s |
| /checkout/index                                            | 0.002956s |
| /end                                                       | 0.000257s |
'------------------------------------------------------------+-----------'

[info] *** Request 9 (0.161/s) [142644] [Mon Nov  9 18:12:22 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011541s (86.648/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000927s |
| /checkout/index                                            | 0.001763s |
| /end                                                       | 0.000185s |
'------------------------------------------------------------+-----------'

[info] *** Request 10 (0.179/s) [142644] [Mon Nov  9 18:12:22 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.010869s (92.005/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000907s |
| /checkout/index                                            | 0.001668s |
| /end                                                       | 0.000114s |
'------------------------------------------------------------+-----------'

[info] *** Request 11 (0.193/s) [142644] [Mon Nov  9 18:12:23 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011612s (86.118/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001070s |
| /checkout/index                                            | 0.001858s |
| /end                                                       | 0.000160s |
'------------------------------------------------------------+-----------'

[info] *** Request 12 (0.207/s) [142644] [Mon Nov  9 18:12:24 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.015584s (64.168/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001468s |
| /checkout/index                                            | 0.003441s |
| /end                                                       | 0.000262s |
'------------------------------------------------------------+-----------'

[info] *** Request 13 (0.220/s) [142644] [Mon Nov  9 18:12:25 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.015006s (66.640/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001505s |
| /checkout/index                                            | 0.003544s |
| /end                                                       | 0.000273s |
'------------------------------------------------------------+-----------'

[info] *** Request 14 (0.237/s) [142644] [Mon Nov  9 18:12:25 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011638s (85.925/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001154s |
| /checkout/index                                            | 0.001982s |
| /end                                                       | 0.000158s |
'------------------------------------------------------------+-----------'

[info] *** Request 15 (0.250/s) [142644] [Mon Nov  9 18:12:26 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011265s (88.771/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000901s |
| /checkout/index                                            | 0.001742s |
| /end                                                       | 0.000156s |
'------------------------------------------------------------+-----------'

[info] *** Request 16 (0.267/s) [142644] [Mon Nov  9 18:12:26 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011193s (89.342/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001024s |
| /checkout/index                                            | 0.001777s |
| /end                                                       | 0.000141s |
'------------------------------------------------------------+-----------'

[info] *** Request 17 (0.279/s) [142644] [Mon Nov  9 18:12:27 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.013265s (75.386/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001470s |
| /checkout/index                                            | 0.002106s |
| /end                                                       | 0.000203s |
'------------------------------------------------------------+-----------'

[info] *** Request 18 (0.295/s) [142644] [Mon Nov  9 18:12:27 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.015073s (66.344/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001480s |
| /checkout/index                                            | 0.003139s |
| /end                                                       | 0.000272s |
'------------------------------------------------------------+-----------'

[info] *** Request 19 (0.306/s) [142644] [Mon Nov  9 18:12:28 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011433s (87.466/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001086s |
| /checkout/index                                            | 0.001817s |
| /end                                                       | 0.000150s |
'------------------------------------------------------------+-----------'

[info] *** Request 20 (0.323/s) [142644] [Mon Nov  9 18:12:28 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.015906s (62.869/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001309s |
| /checkout/index                                            | 0.002725s |
| /end                                                       | 0.000226s |
'------------------------------------------------------------+-----------'

[info] *** Request 21 (0.333/s) [142644] [Mon Nov  9 18:12:29 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.016408s (60.946/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001445s |
| /checkout/index                                            | 0.002905s |
| /end                                                       | 0.000211s |
'------------------------------------------------------------+-----------'

[info] *** Request 22 (0.349/s) [142644] [Mon Nov  9 18:12:29 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.0152s (65.789/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001611s |
| /checkout/index                                            | 0.003504s |
| /end                                                       | 0.000255s |
'------------------------------------------------------------+-----------'


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Couldn't instantiate component "MyShop::Model::PayPal", "Inconsistent hierarchy during C3 merge of class 'MyShop::Model::PayPal':
	current merge results [
		MyShop::Model::PayPal,
	]
	merging failed on 'Moose::Object' at /usr/lib/x86_64-linux-gnu/perl/5.30/mro.pm line 27."Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /auto                | MyShop::Controller::Root             | auto         |
| /index               | MyShop::Controller::Root             | index        |
| /end                 | MyShop::Controller::Root             | end          |
| /default             | MyShop::Controller::Root             | default      |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/verify     | MyShop::Controller::Register         | verify       |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Model/PayPal.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /auto                | MyShop::Controller::Root             | auto         |
| /index               | MyShop::Controller::Root             | index        |
| /end                 | MyShop::Controller::Root             | end          |
| /default             | MyShop::Controller::Root             | default      |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
^[[A[info] *** Request 1 (0.006/s) [144558] [Mon Nov  9 18:14:11 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.01431s (69.881/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001448s |
| /checkout/index                                            | 0.001778s |
| /end                                                       | 0.000167s |
'------------------------------------------------------------+-----------'

[info] *** Request 2 (0.012/s) [144558] [Mon Nov  9 18:14:12 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.014134s (70.751/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001234s |
| /checkout/index                                            | 0.002496s |
| /end                                                       | 0.000174s |
'------------------------------------------------------------+-----------'

[info] *** Request 3 (0.018/s) [144558] [Mon Nov  9 18:14:12 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.012471s (80.186/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001047s |
| /checkout/index                                            | 0.002099s |
| /end                                                       | 0.000190s |
'------------------------------------------------------------+-----------'

[info] *** Request 4 (0.024/s) [144558] [Mon Nov  9 18:14:12 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.0135420000000001s (73.844/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001246s |
| /checkout/index                                            | 0.002610s |
| /end                                                       | 0.000175s |
'------------------------------------------------------------+-----------'

[info] *** Request 5 (0.030/s) [144558] [Mon Nov  9 18:14:13 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[error] Caught exception in MyShop::Controller::Checkout->index "Can't locate object method "SetExpressCheckout" via package "MyShop::Model::PayPal" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 28."
[debug] Response Code: 500; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.014212s (70.363/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000923s |
| /checkout/index                                            | 0.003400s |
| /end                                                       | 0.000232s |
'------------------------------------------------------------+-----------'


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /index               | MyShop::Controller::Root             | index        |
| /auto                | MyShop::Controller::Root             | auto         |
| /default             | MyShop::Controller::Root             | default      |
| /end                 | MyShop::Controller::Root             | end          |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/details       | MyShop::Controller::Books            | details      |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
^C
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# cd ..
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl# chmod -R 777 /www/store[C[C[C[C[C[K[K[K[K[K[K[K[K[Km[K[K/My[K[K[KMyShop/
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl# chmod -R 777 MyShop/d ..[Kscript/myshop_server.pl -r[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Ccd ..[K[K[KMyShop/
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# cd MyShop/[10@hmod -R 777[C[C[C[C[C[C[C[Cd ..[Kscript/myshop_server.pl -r
[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /index               | MyShop::Controller::Root             | index        |
| /end                 | MyShop::Controller::Root             | end          |
| /auto                | MyShop::Controller::Root             | auto         |
| /default             | MyShop::Controller::Root             | default      |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/index         | MyShop::Controller::Books            | index        |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /index               | MyShop::Controller::Root             | index        |
| /end                 | MyShop::Controller::Root             | end          |
| /auto                | MyShop::Controller::Root             | auto         |
| /default             | MyShop::Controller::Root             | default      |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/details       | MyShop::Controller::Books            | details      |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /auto                | MyShop::Controller::Root             | auto         |
| /default             | MyShop::Controller::Root             | default      |
| /index               | MyShop::Controller::Root             | index        |
| /end                 | MyShop::Controller::Root             | end          |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
[info] *** Request 1 (0.005/s) [147446] [Mon Nov  9 18:22:10 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Redirecting to "https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-3H577389L9678442P"
[debug] Response Code: 302; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 1.957686s (0.511/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001706s |
| /checkout/index                                            | 1.947862s |
| /end                                                       | 0.000244s |
'------------------------------------------------------------+-----------'


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /default             | MyShop::Controller::Root             | default      |
| /auto                | MyShop::Controller::Root             | auto         |
| /end                 | MyShop::Controller::Root             | end          |
| /index               | MyShop::Controller::Root             | index        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/details       | MyShop::Controller::Books            | details      |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/verify     | MyShop::Controller::Register         | verify       |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /default             | MyShop::Controller::Root             | default      |
| /auto                | MyShop::Controller::Root             | auto         |
| /end                 | MyShop::Controller::Root             | end          |
| /index               | MyShop::Controller::Root             | index        |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
[info] *** Request 1 (0.003/s) [147852] [Mon Nov  9 18:23:50 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Redirecting to "https://www.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=EC-83S81841PL718154P"
[debug] Response Code: 302; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 1.919331s (0.521/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001439s |
| /checkout/index                                            | 1.911030s |
| /end                                                       | 0.000233s |
'------------------------------------------------------------+-----------'


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /default             | MyShop::Controller::Root             | default      |
| /auto                | MyShop::Controller::Root             | auto         |
| /end                 | MyShop::Controller::Root             | end          |
| /index               | MyShop::Controller::Root             | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/index         | MyShop::Controller::Books            | index        |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/verify     | MyShop::Controller::Register         | verify       |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
[info] *** Request 1 (0.002/s) [148508] [Mon Nov  9 18:26:15 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Redirecting to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token==EC-9R258196KA344692C"
[debug] Response Code: 302; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 2.156361s (0.464/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001727s |
| /checkout/index                                            | 2.147773s |
| /end                                                       | 0.000209s |
'------------------------------------------------------------+-----------'


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /auto                | MyShop::Controller::Root             | auto         |
| /default             | MyShop::Controller::Root             | default      |
| /index               | MyShop::Controller::Root             | index        |
| /end                 | MyShop::Controller::Root             | end          |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/index      | MyShop::Controller::Register         | index        |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
[info] *** Request 1 (0.002/s) [148806] [Mon Nov  9 18:26:31 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Redirecting to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-6UK16242JF141511G"
[debug] Response Code: 302; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 1.844408s (0.542/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001400s |
| /checkout/index                                            | 1.836203s |
| /end                                                       | 0.000224s |
'------------------------------------------------------------+-----------'


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /end                 | MyShop::Controller::Root             | end          |
| /index               | MyShop::Controller::Root             | index        |
| /default             | MyShop::Controller::Root             | default      |
| /auto                | MyShop::Controller::Root             | auto         |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/index         | MyShop::Controller::Books            | index        |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /checkout/test       | MyShop::Controller::Checkout         | test         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /checkout/test/...                  | /checkout/test                       |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /end                 | MyShop::Controller::Root             | end          |
| /index               | MyShop::Controller::Root             | index        |
| /default             | MyShop::Controller::Root             | default      |
| /auto                | MyShop::Controller::Root             | auto         |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /checkout/test       | MyShop::Controller::Checkout         | test         |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/verify     | MyShop::Controller::Register         | verify       |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /checkout/test/...                  | /checkout/test                       |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
^C
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# node -v
v10.19.0
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# cd /etc//[Kg[Kb[Kn[K[K[K[K[K[K[K[Kat /[K[K[K[K[Kless /etc/nginx/nginx.conf 
[?1049h[22;0;0t[?1h=user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
worker_rlimit_nofile 100000;

events {
        worker_connections 4000;
        use epoll;
        multi_accept on;
}

http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;

[7m/etc/nginx/nginx.conf[27m[K...skipping...
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
worker_rlimit_nofile 100000;

events {
        worker_connections 4000;
        use epoll;
        multi_accept on;
}

http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;

        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        ##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        ##
        # Gzip Settings
        ##
        access_log off;
        gzip on;

        gzip_vary on;
        gzip_proxied expired no-cache no-store private auth;
        gzip_comp_level 1;
        gzip_buffers 16 8k;
        gzip_http_version 1.1;
        gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
        reset_timedout_connection on;
        client_body_timeout 10;
        send_timeout 2;
        keepalive_timeout 30;
        keepalive_requests 100000;


        ##
:[K[K        # Virtual Host Configs
        ##

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
}


#mail {
#       # See sample authentication script at:
#       # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
# 
#       # auth_http localhost/auth.php;
#       # pop3_capabilities "TOP" "USER";
#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
# 
#       server {
#               listen     localhost:110;
#               protocol   pop3;
#               proxy      on;
#       }
# 
#       server {
#               listen     localhost:143;
#               protocol   imap;
#               proxy      on;
#       }
#}
[7m(END)[27m[K[K[K[7m(END)[27m[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_name_in_redirect off;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_names_hash_bucket_size 64;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_tokens off;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        types_hash_max_size 2048;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        tcp_nodelay on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        tcp_nopush on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        sendfile on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        ##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # Basic Settings
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        ##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMhttp {
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM}
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        multi_accept on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        use epoll;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        worker_connections 4000;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMevents {
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMworker_rlimit_nofile 100000;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMinclude /etc/nginx/modules-enabled/*.conf;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMpid /run/nginx.pid;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMworker_processes auto;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMuser www-data;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KBB[K        # Virtual Host Configs
:[K[K [KESCESC[KOO[KBB[K        ##
:[K[K [KESCESC[KOO[KBB[K
:[K[K [KESCESC[KOO[KBB[K        include /etc/nginx/conf.d/*.conf;
:[K[K [KESCESC[KOO[KBB[K        include /etc/nginx/sites-enabled/*;
:[K[K [KESCESC[KOO[KBB[K}
:[K[K [KESCESC[KOO[KBB[K
:[K[K [KESCESC[KOO[KBB[K
:[K[K [KESCESC[KOO[KBB[K#mail {
:[K[K [KESCESC[KOO[KBB[K#       # See sample authentication script at:
:[K[K [KESCESC[KOO[KBB[K#       # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
:[K[K [KESCESC[KOO[KBB[K# 
:[K[K [KESCESC[KOO[KBB[K#       # auth_http localhost/auth.php;
:[K[K [KESCESC[KOO[KBB[K#       # pop3_capabilities "TOP" "USER";
:[K[K [KESCESC[KOO[KBB[K#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
:[K[K [KESCESC[KOO[KBB[K# 
:[K[K [KESCESC[KOO[KBB[K#       server {
:[K[K [KESCESC[KOO[KBB[K#               listen     localhost:110;
:[K[K [KESCESC[KOO[KBB[K#               protocol   pop3;
:[K[K [KESCESC[KOO[KBB[K#               proxy      on;
:[K[K [KESCESC[KOO[KBB[K#       }
:[K[K [KESCESC[KOO[KBB[K# 
:[K[K [KESCESC[KOO[KBB[K#       server {
:[K[K [KESCESC[KOO[KBB[K#               listen     localhost:143;
:[K[K [KESCESC[KOO[KBB[K#               protocol   imap;
:[K[K [KESCESC[KOO[KBB[K#               proxy      on;
:[K[K [KESCESC[KOO[KBB[K#       }
:[K[K [KESCESC[KOO[KBB[K#}
[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_name_in_redirect off;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_names_hash_bucket_size 64;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_tokens off;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        types_hash_max_size 2048;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        tcp_nodelay on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        tcp_nopush on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        sendfile on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        ##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # Basic Settings
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        ##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMhttp {
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM}
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        multi_accept on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        use epoll;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        worker_connections 4000;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMevents {
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMworker_rlimit_nofile 100000;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMinclude /etc/nginx/modules-enabled/*.conf;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMpid /run/nginx.pid;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMworker_processes auto;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMuser www-data;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KBB[K        # Virtual Host Configs
:[K[K [KESCESC[KOO[KBB[K        ##
:[K[K [KESCESC[KOO[KBB[K
:[K[K [KESCESC[KOO[KBB[K        include /etc/nginx/conf.d/*.conf;
:[K[K [KESCESC[KOO[KBB[K        include /etc/nginx/sites-enabled/*;
:[K[K [KESCESC[KOO[KBB[K}
:[K[K [KESCESC[KOO[KBB[K
:[K[K [KESCESC[KOO[KBB[K
:[K[K [KESCESC[KOO[KBB[K#mail {
:[K[K [KESCESC[KOO[KBB[K#       # See sample authentication script at:
:[K[K [KESCESC[KOO[KBB[K#       # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
:[K[K [KESCESC[KOO[KBB[K# 
:[K[K [KESCESC[KOO[KBB[K#       # auth_http localhost/auth.php;
:[K[K [KESCESC[KOO[KBB[K#       # pop3_capabilities "TOP" "USER";
:[K[K [KESCESC[KOO[KBB[K#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
:[K[K [KESCESC[KOO[KBB[K# 
:[K[K [KESCESC[KOO[KBB[K#       server {
:[K[K [KESCESC[KOO[KBB[K#               listen     localhost:110;
:[K[K [KESCESC[KOO[KBB[K#               protocol   pop3;
:[K[K [KESCESC[KOO[KBB[K#               proxy      on;
:[K[K [KESCESC[KOO[KBB[K#       }
:[K[K [KESCESC[KOO[KBB[K# 
:[K[K [KESCESC[KOO[KBB[K#       server {
:[K[K [KESCESC[KOO[KBB[K#               listen     localhost:143;
:[K[K [KESCESC[KOO[KBB[K#               protocol   imap;
:[K[K [KESCESC[KOO[KBB[K#               proxy      on;
:[K[K [KESCESC[KOO[KBB[K#       }
:[K[K [KESCESC[KOO[KBB[K#}
[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_name_in_redirect off;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_names_hash_bucket_size 64;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_tokens off;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        types_hash_max_size 2048;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        tcp_nodelay on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        tcp_nopush on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        sendfile on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        ##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # Basic Settings
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        ##
[66;1H[K:[K[K [KESCESC[KOO[KBB[K#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
:[K[K [KESCESC[KOO[KBB[K# 
:[K[K [KESCESC[KOO[KBB[K#       server {
:[K[K [KESCESC[KOO[KBB[K#               listen     localhost:110;
:[K[K [KESCESC[KOO[KBB[K#               protocol   pop3;
:[K[K [KESCESC[KOO[KBB[K#               proxy      on;
:[K[K [KESCESC[KOO[KBB[K#       }
:[K[K [KESCESC[KOO[KBB[K# 
:[K[K [KESCESC[KOO[KBB[K#       server {
:[K[K [KESCESC[KOO[KBB[K#               listen     localhost:143;
:[K[K [KESCESC[KOO[KBB[K#               protocol   imap;
:[K[K [KESCESC[KOO[KBB[K#               proxy      on;
:[K[K [KESCESC[KOO[KBB[K#       }
:[K[K [KESCESC[KOO[KBB[K#}
[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_name_in_redirect off;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_names_hash_bucket_size 64;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # server_tokens off;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        types_hash_max_size 2048;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        tcp_nodelay on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        tcp_nopush on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        sendfile on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        ##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # Basic Settings
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        ##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMhttp {
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM}
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        multi_accept on;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        use epoll;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        worker_connections 4000;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMevents {
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMworker_rlimit_nofile 100000;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMinclude /etc/nginx/modules-enabled/*.conf;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMpid /run/nginx.pid;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMworker_processes auto;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMuser www-data;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K[?1l>[?1049l[23;0;0t]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# less /etc/nginx/nginx.conf [K[K[K[K[K[K[K[K[K[K[Ksites-enabled/0[K
default          www.example.com  
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# less /etc/nginx/sites-enabled/
default          www.example.com  
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# less /etc/nginx/sites-enabled/default 
[?1049h[22;0;0t[?1h=##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# https://www.nginx.com/resources/wiki/start/
# https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
# https://wiki.debian.org/Nginx/DirectoryStructure
#
# In most cases, administrators will remove this file from sites-enabled/ and
# leave it as reference inside of sites-available where it will continue to be
# updated by the nginx packaging team.
#
# This file will automatically load configuration files provided by other
# applications, such as Drupal or Wordpress. These applications will be made
# available underneath a path with that package name, such as /drupal8.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Default server configuration
#
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # SSL configuration
        #
        # listen 443 ssl default_server;
        # listen [::]:443 ssl default_server;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!
        #
        # include snippets/snakeoil.conf;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }

        # pass PHP scripts to FastCGI server
        #
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
        #
        #       # With php-fpm (or other unix sockets):
        #       fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
                # With php-cgi (or other tcp sockets):
                fastcgi_pass 127.0.0.1:9000;
        }

        # deny access to .htaccess files, if Apache's document root
[7m/etc/nginx/sites-enabled/default[27m[K[K [KESCESC[KOO[KBB[K        # concurs with nginx's one
:[K[K [KESCESC[KOO[KBB[K        #
:[K[K [KESCESC[KOO[KBB[K        #location ~ /\.ht {
:[K[K [KESCESC[KOO[KBB[K        #       deny all;
:[K[K [KESCESC[KOO[KBB[K        #}
:[K[K [KESCESC[KOO[KBB[K}
:[K[K [KESCESC[KOO[KBB[K
:[K[K [KESCESC[KOO[KBB[K
:[K[K [KESCESC[KOO[KBB[K# Virtual Host configuration for example.com
:[K[K [KESCESC[KOO[KBB[K#
:[K[K [KESCESC[KOO[KBB[K# You can move that to a different file under sites-available/ and symlink that
:[K[K [KESCESC[KOO[KBB[K# to sites-enabled/ to enable it.
:[K[K [KESCESC[KOO[KBB[K#
:[K[K [KESCESC[KOO[KBB[K#server {
:[K[K [KESCESC[KOO[KBB[K#       listen 80;
:[K[K [KESCESC[KOO[KBB[K#       listen [::]:80;
:[K[K [KESCESC[KOO[KBB[K#
:[K[K [KESCESC[KOO[KBB[K#       server_name example.com;
:[K[K [KESCESC[KOO[KBB[K#
:[K[K [KESCESC[KOO[KBB[K#       root /var/www/example.com;
:[K[K [KESCESC[KOO[KBB[K#       index index.html;
:[K[K [KESCESC[KOO[KBB[K#
:[K[K [KESCESC[KOO[KBB[K#       location / {
:[K[K [KESCESC[KOO[KBB[K#               try_files $uri $uri/ =404;
:[K[K [KESCESC[KOO[KBB[K#       }
:[K[K [KESCESC[KOO[KBB[K#}
[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KBB[K[K[7m(END)[27m[K[K [KESCESC[KOO[KAA[K[HM        #
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        # SSL configuration
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        listen [::]:80 default_server;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM        listen 80 default_server;
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HMserver {
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM#
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# Default server configuration
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM#
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# available underneath a path with that package name, such as /drupal8.
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# applications, such as Drupal or Wordpress. These applications will be made
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# This file will automatically load configuration files provided by other
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM#
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# updated by the nginx packaging team.
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# leave it as reference inside of sites-available where it will continue to be
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# In most cases, administrators will remove this file from sites-enabled/ and
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM#
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# https://wiki.debian.org/Nginx/DirectoryStructure
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# https://www.nginx.com/resources/wiki/start/
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# of Nginx configuration files in order to fully unleash the power of Nginx.
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM# You should look at the following URL's in order to grasp a solid understanding
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[HM##
[66;1H[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K [KESCESC[KOO[KAA[K[K:[K[K[?1l>[?1049l[23;0;0t]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# less /etc/nginx/sites-enabled/default [11Pnginx.conf[C
[?1049h[22;0;0t[?1h=user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
worker_rlimit_nofile 100000;

events {
        worker_connections 4000;
        use epoll;
        multi_accept on;
}

http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;

        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        ##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        ##
        # Gzip Settings
        ##
        access_log off;
        gzip on;

        gzip_vary on;
        gzip_proxied expired no-cache no-store private auth;
        gzip_comp_level 1;
        gzip_buffers 16 8k;
        gzip_http_version 1.1;
        gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
        reset_timedout_connection on;
        client_body_timeout 10;
        send_timeout 2;
        keepalive_timeout 30;
        keepalive_requests 100000;


        ##
[7m/etc/nginx/nginx.conf[27m[K[H[2J[H[H[2J[Huser www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
worker_rlimit_nofile 100000;

events {
        worker_connections 4000;
        use epoll;
        multi_accept on;
}

http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;

:[K[K:[K[K[?1l>[?1049l[23;0;0t]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# cd ..
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl# cd ..
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasksroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks# cd webServer-Pe[K[Kperl/
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# ls
backup.pl  [0m[01;31mdiscord-0.0.12.deb[0m  index.html  [01;35mpeng.png[0m  webServer.pl
[01;34mcgi-bin[0m    http_handler.pl     log.conf    perl.pl
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# perl W[KwebServer.pl 
IO::Socket::INET=GLOB(0x5637cb5a3c30) at webServer.pl line 151.
^C
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# perl webServer.pl 
IO::Socket::INET=GLOB(0x55e181979c18) at webServer.pl line 151.
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# perl webServer.pl 
IO::Socket::INET=GLOB(0x556bd98a6c18) at webServer.pl line 151.
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# perl webServer.pl 
IO::Socket::INET=GLOB(0x55cb4d492c18) at webServer.pl line 151.
^C
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# perl webServer.pl 
IO::Socket::INET=GLOB(0x5617e4ff7c18) at webServer.pl line 151.
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# perl webServer.pl 
IO::Socket::INET=GLOB(0x55963f20ec18) at webServer.pl line 151.
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# perl webServer.pl 
IO::Socket::INET=GLOB(0x55b858776c18) at webServer.pl line 151.
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/webServer-perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/webServer-perl# cd .[KwebServer.pl [K[K[K[K[K[K[K[K[K[K[K[K[K..
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasksroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks# ls
[0m[01;34mekatte[0m  [01;34mindexTests[0m  [34;42mmagazin-Perl[0m   [01;34mwebServer[0m         [01;34mwebServer-node[0m  [01;34mwordpress[0m
[01;34mfast[0m    [01;34mmagazin[0m     [01;34mself-learning[0m  [01;34mwebServer-golang[0m  [01;34mwebServer-perl[0m
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasksroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks# cd web[K[K[Kmagazin-Perl/
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl# ls
[0m[34;42mMyShop[0m  [34;42mproduct_images[0m
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perlroot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl# cd MyShop/
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# cat README 
Run script/myshop_server.pl to test the application.
]0;root@aiuzunov-HP-Compaq-Elite-8300-SFF: /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShoproot@aiuzunov-HP-Compaq-Elite-8300-SFF:/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop# ./ [Kscript/myshop_server.pl -r
[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /auto                | MyShop::Controller::Root             | auto         |
| /index               | MyShop::Controller::Root             | index        |
| /default             | MyShop::Controller::Root             | default      |
| /end                 | MyShop::Controller::Root             | end          |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/index         | MyShop::Controller::Books            | index        |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /checkout/test       | MyShop::Controller::Checkout         | test         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /checkout/test/...                  | /checkout/test                       |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Global symbol "$value_count" requires explicit package name (did you forget to declare "my $value_count"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 40.
Global symbol "$value_count" requires explicit package name (did you forget to declare "my $value_count"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 40.
Global symbol "$price" requires explicit package name (did you forget to declare "my $price"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 40.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Global symbol "$value_count" requires explicit package name (did you forget to declare "my $value_count"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 40.
Global symbol "$price" requires explicit package name (did you forget to declare "my $price"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 40.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /auto                | MyShop::Controller::Root             | auto         |
| /end                 | MyShop::Controller::Root             | end          |
| /default             | MyShop::Controller::Root             | default      |
| /index               | MyShop::Controller::Root             | index        |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/index         | MyShop::Controller::Books            | index        |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /checkout/test       | MyShop::Controller::Checkout         | test         |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/index      | MyShop::Controller::Register         | index        |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /checkout/test/...                  | /checkout/test                       |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Bareword found where operator expected at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 41, near "$value count"
	(Missing operator before count?)
Global symbol "$value" requires explicit package name (did you forget to declare "my $value"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 41.
syntax error at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 41, near "$value count "
Global symbol "$price" requires explicit package name (did you forget to declare "my $price"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 41.
Global symbol "$pp" requires explicit package name (did you forget to declare "my $pp"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 44.
Global symbol "$c" requires explicit package name (did you forget to declare "my $c"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 51.
syntax error at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 54, near "}"
Can't redeclare "my" in "my" at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 65, near "my"
Global symbol "$c" requires explicit package name (did you forget to declare "my $c"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 65.
syntax error at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 70, near "}"
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Global symbol "$price" requires explicit package name (did you forget to declare "my $price"?) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 41.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.
Compilation failed in require at /usr/share/perl5/Catalyst/Utils.pm line 309.

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /default             | MyShop::Controller::Root             | default      |
| /index               | MyShop::Controller::Root             | index        |
| /end                 | MyShop::Controller::Root             | end          |
| /auto                | MyShop::Controller::Root             | auto         |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /books/list          | MyShop::Controller::Books            | list         |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/index         | MyShop::Controller::Books            | index        |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /checkout/test       | MyShop::Controller::Checkout         | test         |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/index      | MyShop::Controller::Register         | index        |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /checkout/test/...                  | /checkout/test                       |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop/Controller/Checkout.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/x-www-form-urlencoded                                          |
| application/json                                                           |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /auto                | MyShop::Controller::Root             | auto         |
| /end                 | MyShop::Controller::Root             | end          |
| /index               | MyShop::Controller::Root             | index        |
| /default             | MyShop::Controller::Root             | default      |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /checkout/test       | MyShop::Controller::Checkout         | test         |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/verify     | MyShop::Controller::Register         | verify       |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...              | /admin/update_user                   |
| /admin/users/...                    | /admin/users                         |
| /books/                             | /books/index                         |
| /books/details/...                  | /books/details                       |
| /books/list/...                     | /books/list                          |
| /cart/                              | /cart/index                          |
| /cart/add/...                       | /cart/add                            |
| /cart/empty_cart/...                | /cart/empty_cart                     |
| /cart/list/...                      | /cart/list                           |
| /cart/remove/...                    | /cart/remove                         |
| /cart/update/...                    | /cart/update                         |
| /checkout/                          | /checkout/index                      |
| /checkout/test/...                  | /checkout/test                       |
| /login/                             | /login/index                         |
| /logout/                            | /logout/index                        |
| /register/                          | /register/index                      |
| /register/register_form/...         | /register/register_form              |
| /register/send_mail/...             | /register/send_mail                  |
| /register/verify/...                | /register/verify                     |
'-------------------------------------+--------------------------------------'

[info] MyShop powered by Catalyst 5.90126
HTTP::Server::PSGI: Accepting connections at http://0:3000/
Use of uninitialized value in addition (+) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 41.
0 at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 42.
[info] *** Request 1 (0.003/s) [157744] [Mon Nov  9 19:54:38 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Redirecting to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-11R33589GB294994N"
[debug] Response Code: 302; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 1.929532s (0.518/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001781s |
| /checkout/index                                            | 1.920966s |
| /end                                                       | 0.000216s |
'------------------------------------------------------------+-----------'

[info] *** Request 2 (0.005/s) [157744] [Mon Nov  9 19:55:05 2020] ***
[debug] Path is "/"
[debug] "GET" request for "/" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.005733s (174.429/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000990s |
| /index                                                     | 0.000298s |
| /end                                                       | 0.000108s |
'------------------------------------------------------------+-----------'

[info] *** Request 3 (0.008/s) [157744] [Mon Nov  9 19:55:07 2020] ***
[debug] Path is "cart"
[debug] "GET" request for "cart" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.006059s (165.044/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000934s |
| /cart/index                                                | 0.000075s |
| /end                                                       | 0.000124s |
'------------------------------------------------------------+-----------'

[info] *** Request 4 (0.011/s) [157744] [Mon Nov  9 19:55:10 2020] ***
[debug] Path is "cart/list"
[debug] "GET" request for "cart/list" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Rendering template "cart/list.tt2"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.027931s (35.803/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000994s |
| /cart/list                                                 | 0.000302s |
| /end                                                       | 0.022275s |
|  -> MyShop::View::HTML->process                            | 0.021835s |
'------------------------------------------------------------+-----------'

[info] *** Request 6 (0.016/s) [157744] [Mon Nov  9 19:55:11 2020] ***
[debug] Path is "books/list"
[debug] "GET" request for "books/list" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Rendering template "books/list.tt2"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.080853s (12.368/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000974s |
| /books/list                                                | 0.038618s |
| /end                                                       | 0.036029s |
|  -> MyShop::View::HTML->process                            | 0.035588s |
'------------------------------------------------------------+-----------'

[info] *** Request 7 (0.019/s) [157744] [Mon Nov  9 19:55:12 2020] ***
[debug] Path is "books/details"
[debug] "GET" request for "books/details" from "127.0.0.1"
[debug] Query Parameters are:
.-------------------------------------+--------------------------------------.
| Parameter                           | Value                                |
+-------------------------------------+--------------------------------------+
| id                                  | 5                                    |
'-------------------------------------+--------------------------------------'
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Rendering template "books/details.tt2"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.023998s (41.670/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001568s |
| /books/details                                             | 0.004177s |
| /end                                                       | 0.011734s |
|  -> MyShop::View::HTML->process                            | 0.011254s |
'------------------------------------------------------------+-----------'

[info] *** Request 8 (0.021/s) [157744] [Mon Nov  9 19:55:13 2020] ***
[debug] Path is "cart/add"
[debug] Arguments are "5"
[debug] "GET" request for "cart/add/5" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Rendering template "cart/add.tt2"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.011467s (87.207/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001326s |
| /cart/add                                                  | 0.002139s |
| /end                                                       | 0.002327s |
|  -> MyShop::View::HTML->process                            | 0.001922s |
'------------------------------------------------------------+-----------'

[info] *** Request 9 (0.024/s) [157744] [Mon Nov  9 19:55:14 2020] ***
[debug] Path is "books/list"
[debug] "GET" request for "books/list" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Rendering template "books/list.tt2"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.047917s (20.869/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000916s |
| /books/list                                                | 0.003605s |
| /end                                                       | 0.038915s |
|  -> MyShop::View::HTML->process                            | 0.038465s |
'------------------------------------------------------------+-----------'

[info] *** Request 10 (0.026/s) [157744] [Mon Nov  9 19:55:15 2020] ***
[debug] Path is "books/details"
[debug] "GET" request for "books/details" from "127.0.0.1"
[debug] Query Parameters are:
.-------------------------------------+--------------------------------------.
| Parameter                           | Value                                |
+-------------------------------------+--------------------------------------+
| id                                  | 8                                    |
'-------------------------------------+--------------------------------------'
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Rendering template "books/details.tt2"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.014802s (67.558/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.001043s |
| /books/details                                             | 0.003449s |
| /end                                                       | 0.005543s |
|  -> MyShop::View::HTML->process                            | 0.005170s |
'------------------------------------------------------------+-----------'

[info] *** Request 11 (0.029/s) [157744] [Mon Nov  9 19:55:16 2020] ***
[debug] Path is "cart/add"
[debug] Arguments are "8"
[debug] "GET" request for "cart/add/8" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Rendering template "cart/add.tt2"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.00863s (115.875/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000892s |
| /cart/add                                                  | 0.001632s |
| /end                                                       | 0.001168s |
|  -> MyShop::View::HTML->process                            | 0.000811s |
'------------------------------------------------------------+-----------'

[info] *** Request 12 (0.031/s) [157744] [Mon Nov  9 19:55:17 2020] ***
[debug] Path is "books/list"
[debug] "GET" request for "books/list" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Rendering template "books/list.tt2"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 0.040153s (24.905/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000892s |
| /books/list                                                | 0.003016s |
| /end                                                       | 0.031830s |
|  -> MyShop::View::HTML->process                            | 0.031395s |
'------------------------------------------------------------+-----------'

Use of uninitialized value in addition (+) at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 41.
0 at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Checkout.pm line 42.
[info] *** Request 13 (0.034/s) [157744] [Mon Nov  9 19:55:21 2020] ***
[debug] Path is "checkout"
[debug] "GET" request for "checkout" from "127.0.0.1"
[debug] Found sessionid "7fe752aeb0b534677ba8981879e553a98efe56de" in cookie
[debug] Restored session "7fe752aeb0b534677ba8981879e553a98efe56de"
[debug] Redirecting to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-8KD03222RE6655324"
[debug] Response Code: 302; Content-Type: text/html; charset=utf-8; Content-Length: unknown
[info] Request took 2.03551s (0.491/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /auto                                                      | 0.000931s |
| /checkout/index                                            | 2.029690s |
| /end                                                       | 0.000167s |
'------------------------------------------------------------+-----------'


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default

Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop.pm (modify)

Attempting to restart the server


Saw changes to the following files:
 - /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/lib/MyShop.pm (modify)

Attempting to restart the server

[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded Config "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/myshop.conf"
[debug] Setting up auth realm default
Useless use of a constant ("quantity") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Cart.pm line 65.
Useless use of a constant ("\n") in void context at /home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop/script/../lib/MyShop/Controller/Register.pm line 45.
Term::Size::Any is not installed, can't autodetect terminal column width
Trouble trying to detect your terminal size, looking at $ENV{COLUMNS}
Cannot determine desired terminal width, using default of 80 columns
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::Authentication  0.10023                                  |
| Catalyst::Plugin::ConfigLoader  0.34                                       |
| Catalyst::Plugin::Redirect  0.02                                           |
| Catalyst::Plugin::Session  0.41                                            |
| Catalyst::Plugin::Session::State::Cookie  0.17                             |
| Catalyst::Plugin::Session::Store::File  0.18                               |
| Catalyst::Plugin::StackTrace  0.12                                         |
| Catalyst::Plugin::StatusMessage  1.002000                                  |
'----------------------------------------------------------------------------'

[debug] Loaded PSGI Middleware:
.----------------------------------------------------------------------------.
| Catalyst::Middleware::Stash                                                |
| Plack::Middleware::HTTPExceptions                                          |
| Plack::Middleware::RemoveRedundantBody  0.09                               |
| Plack::Middleware::FixMissingBodyInRedirect  0.10                          |
| Plack::Middleware::ContentLength                                           |
| Plack::Middleware::MethodOverride  0.20                                    |
| Plack::Middleware::Head                                                    |
'----------------------------------------------------------------------------'

[debug] Loaded Request Data Handlers:
.----------------------------------------------------------------------------.
| application/json                                                           |
| application/x-www-form-urlencoded                                          |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/home/aiuzunov/github/training-projects/tasks/magazin-Perl/MyShop"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| MyShop::Controller::Admin                                       | instance |
| MyShop::Controller::Books                                       | instance |
| MyShop::Controller::Cart                                        | instance |
| MyShop::Controller::Checkout                                    | instance |
| MyShop::Controller::Login                                       | instance |
| MyShop::Controller::Logout                                      | instance |
| MyShop::Controller::Register                                    | instance |
| MyShop::Controller::Root                                        | instance |
| MyShop::Model::DB                                               | instance |
| MyShop::Model::DB::Address                                      | class    |
| MyShop::Model::DB::CartItem                                     | class    |
| MyShop::Model::DB::Currency                                     | class    |
| MyShop::Model::DB::EmailCode                                    | class    |
| MyShop::Model::DB::Employee                                     | class    |
| MyShop::Model::DB::FailedLogin                                  | class    |
| MyShop::Model::DB::LockSetting                                  | class    |
| MyShop::Model::DB::Order                                        | class    |
| MyShop::Model::DB::OrderItem                                    | class    |
| MyShop::Model::DB::Payment                                      | class    |
| MyShop::Model::DB::Permission                                   | class    |
| MyShop::Model::DB::Product                                      | class    |
| MyShop::Model::DB::ProductsDetail                               | class    |
| MyShop::Model::DB::Role                                         | class    |
| MyShop::Model::DB::RolesPerm                                    | class    |
| MyShop::Model::DB::Tag                                          | class    |
| MyShop::Model::DB::TagsProduct                                  | class    |
| MyShop::Model::DB::User                                         | class    |
| MyShop::Model::PayPal                                           | instance |
| MyShop::View::Email                                             | instance |
| MyShop::View::HTML                                              | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /index               | MyShop::Controller::Root             | index        |
| /default             | MyShop::Controller::Root             | default      |
| /end                 | MyShop::Controller::Root             | end          |
| /auto                | MyShop::Controller::Root             | auto         |
| /admin/products      | MyShop::Controller::Admin            | products     |
| /admin/create        | MyShop::Controller::Admin            | create       |
| /admin/users         | MyShop::Controller::Admin            | users        |
| /admin/update_user   | MyShop::Controller::Admin            | update_user  |
| /admin/delete        | MyShop::Controller::Admin            | delete       |
| /admin/index         | MyShop::Controller::Admin            | index        |
| /admin/create_user   | MyShop::Controller::Admin            | create_user  |
| /admin/update        | MyShop::Controller::Admin            | update       |
| /books/index         | MyShop::Controller::Books            | index        |
| /books/details       | MyShop::Controller::Books            | details      |
| /books/list          | MyShop::Controller::Books            | list         |
| /cart/update         | MyShop::Controller::Cart             | update       |
| /cart/remove         | MyShop::Controller::Cart             | remove       |
| /cart/add            | MyShop::Controller::Cart             | add          |
| /cart/index          | MyShop::Controller::Cart             | index        |
| /cart/list           | MyShop::Controller::Cart             | list         |
| /cart/empty_cart     | MyShop::Controller::Cart             | empty_cart   |
| /checkout/index      | MyShop::Controller::Checkout         | index        |
| /checkout/test       | MyShop::Controller::Checkout         | test         |
| /login/index         | MyShop::Controller::Login            | index        |
| /logout/index        | MyShop::Controller::Logout           | index        |
| /register/index      | MyShop::Controller::Register         | index        |
| /register/send_mail  | MyShop::Controller::Register         | send_mail    |
| /register/verify     | MyShop::Controller::Register         | verify       |
| /register/register_- | MyShop::Controller::Register         | register_fo- |
| form                 |                                      | rm           |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
| /admin/                             | /admin/index                         |
| /admin/create/...                   | /admin/create                        |
| /admin/create_user/...              | /admin/create_user                   |
| /admin/delete/...                   | /admin/delete                        |
| /admin/products/...                 | /admin/products                      |
| /admin/update/...                   | /admin/update                        |
| /admin/update_user/...  