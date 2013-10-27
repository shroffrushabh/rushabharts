<?php
/**
 * @author : Sachin R K
 * @date :06-05-2012
 * @copyright: Mobiuso LLC
 */

include_once './UserManager.php';
include_once './UserDetails.php';
include_once '../AppLog/GlobalExceptionHandler.php';
include_once '../Utils/Configuration.php';
include_once '../Utils/Response.php';
include_once '../Utils/MessageCollection.php';

/**
 * Set Global exceptionhandler.
 * Every Bootstrap/Webservice file will have the line below as the first line of code.
 */
set_exception_handler('GlobalExceptionHandler::handleException');

/**
 * Retrieve JSON string
 */
$postedJSON = file_get_contents('php://input');

/**
 * Convert JSON string to PHP object
 */
$JSONPHPObject = json_decode($postedJSON);

/**
 * Invoke appropriate method based on the 'method' attribute value
 */
//switch ("createUser")
//switch ("validateUser")
//switch("changePassword")
switch ($JSONPHPObject->method)
{
	/*{
		"deviceId": "xxxx-yyyy-xxxx-yyyy",
		"method": "createUser",
		"userName": "xyz@xyz.com",
		"pwd": "",
		"applicationId": "1",
		"params":
			[
				{ 
					"firstName": "sachiin",
					"lastName": "kadam" ,
					"passwordQuestion":"pet name" ,
					"passwordAnswer":"sachin",
					"country":"India",
					"city":"Mumbai",
					"zipCode":"400063",
					"specialtyId":"1",
					"professionId":"1"
				}	
			]
	}*/
	case "createUser":
		try 
		{
			$objUserManager = new UserManager();
			$objUserDetails = new UserDetails();
			$objUserDetails->setEmail($JSONPHPObject->userName);
			$objUserDetails->setPassword($JSONPHPObject->pwd);
			$objUserDetails->setApplicationId($JSONPHPObject->applicationId);
			$objUserDetails->setPasswordQuestion($JSONPHPObject->params[0]->passwordQuestion);
			$objUserDetails->setPasswordAnswer($JSONPHPObject->params[0]->passwordAnswer);
			$objUserDetails->setFirstName($JSONPHPObject->params[0]->firstName);
			$objUserDetails->setLastName($JSONPHPObject->params[0]->lastName);
			$objUserDetails->setCity($JSONPHPObject->params[0]->city);
			$objUserDetails->setCountry($JSONPHPObject->params[0]->country);
			$objUserDetails->setZipCode($JSONPHPObject->params[0]->zipCode);
			$objUserDetails->setSpecialtyId($JSONPHPObject->params[0]->specialtyId);
			$objUserDetails->setProfessionId($JSONPHPObject->params[0]->professionId);
			
			/*$objUserDetails->setEmail("temp136@gmail.com");
			$objUserDetails->setPassword("a39ab1bc8f3026658b0dc80ef8230ef2");
			$objUserDetails->setApplicationId("1");
			$objUserDetails->setPasswordQuestion("question");
			$objUserDetails->setPasswordAnswer("answer");
			$objUserDetails->setFirstName("sachin");
			$objUserDetails->setLastName("kadam");
			$objUserDetails->setCity("mumbai");
			$objUserDetails->setCountry("india");
			$objUserDetails->setZipCode("400063");
			$objUserDetails->setSpecialtyId("1");
			$objUserDetails->setProfessionId("1");
			*/
			$result = $objUserManager->createUser($objUserDetails);
			$response = createSuccessResponse($result);
			//echo "Response Dump".var_dump($response);
			echo json_encode($response);
		}
		catch(IGCAppException $IGCExec)
		{
			//echo "IGC Exception Dump".var_dump($IGCExec);
			$response = createFailureResponse($IGCExec);
			//echo "Response Dump".var_dump($response);
			echo json_encode($response);
			//echo json_last_error();
			throw $IGCExec;
		}
		catch(Exception $exec)
		{
			$response = createFailureResponse($exec);
			echo json_encode($response);
			//echo json_last_error();
			throw $exec;
		}
		break;
	case "validateUser":
		/*
		{
			"deviceId": "xxxx-yyyy-xxxx-yyyy",
			"method": "validateUser",
			"userName": "xyz@xyz.com",
			"pwd": "",
			"applicationId": "1",
			"params":[]
		}
		*/
		try 
		{
			$objUserManager = new UserManager();
			$result = $objUserManager->validateUser($JSONPHPObject->applicationId,
									  $JSONPHPObject->userName,
									  $JSONPHPObject->pwd);
			/*$userId = $objUserManager->validateUser("1",
									  "temp136@gmail.com",
									  "a39ab1bc8f3026658b0dc80ef8230ef2");*/
			$response = createSuccessResponse($result);
			//echo "Response Dump".var_dump($response);
			echo json_encode($response);
		}
		catch (IGCAppException $IGCExec)
		{
			//echo "IGC Exception Dump".var_dump($IGCExec);
			$response = createFailureResponse($IGCExec);
			//echo "Response Dump".var_dump($response);
			echo json_encode($response);
			//echo json_last_error();
			throw $IGCExec;
		}
		catch(Exception $exec)
		{
			$response = createFailureResponse($exec);
			echo json_encode($response);
			//echo json_last_error();
			throw $exec;
		}
		break;
	
	case "updateUserProfile":
		/*
		{
			"deviceId": "xxxx-yyyy-xxxx-yyyy",
			"method": "updateUserProfile",
			"userName": "xyz@xyz.com",
			"pwd": "",
			"applicationId": "1",
			"params":
			[
				{ 
					"firstName": "sachiin",
					"lastName": "kadam" ,
					"passwordQuestion":"pet name" ,
					"passwordAnswer":"sachin",
					"country":"India",
					"city":"Mumbai",
					"zipCode":"400063",
					"specialtyId":"1",
					"professionId":"1"
				}	
			]
		}
		*/
		try
		{
			$objUserManager = new UserManager();
			$objUserDetails = new UserDetails();
			$objUserDetails->setEmail($JSONPHPObject->userName);
			$objUserDetails->setPassword($JSONPHPObject->pwd);
			$objUserDetails->setApplicationId($JSONPHPObject->applicationId);
			$objUserDetails->setPasswordQuestion($JSONPHPObject->params[0]->passwordQuestion);
			$objUserDetails->setPasswordAnswer($JSONPHPObject->params[0]->passwordAnswer);
			$objUserDetails->setFirstName($JSONPHPObject->params[0]->firstName);
			$objUserDetails->setLastName($JSONPHPObject->params[0]->lastName);
			$objUserDetails->setCity($JSONPHPObject->params[0]->city);
			$objUserDetails->setCountry($JSONPHPObject->params[0]->country);
			$objUserDetails->setZipCode($JSONPHPObject->params[0]->zipCode);
			$objUserDetails->setSpecialtyId($JSONPHPObject->params[0]->specialtyId);
			$objUserDetails->setProfessionId($JSONPHPObject->params[0]->professionId);		
			$result = $objUserManager->updateUserProfile($objUserDetails);
			$response = createSuccessResponse($result);
			echo json_encode($response);
		}
		catch (IGCAppException $IGCExec)
		{
			$response = createFailureResponse($IGCExec);
			echo json_encode($response);
			//echo json_last_error();
			throw $IGCExec;
		}
		catch(Exception $exec)
		{
			$response = createFailureResponse($exec);
			echo json_encode($response);
			//echo json_last_error();
			throw $exec;
		}
		break;
	case "changePassword":
		/*
		{
			"deviceId": "xxxx-yyyy-xxxx-yyyy",
			"method": "changePassword",
			"userName": "xyz@xyz.com",
			"pwd": "existing pwd",
			"applicationId": "1",
			"params":
			[
				{ 
					"newPwd": "sachiin"
				}	
			]
		}
		*/
		try
		{
			$objUserManager = new UserManager();
			$result = $objUserManager->changePassword($JSONPHPObject->applicationId,
								$JSONPHPObject->userName,
								$JSONPHPObject->pwd,
								$JSONPHPObject->params[0]->newPwd);
			/*$result = $objUserManager->changePassword(1,
								"temp136@gmail.com",
								"a39ab1bc8f3026658b0dc80ef8230ef2",
								"e4b77dd646e412be58473d429e8849d2");*/
			$response = createSuccessResponse($result);
			echo json_encode($response);
		}
		catch (IGCAppException $IGCExec)
		{
			$response = createFailureResponse($IGCExec);
			echo json_encode($response);
			//echo json_last_error();
			throw $IGCExec;
		}
		catch(Exception $exec)
		{
			$response = createFailureResponse($exec);
			echo json_encode($response);
			//echo json_last_error();
			throw $exec;
		}
		break;
	default:
		//echo "Invalid Request";
		$objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(105),105);
		$response = createFailureResponse($objIGCAppExec);
		echo json_encode($response);
		throw $objIGCAppExec;
		break;
}
 
function createFailureResponse($exec)
{
	$response = new Response();
	$response->setStatus(0);
	$objError = new Error();
	$objError->setErrorCode($exec->getCode());
	$objError->setErrorMessage($exec->getMessage());
	$objError->setTrace($exec->getTrace());
	$response->setError($objError);
	$response->setResult(array());
	return $response;
}

function createSuccessResponse($result)
{
	$response = new Response();
	$response->setStatus(1);
	$response->setError(new Error());
	$response->setResult($result);
	return $response;
}
?>
