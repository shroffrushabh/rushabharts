<?php


include_once './BookmarkManager.php';
include_once './Bookmark.php';
include_once '../Utils/Configuration.php';
include_once '../AppLog/GlobalExceptionHandler.php';
include_once '../Membership/UserManager.php';
include_once '../UGC/Note.php';
include_once '../UGC/NoteManager.php';
include_once '../CustomExceptions/IGCAppExceptions.php';
include_once '../Utils/Response.php';
include_once './Comment.php';
include_once './CommentManager.php';
include_once '../Catalog/CatalogManager.php';


set_exception_handler('GlobalExceptionHandler::handleException');

/*
 * Get the request
 */

$postedJSON = file_get_contents('php://input');

// FOR Testing multiple parameters 
/*
 * Decode the json request which contains the method and parameters
 */

$JSONObject = json_decode($postedJSON);

/**
 * Store JSON Request in session, for later use. It is globaly accessible
 * so can be used in exception handler to log request context in AppLog table
 */
$_SESSION['JSONRequestPHPObject'] = $JSONObject;


switch ($JSONObject->method) {
            case "addBookmark":
            
                        addBookmark($JSONObject);
            break;
       
            case "getUserBookmarks":
                   
                    getUserBookmarks($JSONObject);
            break;
            
            case "getUserBookmarksDelta":
                        getUserBookmarksDelta($JSONObject);
	
            break;
            
            case  "createNote":
                    createNote($JSONObject);
            break;
        
            case "getUserNotes":
                    getUserNotes($JSONObject);
            break;
        
            case "getUserNotesDelta":
                    getUserNotesDelta($JSONObject);
            break;
        
            case "createComment":
                    createComment($JSONObject);
            break;
        
            case "getUserComments":
                    getUserComments($JSONObject);
            break;
        
            case "getUserCommentsDelta":
                    getUserCommentsDelta($JSONObject);
            break;
        
            case "getProductCatalog":
                    getProductCatalog($JSONObject);
            break;
        
            case "getProductCatalogDelta":
                    getProductCatalogDelta($JSONObject);
            break;
            
            case "getProductsByCategory":
                    getProductsByCategory($JSONObject);
            break;
        
            case "getProductsByProfession":
                    getProductsByProfession($JSONObject);
            break;
            
            case "getProductsBySpecialty":
                    getProductsBySpecialty($JSONObject);
            break;
            
            default:
                    $objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(105),105);
                    //echo "exception".var_dump($objIGCAppExec);
                    $response = createFailureResponse($objIGCAppExec);
                    //echo "response ".var_dump($response);
                    echo json_encode($response);
                    throw $objIGCAppExec;
            break;
    }
/**
 * The function will create new bookmark.
 * @param type $JSONObject 
 */

function addBookmark($JSONObject)
{
	try 
	{
                $bookmarks = array();
                $count = count($JSONObject->params);
                for($i = 0;$i<$count;$i++)
                        {
                            $bookmark = new Bookmark();
                            $bookmark->setProductId($JSONObject->params[$i]->productId);
                            $bookmark->setPageId($JSONObject->params[$i]->pageId);
                            $bookmark->setFileName($JSONObject->params[$i]->fileName);
                            $bookmark->setDescription($JSONObject->params[$i]->description);
                            $bookmark->setDeviceId($JSONObject->deviceId);
                            
                            $bookmarks [$i] = $bookmark;
                            
                        }
                 //echo "The bookmark objects".var_dump($bookmarks);
		//echo 'The param values are:'.var_dump($param);
		/*set bookmark parameters*/
		$userName = $JSONObject->userName;
                $pwd = $JSONObject->pwd;
                $applicationId = $JSONObject->applicationId;
                $bookmarkMgr = new BookmarkManager();
		$result = $bookmarkMgr->createBookmark($userName,$pwd,
							         $applicationId,
					                         $bookmarks);
                $response = createSuccessResponse($result);
                echo json_encode($response);
               
	}catch(IGCAppException $IGCExce)
        {
            $response = createFailureResponse($IGCExce);
            echo json_encode($response);
            throw $IGCExce;
        }
	catch (Exception $exec) 
	{
            $response = createFailureResponse($exec);
            echo json_encode($response);
            throw $exec;
	}
}
/**
 * The function will returns all bookmarks of User.
 * @param type $JSONObject 
 */
function getUserBookmarks($JSONObject)
{
    try{
            
            $bookmarkMgr = new BookmarkManager();
            $result = $bookmarkMgr->getUserBookmarks($JSONObject->userName,
                                                     $JSONObject->pwd,
                                                     $JSONObject->applicationId);
            $response = createSuccessResponse($result);
            echo json_encode($response);
       }
       catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }
       catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}

/**
 * The function will returns user bookmarks by date.
 * @param type $JSONObject 
 */

function getUserBookmarksDelta($JSONObject)
{
        try
        {
            $bookmarkMgr = new BookmarkManager;
            $result = $bookmarkMgr->getUserBookmarksDelta($JSONObject->userName, 
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
        }
        catch(Exception $exec)
        {
            $response = createFailureResponse($exec);
            echo json_encode($response);
            throw $exec;
        }
}

/**
 * The function will create new note.
 * @param type $JSONObject 
 */

function createNote($JSONObject)
{
    try{
                $notes = array();
                $count = count($JSONObject->params);
                for($i = 0;$i<$count;$i++)
                        {
                            $note = new Note();
                            $note->setProductId($JSONObject->params[$i]->productId);
                            $note->setPageId($JSONObject->params[$i]->pageId);
                            $note->setNoteText($JSONObject->params[$i]->noteText);
                            $note->setDeviceId($JSONObject->deviceId);
                            $notes [$i] = $note;
                            
                        }
            $noteManager = new NoteManager;        
            $result = array();
            $userName = $JSONObject->userName;
            $pwd = $JSONObject->pwd;
            $applicationId =$JSONObject->applicationId;
            $result = $noteManager->createNote($userName,$pwd,$applicationId,$notes);
            //var_dump($result);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }
       catch(Exception $exec)
       {
          $response = createFailureResponse($exec);
          echo json_encode($response);
          throw $exec;
       }
}
/**
 * The function will returns all notes by user.
 * @param type $JSONObject 
 */
function getUserNotes($JSONObject)
{
    try{
            $noteManager = new NoteManager();
            $result = array();
            $result = $noteManager->getUserNotes($JSONObject->userName, 
                                                 $JSONObject->pwd, 
                                                 $JSONObject->applicationId);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }
       
       catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}
/**
 * The function will returns user notes by date.
 * @param type $JSONObject 
 */

function getUserNotesDelta($JSONObject)
{
    try{
            $noteManager = new NoteManager();
            $result = $noteManager->getUserNotesDelta($JSONObject->userName,
                                                      $JSONObject->pwd,
                                                      $JSONObject->applicationId,
                                                      $JSONObject->params[0]->lastSyncDate);
            $response = createSuccessResponse($result);
            echo json_encode($response);
            
       }catch(IGCAppException $IGCExce)
       {
           $response = createFailureResponse($IGCExce);
           echo json_encode($response);
           throw $IGCExce;
       }
       catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}

/**
 * The function will create new comments.
 * @param type $JSONObject 
 */
function createComment($JSONObject)
{
    
    try{
          $comments = array();
          $count = count($JSONObject->params);
          for($i = 0;$i<$count;$i++)
          {
          		$comment = new Comment();
                            $comment->setProductId($JSONObject->params[$i]->productId);
                            $comment->setComment($JSONObject->params[$i]->commentText);
                            $comment->setDeviceId($JSONObject->deviceId);
                            $comments[$i] = $comment;
                            
            }
            $commentManager = new CommentManager;        
            $userName = $JSONObject->userName;
            $pwd = $JSONObject->pwd;
            $applicationId = $JSONObject->applicationId;
            $result = $commentManager->createComment($userName,$pwd,$applicationId,$comments);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }
       catch(Exception $exec)
       {
          $response = createFailureResponse($exec);
          echo json_encode($response);
          throw $exec;
       }
}
/**
 * The function will returns all comments by User.
 * @param type $JSONObject 
 */

function getUserComments($JSONObject)
{
    try{
            $commentManager = new CommentManager();
            $result = array();
            $result = $commentManager->getUserComments($JSONObject->userName, 
                                                       $JSONObject->pwd, 
                                                       $JSONObject->applicationId);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }
       
       catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}

/**
 * The function will retuens user comments by date.
 * @param type $JSONObject 
 */
function getUserCommentsDelta($JSONObject)
{
    try{
            
            $commentManager = new CommentManager();
            
            $result = $commentManager->getUserCommentsDelta($JSONObject->userName, 
                                                            $JSONObject->pwd, 
                                                            $JSONObject->applicationId,
                                                            $JSONObject->params[0]->creationDate);
            $response = createSuccessResponse($result);
            echo json_encode($response);
        
       }catch(IGCAppException $IGCExec)
       {
           $response = createFailureResponse($IGCExec);
           echo json_encode($response);
           throw $IGCExec;
       }
       
       catch(Exception $exec)
       {
           $response = createFailureResponse($exec);
           echo json_encode($response);
           throw $exec;
       }
}

/**
 * The function will returns list of catalogs.
 * @param type $JSONObject 
 */
function getProductCatalog($JSONObject)
{
    try{
            $catalogManager = new CatalogManager;
            $result = $catalogManager->getProductCatalog($JSONObject->userName,
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
 * The function will returns list of catalogs by date.
 * @param type $JSONObject 
 */
function getProductCatalogDelta($JSONObject)
{
    try{
            $catalogManager = new CatalogManager;
            $result = $catalogManager->getProductCatalogDelta($JSONObject->userName,
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

 function getProductsByCategory($JSONObject)
 {
     try{
            $catalogManager = new CatalogManager;
            $result = array();
            $result = $catalogManager->getProductsByCategory($JSONObject->userName,
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
            $reponse = createFailureResponse($exec);
            echo json_encode($response);
            throw $exec;
        }
 }
 function getProductsByProfession($JSONObject)
 {
     try{
            $catalogManager  = new CatalogManager;
            $result = $catalogManager->getProductsByProfession($JSONObject->userName,
                                                               $JSONObject->pwd,
                                                               $JSONObject->applicationId);
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
 function getProductsBySpecialty($JSONObject)
 {
     try{
            $catalogManager = new CatalogManager;
            $result = $catalogManager->getProductsBySpecialty($JSONObject->userName,
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