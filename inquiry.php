<?php
$code= array(
"diary"=>array("dr1","dr2","dr3","dr4"),

"pen"=>array("pen1"),

"rang"=>array("r1","r2","r3","r4","r5","r6","r7","r8","r9","r10","r11"),

"pooja"=>array("p1","p2","p3","p4","p5","p6","p7","p8","p9"),

"diya"=>array("dy1","dy2","dy3","dy4","dy5"),

"other"=>array("other1","other2"),

"env"=>array("env1","env2","env3","env4"),

"floating"=>array("f1","f2","f3")

);
//echo "Yo";
//$prod=json_decode($_POST['jsonStr'],true);

//echo "Hello".$_POST['prod'];


if(isset( $_POST['prod'])){
$prod=$_POST['prod'];
if(isset($code[$prod]))
{
	for($i = count($code[$prod]) -1  ; $i>=0  ; $i--)
	{
		echo "<option value='".$code[$prod][$i]."'>".$code[$prod][$i]."</option>";
		
	}
	
}
}

?>