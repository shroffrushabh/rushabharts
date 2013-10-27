<?php

include_once "../Utils/ConnectionFactory.php";
include_once "../Utils/UserManager.php"


$postedJSON = file_get_contents('php://input');

$mySQLConnection = ConnectionFactory::getMySQLConnection();

$JSONPHPObject = json_decode($postedJSON);
	
switch($JSONPHPObject->method)
{
	case "getProductCatalog":
	/* getProductCatalog Request
	{
	"deviceId": "xxxx-yyyy-xxxx-yyyy",
	"method": "getProductCatalog",
	"userName": "xyz@xyz.com",
	"pwd": "",
	"applicationId": "1",
	"params":[]
	}*/
	
	$catalogdata=getCatalog();
	break;
	
	case "getProductCatalogDelta":
	
	$catalogdata=getCatalogDelta($JSONPHPObject->lastSyncTime);
	break;
		
}

	function getCatalog($catalog)
	{
	
	$catalog = $mySQLConnection->executeQuery("CALL getProductCatalog()")
	return $getCatalogData($catalog);
	}
	

function getCatalogDelta($lastSyncTime)
	{
					
	$catalog = $mySQLConnection->executeQuery("CALL getProductCatalogDelta($lastSyncTime)")
	return getCatalogData($catalog)
	}


	
function getCatalogData($catalog)
{
	$allCatalogs=array();
	$num_row=mysql_num_rows($catalog);
	
	//$catalogDetailsMain=new CatalogDetailsMain()
	
	//$catalogDetailsMain->setDeviceId($JSONPHPObject->userName);
	//$catalogDetailsMain->setMethod($JSONPHPObject->pwd);
	//$catalogDetailsMain->setApplicationId($JSONPHPObject->applicationId);

	while($row = mysql_fetch_array($catalog))
	{
	$objCatalogDetails=new CatalogDetails();

	$objCatalogDetails->setProductId($row[0]);
	$objCatalogDetails->setAuthoringOrganization($row[1]);
	$objCatalogDetails->setTitle($row[2]);
	$objCatalogDetails->setisbn($row[3]);
	$objCatalogDetails->setPublishedDate($row[4]);
	$objCatalogDetails->setEndorsedBy($row[5]);
	$objCatalogDetails->setAbstract($row[6]);
	$objCatalogDetails->setShortDescription($row[7]);
	$objCatalogDetails->setSize($row[8]);
	$objCatalogDetails->setType($row[9]);
	$objCatalogDetails->setNameID($row[10]);
	$objCatalogDetails->setpackageName($row[11]);		

	$allCatalogs[] = $objCatalogDetails;
	}
	//$catalogDetailsMain->setParams($allCatalogs);
	
	echo json_encode($allCatalogs);	

	//return $catalogDetailsMain;
	return $allCatalogs
}	
?>