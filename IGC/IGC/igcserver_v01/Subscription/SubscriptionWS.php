<?php
/**
 * @author Ashutosh D
 * @date 29-05-2012
 * @copyright Mobiuso LLc
 */

include_once '../Subscription/Subscription.php';
include_once '../Subscription/SubscriptionManager.php';
include_once '../Utils/Configuration.php';
include_once '../Utils/Response.php';
include_once '../CustomExceptions/IGCAppExceptions.php';
include_once '../AppLog/GlobalExceptionHandler.php';

set_exception_handler('GlobalExceptionHandler::handleException');
/*
 * Get the Request
 */
$postedJSON = file_get_contents('php://input');



/*
 * Decode the json request which contains the method and parameters
 */
$JSONObject = json_decode($postedJSON);

/**
 * Store JSON Request in session, for later use. It is globaly accessible
 * so can be used in exception handler to log request context in AppLog table
 */
$_SESSION['JSONRequestPHPObject'] = $JSONObject;

switch($JSONObject->method){
    case "createSubscription":
        createSubscription($JSONObject);
    break;
    case "getUserSubscriptions":
        getUserSubscriptions($JSONObject);
    break;
    case "getUserSubscriptionsDelta":
        getUserSubscriptionsDelta($JSONObject);
    break;
    case "getAllSubscriptions":
          getAllSubscriptions($JSONObject);
    break;
    case "getAllSubscriptionsDelta":
          getAllSubscriptionsDelta($JSONObject);
    break;
    default :$objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(105),105);
                    //echo "exception".var_dump($objIGCAppExec);
                    $response = createFailureResponse($objIGCAppExec);
                    //echo "response ".var_dump($response);
                    echo json_encode($response);
                    throw $objIGCAppExec;
            break;
}
/**
 * The function will create Subscription for user.
 * @param type $JSONObject 
 */

function createSubscription($JSONObject)
{
    try{
        $subscriptions = array();
        $count = count($JSONObject->params);
        for($i = 0;$i<$count;$i++)
          {
          		$subscription = new Subscription();
                        $subscription->setProductId($JSONObject->params[$i]->productId);
                        $subscription->setStartDate($JSONObject->params[$i]->startDate);
                        $subscription->setEndDate($JSONObject->params[$i]->endDate);
                        $subscription->setPreviousSubscriptionId($JSONObject->params[$i]->preSubscriptionId);
                        $subscription->setType($JSONObject->params[$i]->type);
                        $subscription->setStatus($JSONObject->params[$i]->status);
                        $subscriptions[$i] = $subscription;
                            
            }
            $subscriptionManager = new SubscriptionManager;
            $userName = $JSONObject->userName;
            $password = $JSONObject->pwd;
            $appId = $JSONObject->applicationId;
            $result = $subscriptionManager->createSubscription($userName,$password,$appId,$subscriptions);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}
/**
 * The function will returns Subscription information of particular User.
 * @param type $JSONObject 
 */
function getUserSubscriptions($JSONObject)
{
    try{
            $subscriptionManager = new SubscriptionManager;
            $result = array();
            $result = $subscriptionManager->getUserSubscriptions($JSONObject->userName, 
                                                       $JSONObject->pwd, 
                                                       $JSONObject->applicationId);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
           
       }catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
           
       }
}
/**
 * The function will return user subscription information by date.
 * @param type $JSONObject 
 */
function getUserSubscriptionsDelta($JSONObject)
{
    try{
            $subscriptionManager = new SubscriptionManager;
            $result = array();
            $result = $subscriptionManager->getUserSubscriptionsDelta($JSONObject->userName,
                                                                      $JSONObject->pwd,
                                                                      $JSONObject->applicationId,
                                                                      $JSONObject->params[0]->lastSyncDate);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}
/**
 * The function will return all subscription informations.
 * @param type $JSONObject 
 */
function getAllSubscriptions($JSONObject)
{
    try{    
            $subscriptionManager = new SubscriptionManager;
            $result = array();
            $result = $subscriptionManager->getAllSubscriptions($JSONObject->userName,
                                                                $JSONObject->pwd,
                                                                $JSONObject->applicationId
                                                                );
            $response = createSuccessResponse($result);
            echo json_encode($response);
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}
/**
 * The function will return all subscription information by date.
 * @param type $JSONObject 
 */
function getAllSubscriptionsDelta($JSONObject)
{
    try{
            $subscriptionManager = new SubscriptionManager;
            $result = array();
            $result = $subscriptionManager->getAllSubscriptionsDelta($JSONObject->userName,
                                                                     $JSONObject->pwd,
                                                                     $JSONObject->applicationId,
                                                                     $JSONObject->params[0]->lastSyncDate);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}
/**
 * The function will generate Failure response.
 * @param type $exec
 * @return Response 
 */
function createFailureResponse($exec)
{
    $response = new Response;
    $response->setStatus(0);
    $objError = new Error;
    $objError->setErrorCode($exec->getCode());
    $objError->setErrorMessage($exec->getMessage());
    $objError->setTrace($exec->getTrace());
    $response->setError($objError);
    $response->setResult(array());
    return $response;
}
/**
 * The function will generate Success response.
 * @param type $result
 * @return Response 
 */
function createSuccessResponse($result)
{
    $response = new Response;
    $response->setStatus(1);
    $response->setError(new Error());
    $response->setResult($result);
    return $response;
}
?>
