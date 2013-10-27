<?php

/**
 * @author : Ashutosh D
 * @date : 01-06-2012
 */
include_once '../Catalog/Catalog.php';
include_once '../Catalog/CatalogManager.php';
include_once '../Utils/Configuration.php';
include_once '../Utils/Response.php';
include_once '../AppLog/ExceptionLogManager.php';
include_once '../CustomExceptions/IGCAppExceptions.php';
include_once '../AppLog/GlobalExceptionHandler.php';
//include_once '../Membership/UserManager.php';


set_exception_handler('GlobalExceptionHandler::handleException');

// Get the request
$postedJSON = file_get_contents('php://input');

//Decoding JSON Request which contains the method and parameters.
$JSONObject = json_decode($postedJSON);

/**
 * Store JSON Request in session, for later use. It is globaly accessible
 * so can be used in exception handler to log request context in AppLog table
 */
$_SESSION['JSONRequestPHPObject'] = $JSONObject;


switch($JSONObject->method)
{
    case  "getProductCatalog":
            getProductCatalog();
    break;
    
    case "getProductCatalogDelta":
            getProductCatalogDelta($JSONObject);
    break;

    case "getProductsByCategory":
            getProductsByCategory();
    break;
        
    case "getProductsByProfession":
            getProductsByCategory();
    break;

    case "getProductsBySpecialty":
            getProductsBySpecialty();
    break;

    default:
            $objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(105),105);
            $response = createFailureResponse($objIGCAppExec);
            echo json_encode($response);
            throw $objIGCAppExec;
    break;
}


/**
 * The function will returns list of catalogs.
 * @param type $JSONObject 
 */
function getProductCatalog()
{
    try{
            $catalogManager = new CatalogManager;
            $result = $catalogManager->getProductCatalog();
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
 * The function will returns list of catalogs by date.
 * @param type $JSONObject 
 */
function getProductCatalogDelta($JSONObject)
{
    try{
            $catalogManager = new CatalogManager;
            $result = $catalogManager->getProductCatalogDelta($JSONObject->params[0]->lastSyncDate);
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

 function getProductsByCategory()
 {
     try{
            $catalogManager = new CatalogManager;
            $result = array();
            $result = $catalogManager->getProductsByCategory();
            $response = createSuccessResponse($result);
            echo json_encode($response);
         
        }catch(IGCAppException $IGCExec)
        {
            $response = createFailureResponse($IGCExec);
            echo json_encode($response);
            throw $IGCExec;
        }catch(Exception $exec)
        {
            $reponse = createFailureResponse($exec);
            echo json_encode($response);
            throw $exec;
        }
 }
 function getProductsByProfession()
 {
     try{
            $catalogManager  = new CatalogManager;
            $result = $catalogManager->getProductsByProfession();
            $response = createSuccessResponse($result);
            echo json_encode($response);
         
        }catch(IGCAppException $IGCExec)
        {
            $reponse = createFailureResponse($IGCExec);
            echo json_encode($reponse);
            throw $IGCExec;
        }catch(Exception $exec)
        {
            $repsonse = createFailureResponse($exec);
            echo json_encode($response);
            throw $exec;
        }
 }
 function getProductsBySpecialty()
 {
     try{
            $catalogManager = new CatalogManager;
            $result = $catalogManager->getProductsBySpecialty();
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
