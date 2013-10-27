<?php

$con=mysql_connect("localhost","root","");
mysql_select_db( "new" , $con );

$str=$_GET['q'];

$result = mysql_query("SELECT * FROM suggestions");

while($row = mysql_fetch_array($result))
  {
  echo $row['suggestions'] ;
  }

?>