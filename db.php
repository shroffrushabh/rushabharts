<?php 

$jsonobj= json_decode($_GET['json'],true);

$con = mysql_connect("localhost","root","");
if (!$con)
{
die('Could not connect: ' . mysql_error());
}

mysql_select_db("arts",$con);


if(!filter_var($jsonobj[1], FILTER_VALIDATE_EMAIL))
  {
  exit("Javascript has been disabled on your browser and also the e-mail is not valid");
  }



$sql="insert into orders(name,email,phno,qty,addr,code,comment) values('$jsonobj[0]','$jsonobj[1]','$jsonobj[2]','$jsonobj[3]','$jsonobj[4]','$jsonobj[5]','$jsonobj[6]')";

if (!mysql_query($sql,$con))
  {
  die('Error: ' . mysql_error());
  }
echo "Your order has been placed successfully, you will shortly receive a call from one of our associates.";

mysql_close($con);


?>