<?php
	function make_seed(){
		list($usec, $sec) = explode(' ', microtime());
		return (float) $sec + ((float) $usec * 100000);
	}

	srand(make_seed());
	$snum1=rand(0,9);
	$snum2=rand(0,9);
	$snum3=rand(0,9);
	$snum4=rand(0,9);
	$snum5=rand(0,9);

	echo "<form method=post action=register2.php>";
	echo "Disired Username: <input type=text name=usr value=$usr>";
	echo "<br>";
	echo "Disired Password: <input type=password name=pass value=$pass>";
	echo "<br>";
	echo "Confirm Password: <input type=password name=cpass value=$cpass>";
	echo "<br>";
	
	echo "<br>";
	echo "<img src='../pic/Numbers/".$snum1.".png'><img src='../pic/Numbers/".$snum2.".png'><img src='../pic/Numbers/".$snum3.".png'><img src='../pic/Numbers/".$snum4.".png'><img src='../pic/Numbers/".$snum5.".png'>";
	echo "<br>";
	echo "Please type in the security number above:";
	echo "<br>";
	echo "<input type=text name=s_num value=$s_num>";
	echo "<br>";

	$s_num2=($snum1*10000)+($snum2*1000)+($snum3*100)+($snum4*10)+($snum5);

	echo "<input type=hidden name=s_num2 value=".$s_num2.">";
	echo "<input type=submit value='REGISTER'>";
	echo "</form>";
?>