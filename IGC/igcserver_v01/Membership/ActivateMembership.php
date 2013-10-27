<?php
/*
 * @author : Sachin R K
 * @date :06-05-2012
 * @copyright: Mobiuso LLC
 */

include_once './UserManager.php';
include_once '../Utils/FileSystemUtils.php';
include_once '../Utils/GlobalExceptionHandler.php';
include_once "../Utils/MessageCollection.php";

/*
 * Once user registers to IGC through a device app, a registration confirmation 
 * mail will be sent to a user. This mail will also consist a registration activation
 * link. This link will have newly created 'userId' and the 'applicationId' in the 
 * query string. Upon clicking on this link this page will be invoked and it will
 * update the 'isApproved' flag in the 'cc_membership' table.
 */

/* 
 * $_GET or $_REQUEST can be used to get the query string.
 */

/*
 * Set Global exceptionhandler.
 * Every Bootstrap/Webservice file will have the line below as the first line of code.
 */

	try 
	{
		  set_exception_handler('GlobalExceptionHandler::handleException');
		
		  $userId = $_GET['uid'];
		  $applicationId = $_GET['aid'];
		  //echo $userId."-".$applicationId;
		  $objUserManager = new UserManager();
		  if ($objUserManager->activateMembership($userId,$applicationId))
		  {
		  	FileSystemUtils::createUserSandbox($userId,$applicationId);
		  	echo SuccessMessageCollection::getMessage(200);
		  }
		  else
		  {
		  	echo ErrorMessageCollection::getMessage(106);
		  }
	}
	catch(Exception $exec)
	{
		echo ErrorMessageCollection::getMessage(106);
	}
  
?>