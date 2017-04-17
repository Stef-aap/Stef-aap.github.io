<?php
 $handle = @fopen("http://212.67.187.58/1", "r");
 if ($handle === true)
  {
   fclose($handle);
   print "The JAL-v2-ethernet-PIC is available"
  }
 else
  {
   print "Sorry the JAL-v2-ethernet-PIC is not available at the moment"
  }
?>