<?php
session_start();
if(($_GET['code']) != $_SESSION['secret_string'])
{
  echo '0';  
} else {
  echo '1';  
}
?>
