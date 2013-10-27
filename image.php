<?php
echo 1
$img = imagecreatetruecolor(150,70);
$white = imagecolorallocate($img, 255, 255, 255);
$black = imagecolorallocate($img, 0, 0, 0);
$grey = imagecolorallocate($img,150,150,150);
$red = imagecolorallocate($img, 255, 0, 0);
$pink = imagecolorallocate($img, 200, 0, 150);
echo 2
function randomString($length){
    $chars = "abcdefghijklmnopqrstuvwxyz023456789";
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
echo 3
for($i=1;$i<=rand(1,5);$i++){
    $color = (rand(1,2) == 1) ? $pink : $red;
    imageline($img,rand(0,150),rand(0,150), rand(15,70)+5,rand(15,50)+5, $color);
}
echo 4
imagefill($img, 0, 0, $white);
$string = randomString(rand(7,8));
imagettftext($img, 15, 0, 10, 50, $black, "JC.ttf", $string);

echo 4

header("Content-type: image/png");
imagepng($img);
imagedestroy($img);
echo 5
?>