<?
//require ("config.php");

 # Allowed files (if thoose strings are founded then allowed to search)
 $allowed_names=Array(".htm",".txt",".php",".html",".phtml",".asp");

 # Disallowed files (if thoose strings are founded then disallowed to search)
 $disallowed_names=Array("config.php","search.php",".htaccess","language",
   ".gif",".jpg",".bmp",".bak",".css",
   "_frame.html","_index.html","_header.html",
	 "styles.txt");

 # Selection of result description
 $desc_header="<font size=-2>";
 $desc_footer="</font>";

 # Page separator
 $search_separator="&nbsp;&nbsp;&nbsp;&nbsp;";

 # Style of numbers. This is "1)" style.
 $interface_all="<b><font color=black>%1)</b></font> ";

 # Table colors
 $color0="#E4EBEF";
 $color1="#F0F0F0";
 $color2="#D0D0D0";
 
 # This is unique string used for tags cleaning...
 $explodestring="**^!separate!^**";

 # Location of start directory "" - root
 $start_search   ="/users/mientki/public_html/data_www/pic";
 $calculated_dir = "users/mientki/public_html";
 $user_dir       ="~mientki";

 # Results per page
 $pages=20;

 # maximum number of occurrences
 $maxoccurrences=3;



//***********************************************************************
//  MAIN PROGRAM
//***********************************************************************

  //Because the first entrance is a POST
  //  and clicking for the next page is a GET
	//  this weird construction
	//very strange, the construction used for "m" and "from" 
	//  doesn't work for "query"???
	$temp1 = $_POST['query']; 
	$temp2 = $_GET['query']; 
	if ($temp1<>"")  $query=$temp1; else $query=$temp2;
	
	$m = $_POST['m'];
	if ($m == "") $m = $_GET['m'];
	
	$from = $_POST['from'];
	if ($from == "") $from = $_GET['from'];

	if (!isset($from)) $from=1;
	if (!isset($query)) $query="";
	$query=strtolower(trim(strip_tags($query)));
	
	
	place_header();

//echo "BOE BABBABAahllao<br>";
//echo "query=".$_GET['query']."<br>";
//$aap1=$_POST['query'];
//$aap2=$_GET['query'];
//echo "sl=".strlen($aap1);
//echo "sl=".strlen($aap2);
//echo "query=".$query."<br>";
//echo "m=".$m."<br>";
//echo "from=".$from."<br>";
//echo "php_self=".$PHP_SELF."<br>";

	if ($query!="")
	{
	  $rootdir=$DOCUMENT_ROOT;
	  unset($filesearch);
	  countdirs($start_search);
	  $all=count($filesearch);
	  if ($all>0)
	  {
			if (isset($query)) 
	 		  echo str_replace("%1", $query, "Search Results for \"%1\"");
			else echo "Query string is not specifed.";
	
	    echo "<center>".
	      str_replace("%1", $all, "Found <b>%1</b> file(s).")
	     ."<br></center>\n";
	    echo "<table width=100% cellspacing=0 cellpadding=1>\n";
	
	    $showed=0;
	    DisplayNavbar($all);
	    for($i=$from;$i < $from+$pages;++$i)
	    {
	      if ($i >= $all+1) break;
	      Render($filesearch[$i-1], $i);
	    }
	    DisplayNavbar($all);
	    echo "</table>\n";
	  }
	  else
	  {
	    echo "<center>"."No results were found for \"".$query."\""."</center>";
		}
	}
	echo "</body>";
	echo "</html>";
//***********************************************************************



//***********************************************************************
// create header of the HTML result file
//***********************************************************************
function place_header()
{
	?>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<html>
	  <head>
	    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1251">
		<LINK type="text/css" href="rvf.css" rel=STYLESHEET>
		<link rel="icon" href="punthoofd.gif" type="image/gif">
	  </head>
	  <body>
	<?
}
//***********************************************************************





//***********************************************************************
// This function returns:
// 0 = FALSE = unauthorized access to this file
// 1 = not parsable file
// 2 = parsable file
//***********************************************************************
function IsAllowed($f)
{
  global $allowed_names, $disallowed_names;
  for ($i=0; $i<count($disallowed_names); ++$i)
    if (stristr(basename($f), $disallowed_names[$i])) return 0;
  for ($i=0; $i<count($allowed_names); ++$i)
    if (stristr(basename($f), $allowed_names[$i])) return 2;
  return 1;
}
//***********************************************************************



// Does buffer matches the query ?
function FindQuery($buffer)
{
  global $query, $m;
  $t=explode(" ", $query);
   if ($m=="or")
   {
     for ($j=0; $j<count($t); ++$j)
     {
       if (stristr($buffer, $t[$j])) return 1;
       $key=htmlentities($t[$j]);
       if ($key!=$t[$j])
       {
         if (stristr($buffer, $key)) return 1;
       }
     }
     return 0;
   } else
   {
     for ($j=0; $j<count($t); ++$j)
       if (!stristr($buffer, $t[$j]))
       {
         $key=htmlentities($t[$j]);
         if ($key!=$t[$j])
         {
           if (!stristr($buffer, $key)) return 0;
         } else
         {
           return 0;
         }
       }
     return 1;
   }
}

// First pass: we build a list of all files matching the criterions
function countdirs($dirname)
{
  global $filesearch;
  $dir=opendir(".");
  while(($f=readdir($dir))!==false)
  {
    if (is_dir($f))
    {
      if (($f!=".") && ($f!=".."))
      {
        if (IsAllowed($f))
        {
//echo "first: ".$f."<br>";
          chdir($f);
          countdirs($dirname."/".$f);
          chdir("..");
        }
      }
    } else
    {
      $n=IsAllowed($f);
      if ($n)
      {
//echo "second: ".$f."<br>";
        // Does the filename matches the query ?
        if (FindQuery($f))
        {
          $filesearch[] = $dirname.'/'.$f;
        } else
        if ($n==2)
        {
          // Does the content matches the query ?
          $fd=fopen($f,"r");
		  
		  //change for files with sizes zero
		  if (filesize($f)>0)
		  {
		    $buffer=fread($fd, filesize($f));
		  }
		  else
		  {
		    $buffer=null;
		  }
          fclose($fd);
          if (FindQuery($buffer))
          {
            $filesearch[] = $dirname.'/'.$f;
          }
        }
      }
    }
  }
  closedir($dir);
}

// Second pass: we render the file
function Render($dirname, $filenumber)
{
  global $user_dir, $calculated_dir,
         $rootdir, $query, $m, $from, $showed, $pages, $color1, $color2, $explodestring, $maxoccurrences, $desc_header, $desc_footer, $interface_all;
  $f=$rootdir.$dirname;
  ++$showed;
  if ($showed&1)
    echo "<tr><td bgcolor=$color2>";
  else
    echo "<tr><td bgcolor=$color1>";
//  echo str_replace("%1", $filenumber, $interface_all);
  
  $corrected_dirname = str_replace($calculated_dir,$user_dir, $dirname);
  $base_filename = basename($corrected_dirname);
  echo "<a href=\"$corrected_dirname\"> $base_filename</a> ";
  echo "&nbsp;&nbsp;&nbsp;&nbsp;";


  if (IsAllowed($dirname)==2)
  {
//echo "third=2: ".$f."<br>";

    $fc=file($f);
    $filet=join("", $fc);
    if (preg_match("/<title.*>(.*)<\/title.*>/isU", $filet, $match))
    {
      // display the title
      echo trim($match[1]);
    }
    // display the content matches
    $s=implode($fc, $explodestring);
    $s=strip_tags($s);
    $fc=explode($explodestring, $s);
    $q=explode(" ",$query);
    $occurrence=0;
    echo "<br>$desc_header";
    for ($i=0; $i<count($fc); ++$i)
    {
      $occ=0;
      $s=strtolower(strip_tags($fc[$i]));
      for ($j=0; $j<count($q); ++$j)
      {
        if (stristr($s, $q[$j]))
        {
          $s=str_replace($q[$j], "<b>$q[$j]</b>", $s);
          $occ=1;
        }
        else
        {
          $key=htmlentities($q[$j]);
          if (stristr($s, $key))
          {
            $s=str_replace($key, "<b>$key</b>", $s);
            $occ=1;
          }
        }
      }
      if ($occ)
      {
        $occ=0;
        echo "...$s...";
        ++$occurrence;
        if ($occurrence > $maxoccurrences) break;
      }
    }
    echo $desc_footer;
  }
  echo "</td></tr>\n";
}

// Display navigation bar
function DisplayNavbar($all)
{
  global $PHP_SELF;
$PHP_SELF = "search.php";
  global $color0, $pages, $query, $m, $search_separator;
  echo "<tr bgcolor=$color0><td align=center>";
  for ($k=1; $k<=$all; $k+=$pages)
  {
    if ($k!=1) echo $search_separator;
    echo "<a href=search.php?query=".urlencode($query)."&m=$m&from=$k>$k-";
    if ($k+$pages>$all) echo $all; else echo ($k-1+$pages);
    echo "</a>";
  }
  echo "</td></tr>\n";
}

?>
