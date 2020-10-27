#!/usr/bin/perl
use Error ':try';
use IPC::System::Simple qw(system capture);
use Log::Log4perl;
use strict;
use IO::Handle;
use threads;
use IO::Socket;

Log::Log4perl->init("log.conf");

$SIG{PIPE} = sub {};

my $log = Log::Log4perl->get_logger("Server::Logger");

sub get_date {
  my $datestring = localtime();
  return $datestring;
}


sub parse_form {
    my $data = $_[0];
    my %data;
    foreach (split /&/, $data) {
        my ($key, $val) = split /=/;
        $val =~ s/\+/ /g;
        $val =~ s/%(..)/chr(hex($1))/eg;
        $data{$key} = $val;}
    return %data; }



sub process_connection {
    my ($client, $addr) = @_;
    my %request = ();
    my %data;
    {
        local $/ = Socket::CRLF;
        while (<$client>) {
            chomp;
            if (/\s*(\w+)\s*([^\s]+)\s*HTTP\/(\d.\d)/) {
                $request{METHOD} = uc $1;
                $request{URL} = $2;
                $request{HTTP_VERSION} = $3;
            }
            elsif (/:/) {
                (my $type, my $val) = split /:/, $_, 2;
                $type =~ s/^\s+//;
                foreach ($type, $val) {
                        s/^\s+//;
                        s/\s+$//;
                }
                $request{lc $type} = $val;
            }
            elsif (/^$/) {
                read($client, $request{CONTENT}, $request{'content-length'})
                    if defined $request{'content-length'};
                last;
            }
        }
    }
    if ($request{METHOD} eq 'GET') {
        if ($request{URL} =~ /(.*)\?(.*)/) {
                $request{URL} = $1;
                $request{CONTENT} = $2;
                %data = parse_form($request{CONTENT});
        } else {
                %data = ();
        }
        $data{"_method"} = "GET";
    } elsif ($request{METHOD} eq 'POST') {
                %data = parse_form($request{CONTENT});
                $data{"_method"} = "POST";
    } else {
        $log->error(get_date()." ERROR: Unsupported Request Method, please try again using GET or POST");
        $data{"_method"} = "ERROR";
    }
        $log->trace(get_date()." AGENT: Client ".$addr." made a request using ".$request{'user-agent'});
        my $DOCUMENT_ROOT = ".";
        my $localfile = $DOCUMENT_ROOT.$request{URL};
        if (-e $localfile and -d $localfile) {
           $log->info(get_date()." ACCESS: A Client with IP: ".$addr." requested the index file of the following dir ".$localfile);
          if (open(FILE, "<$localfile/index.html")) {
                   print $client "HTTP/1.0 200 OK", Socket::CRLF;
                   print $client Socket::CRLF;
                   my $buffer;
                   while (read(FILE, $buffer, 65536)) {
                       print $client $buffer;
                   }
                   $data{"_status"} = "200";
               }
               else {
                   print $client "HTTP/1.0 404 Not Found", Socket::CRLF;
                   print $client Socket::CRLF;
                   print $client "<html><body>404 Not Found</body></html>";
                   $data{"_status"} = "404";
               }
               close(FILE);
        } else {
          if(index($request{URL},"/cgi-bin/") >= 0){
            $log->info(get_date()." ACCESS: A Client with IP: ".$addr." requested the following cgi script: ".$localfile);

            my @ARGS = ($request{CONTENT});
            my $results = capture($^X, $localfile, @ARGS);
            print $client "HTTP/1.0 200 OK", Socket::CRLF;
            print $client "Content-type:text/html",Socket::CRLF;
            print $client Socket::CRLF;
            print $client $results;
          }
          else{
        try{
          if (open(FILE, "<$localfile")) {
                $log->info(get_date()." ACCESS: A Client with IP: ".$addr." requested the following file: ".$localfile);
                print $client "HTTP/1.0 200 OK", Socket::CRLF;
                print $client Socket::CRLF;
                my $buffer;
                while (read(FILE, $buffer, 65536)) {
                    print $client $buffer;
                }
                $data{"_status"} = "200";
            }
            else {
                print $client "HTTP/1.0 404 Not Found", Socket::CRLF;
                print $client Socket::CRLF;
                print $client "<html><body>404 Not Found</body></html>";
                $data{"_status"} = "404";
            }
            close(FILE);

        } catch Error::Simple with {

             my $err = shift;
             $log->error(get_date()." ERROR: The following error occured".$err);
             print "ERROR: $err";
        };
      }
}

    close $client;

}

my $server = IO::Socket::INET->new( LocalPort => 9100,
                                    Type => SOCK_STREAM,
                                    Reuse => 1,
                                    Listen => SOMAXCONN )
                                    or die ("bind: $!\n");
$log->info(get_date()." INFO: The server has stared listening on the following address: localhost:9100");

warn $server;

sub worker {
    my ($n, $server) = @_;
    $log->info(get_date()." INFO: Worker ".$n." is now accepting new connections");
    while(my $client = $server->accept) {
        my $addr = $client->peerhost;
        process_connection($client, $addr);
    }
}

for my $n (1..20) {
    my $thr = threads->create(\&worker, $n, $server);
}

foreach my $thr (threads->list) {
    $thr->join;
}
