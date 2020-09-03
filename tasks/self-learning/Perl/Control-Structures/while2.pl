print "Enter a string /Ctrl+D or Ctrl+Z for eof/:\n";
@strings = <STDIN>;
while (@strings) {
 print pop @strings;
}
