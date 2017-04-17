<HTML><HEAD><TITLE>PuntHoofd MainIndex</TITLE>
<STYLE type="text/css"><!--
BODY {
  margin: 5px 5px 5px 5px;
  background-color: #BCCDF5;
}
--></STYLE>
<LINK type="text/css" href="rvf.css" rel=STYLESHEET>
<link rel="icon" href="punthoofd.gif" type="image/gif"></HEAD>
<BODY alink=#ff0000>
<P>&nbsp;</P>
<?php
  include('../pear/Request.php');
  echo "<P><SPAN class=RVTS1>News from JAL related sites</SPAN></P>";
	echo "<P>&nbsp;&nbsp;</P>";
	echo "<P>&nbsp;&nbsp;</P>";
  flush();

  // Bert van Dam ********************************************************************
  echo "<P>
			 <SPAN class=RVTS2>New from Bert:&nbsp;&nbsp;</SPAN>
 			 <A class=RVTS4 href='http://members.home.nl/b.vandam/lonely/index.html'>
     	    Bert's site
			 </A>
			 </P>";
  $site='http://members.home.nl/b.vandam/lonely/';
  echo '<base href="'.$site.'">';
  flush();
  $page = '';

  $site=$site.'hoofd.html';
  $req = &new HTTP_Request($site);
  $req->setMethod(HTTP_REQUEST_METHOD_GET);
  $req->setURL($site);
  $req->clearPostData();
  $req->sendRequest();
  $page = $req->getResponseBody();

  do {
    $page = strstr($page,"new");  //case sensitive !!
    $page = stristr($page,"<a");
    $i = strpos($page,"</A>");
    $line = substr($page,0,$i+4);
    $i = strpos($line,"TARGET");
		if ($i>0) {
      $line2 = substr($line,0,$i);
			$line = stristr($line,"TARGET");
			$line = stristr($line,">");
			$line = $line2.$line;
    }
		echo "<LI>".$line."</LI>";
  } while (strpos($page,"new"));
	echo "<P>&nbsp;&nbsp;</P>";
	echo "<P>&nbsp;&nbsp;</P>";



  // VASILE ********************************************************************
  $site='http://www.geocities.com/vsurducan/electro/PIC/';
  echo '<base href="'.$site.'">';
  $site=$site.'pic.htm';
  echo "<P>
          <SPAN class=RVTS2>New from Vasile:&nbsp;&nbsp;</SPAN>
          <A class=RVTS4 href='$site'> Vasile's site </A>
	</P>";
  flush();
  $page = '';
  $req = &new HTTP_Request($site);
  $req->setMethod(HTTP_REQUEST_METHOD_GET);
  $req->setURL($site);
  $req->clearPostData();
  $req->sendRequest();
  $page = $req->getResponseBody();

  do {
    $page = stristr($page,"new.gif");
    $page = stristr($page,"<A");
    $i = strpos($page,"/A>");
    $line = substr($page,0,$i+2);
		echo "<LI>".$line."</LI>";
  } while (strpos($page,"new.gif"));
	echo "<P>&nbsp;&nbsp;</P>";
	echo "<P>&nbsp;&nbsp;</P>";


  // uDEV *********************************************************************
  $site='http://perso.wanadoo.fr/udev/';
  echo "<P>
	 <SPAN class=RVTS2>New from Nicolas (uDev):&nbsp;&nbsp;</SPAN>
	 <A class=RVTS4 href='$site'> Nicolas's site </A>
        </P>";
  flush();
  echo '<base href="'.$site.'">';
  $page = '';
  $req = &new HTTP_Request($site);
  $req->setMethod(HTTP_REQUEST_METHOD_GET);
  $req->setURL($site);
  $req->clearPostData();
  $req->sendRequest();
  $page = $req->getResponseBody();

  $page = stristr($page,"news");
  $page = stristr($page,"<p>");
  $page = stristr($page,"<LI>");
  $i = strpos($page,"<hr>");
  $line = substr($page,0,$i-1);
	echo $line."<BR>";
	echo "<P>&nbsp;&nbsp;</P>";



  // uCHIP ********************************************************************
  $site='http://www.microchip.com/';
  echo "<P>
          <SPAN class=RVTS2>New from uChip:&nbsp;&nbsp;</SPAN>
 	  <A class=RVTS4 href='$site'> Microchip's site </A>
        </P>";
  $site=$site.'stellent/';
//werkt niet ??  echo '<base href="' . $site . '">';
  echo '<base href="http://www.microchip.com/stellent/">';
  flush();
  $page = '';

  $site=$site.'idcplg?IdcService=SS_GET_PAGE&nodeId=102';
  $req = &new HTTP_Request($site);
  $req->setMethod(HTTP_REQUEST_METHOD_GET);
  $req->setURL($site);
  $req->clearPostData();
  $req->sendRequest();
  $page = $req->getResponseBody();

  $page = stristr($page,"<strong>Errata");
	echo $page;


  //BASE TERUGZETTEN ***********************************************************
  echo '<base href="http://pic.flappie.nl/">';
 ?>
</BODY></HTML>
