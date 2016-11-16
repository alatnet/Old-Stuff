<?php
  include "psp_var.php";
  
  // Connecting, selecting database
  $link = mysql_pconnect($dbhost, $dbusr, $dbpass) or die('ERROR! Could not connect: ' . mysql_error());
  mysql_select_db($db) or die('ERROR! Could not select database');

  // Performing SQL query
  $query = "SELECT * FROM $table_servers";
  $result = mysql_query($query) or die('ERROR! Query failed: ' . mysql_error());
  
  $num_servers = mysql_num_rows($result);

  die($num_servers);
?>