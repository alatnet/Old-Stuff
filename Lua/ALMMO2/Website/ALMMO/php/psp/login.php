<?php
  include "psp_var.php";

  if ($_GET['usr']==''){
    //die ('Error! No username supplied.');
    die('1');
  }
  if ($_GET['pass']==''){
    //die ('Error! No password supplied.');
    die ('2');
  }

  $username = $_GET['usr'];
  $userpass = md5($_GET['pass']);

  $link = mysql_pconnect($dbhost, $dbusr, $dbpass) or die('Could not connect to mysql: ' . mysql_error());
  mysql_select_db($db) or die('Could not select database');

  $query = "SELECT * FROM $table_login WHERE usr='$username' and pass='$userpass'";
  $result = mysql_query($query) or die('Query 1 failed: ' . mysql_error());
  if (mysql_num_rows($result)!= 1) {
    die('-1');
  } else {
    die('0');
  }
?>