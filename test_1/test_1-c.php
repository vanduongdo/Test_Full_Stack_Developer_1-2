<?php
$html = file_get_contents("./content.html");

//Create a new DOMDocument object
$dom = new DOMDocument();
//Load HTML
$dom->loadHTML($html);

//Create a new DOMXPath object
$xp = new DOMXPath($dom);

//Find all items in the list
$items = $xp->query("//ul/li[@class='item']");

$result = array();

foreach ($items as $item) {
    $data = array();
    $data['image'] = $xp->query("./div[@class='image']/img/@src", $item)->item(0)->nodeValue;
    $data['href'] = $xp->query("./div[@class='bike-name']/a/@href", $item)->item(0)->nodeValue;
    $data['bike_name'] = $xp->query("./div[@class='bike-name']/a", $item)->item(0)->nodeValue;
    $data['seller_name'] = mb_convert_encoding(strtok($xp->query("./div[@class='seller-info']/div[@class='name']", $item)[0]->nodeValue, '.'), 'ISO-8859-1', 'UTF-8'); 
    $data['tel'] = $xp->query("./div[@class='seller-info']/div[@class='name']/span", $item)[0]->nodeValue;
    $data['model'] = $xp->query("./div[@class='bike-info']/table/tbody/tr[1]/td[2]", $item)[0]->nodeValue;
    $data['year'] = $xp->query("./div[@class='bike-info']/table/tbody/tr[2]/td[2]", $item)[0]->nodeValue;
    $data['displacement'] = $xp->query("./div[@class='bike-info']/table/tbody/tr[3]/td[2]", $item)[0]->nodeValue;
    $result[] = $data;
}

print_r($result);
?>
