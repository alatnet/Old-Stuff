<?php
  include "psp_var.php";
  
  // Connecting, selecting database
  $link = mysql_pconnect($dbhost, $dbusr, $dbpass) or die('ERROR! Could not connect: ' . mysql_error());
  mysql_select_db($db) or die('ERROR! Could not select database');

  // Performing SQL query
  $query = "SELECT * FROM $table_servers";
  $result = mysql_query($query) or die('ERROR! Query failed: ' . mysql_error());

  // Printing results in Lua
  echo "function load_server_list()\n";
  echo "  NET.servers.sel = {\n";
  while ($line = mysql_fetch_array($result)){
    $name=$line['name'];
    $ip=$line['ip'];
    $port=$line['port'];
    $num_ppl=$line['num_ppl'];
    $max_ppl=$line['max_ppl'];
    $num_games=$line['num_games'];

    echo "    {\n";
    echo "      name=\"".$name."\",\n";
    echo "      IP=\"".$ip."\",\n";
    echo "      port=".$port.",\n";
    echo "      num_ppl=".$num_ppl.",\n";
    echo "      max_ppl=".$max_ppl.",\n";
    echo "      num_games=".$num_games.",\n";
    echo "    },\n";
  }
  echo "  }\n";
  die("end");
?>