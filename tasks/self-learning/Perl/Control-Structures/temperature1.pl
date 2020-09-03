print "What is the current temperature?";
chomp ($temperature = <STDIN>);
if ($temperature > 72){
  print "Too hot!\n";
}
else{
  print "Too cold!\n";
}
