<?php
  if ($_POST['usr']==''){
    echo "Error: No username entered!";
    include "register.php";
    exit();
  }
  if ($_POST['pass']==''){
    echo "Error: No password entered!";
    include "register.php";
    exit();
  }
  if ($pass==$cpass){
    if ($s_num==$s_num2){
      $link = mysql_connect('localhost', 'root', 'online12') or die('Could not connect to mysql: ' . mysql_error());
      mysql_select_db('alatnet') or die('Could not select database');

      $sql = "select * from almmo_login where usr='" . $_POST['usr'] . "'";
      $result = mysql_query($sql);
      if (mysql_num_rows($result) >= 1) {
        echo "Username Already Taken";
        echo "<br>";
        include "register.php";
        exit();
      } else {
        $username = $_POST['usr'];
        $userpass = md5($_POST['pass']);
        $sql = "insert into almmo_login values('$username','$userpass')";
        mysql_query($sql);
        echo "Initial Registration Complete!";
        echo "<br>";
        echo "Continue the registration by loging in to your account in the game.";
      }
    }else if ($s_num==""){
      echo "Error: No Security Number entered.";
      include "register.php";
      exit();
    }else{
      echo "Error: Security Number is incorrect!";
      include "register.php";
      exit();
    }
  }else{
    echo "Error: Passwords do not match!";
    include "register.php";
    exit();
  }
?>