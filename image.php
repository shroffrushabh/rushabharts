<?php
session_start();

$img = imagecreatetruecolor(150,70);

$white = imagecolorallocate($img, 255, 255, 255);
$black = imagecolorallocate($img, 0, 0, 0);
$grey = imagecolorallocate($img,150,150,150);
$red = imagecolorallocate($img, 255, 0, 0);
$pink = imagecolorallocate($img, 200, 0, 150);
echo 1;
function randomString($length){
    $chars = "abcdefghijkmnopqrstuvwxyz023456789";
    $str = "";
    $i = 0;
    
        while($i <= $length){
            $num = rand() % 33;
            $tmp = substr($chars, $num, 1);
            $str = $str . $tmp;
            $i++;
        }
    return $str;
}
echo 1;
for($i=1;$i<=rand(1,5);$i++){
    $color = (rand(1,2) == 1) ? $pink : $red;
    imageline($img,rand(0,150),rand(0,150), rand(15,70)+5,rand(15,50)+5, $color);
}
echo 1;
imagefill($img, 0, 0, $white);
echo 1;
$string = randomString(rand(7,8));
$_SESSION['string'] = $string;
echo 1;
imagettftext($img, 15, 0, 10, 50, $black, "JC.ttf", $string);

$_SESSION['secret_string'] = $string;

header("Content-type: image/png");
imagepng($img);
imagedestroy($img);

?>