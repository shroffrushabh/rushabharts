<?php
/**
 * CommentManager class used to handle process related to comments .
 *
 * @author Ashutosh D
 * @date 19-05-2012
 * @copyright Mobiuso LLC
 */
include_once '../Utils/CryptoClass.php';
include_once '../Utils/MySQLConnection.php';
include_once '../Utils/ConnectionFactory.php';
include_once './Comment.php';
include_once '../Utils/Configuration.php';
include_once '../Membership/UserDetails.php';
include_once '../Utils/Response.php';
include_once '../CustomExceptions/IGCAppExceptions.php';

class CommentManager {
    
    // Constructor
    public function __construct() {
        ;
    }
    
    /**
	 * Create new Comment and return comment Id.
	 * @param $email
	 * @param $password
	 * @param $applicationId
	 * @param $comments(a object of a Bookmark class with all the 
	 * 					necessary datails set.)
         *  */
    
         function createComment($email,$password,$appId,$comments)
         {
             $userId;
             try{
                    //Validate User
                    $userManager = new UserManager;
                    $result = $userManager->validateUser($appId,$email,$password);
                    $userId = $result[0]['userId'];
                    $mySQLConnection = ConnectionFactory::getMySQLConnection();
                    for($i=0;$i<count($comments);$i++)
                    {
                        $productId = $comments[$i]->getProductId();
                        $commentText = $comments[$i]->getComment();
                        $deviceId = $comments[$i]->getDeviceId();
                        $result = $mySQLConnection->executeQuery("call createComment
								  ('$userId',
                                                                   '$appId',
								   '$productId',
                                                                   '$commentText',
								   '$deviceId'
                                                                )");
                                        
                    }
                    if($result)
                    {
                        // Comment creation successful.
                        $mySQLConnection->close();
                        return $result;
                        
                    }else
                    {
                        //Comment creation failed.
                        $objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(108),108);
                        throw $objIGCAppExec;
                    }
                    
                                    
                }
                catch(IGCAppException $IGCExce)
                {
                    throw $IGCExce;
                }catch(Exception $exec)
                {
                    throw $exec;
                }
         }
         /**
          * Fetches all the comments created by the user.
          * @param $email
          * @param $password
          * @param $appId
          * @return $result 
          */
         function getUserComments($email,$password,$appId)
         {
             try{
                    $userManager = new UserManager;
                    $validateResult = $userManager->validateUser($appId,$email,$password);
                    $userId = $validateResult[0]['userId'];
                    
                    $mySQLConnection= ConnectionFactory::getMySQLConnection();
                    $result = $mySQLConnection->executeQuery("CALL getUserComments
										(									
										'$userId'
										)");	
                    $mySQLConnection->close();
                    return $result;
                      
                 
                }catch(IGCAppException $IGCExce)
                {
                    throw $IGCExce;
                }catch(Exception $exec)
                {
                    throw $exec;
                }
         }
         
         /**
          * Fetches user comments created after last synchronizatoin date.
          * @param $email
          * @param $password
          * @param $appId
          * @param $creationDate
          * @return $result 
          */
         
         function getUserCommentsDelta($email,$password,$appId,$creationDate)
         {
             try{
                    $userManager = new UserManager;
                    $result = $userManager->validateUser($appId,$email,$password);
                    $userId = $result[0]['userId'];
                        
                    $mySQLConnection= ConnectionFactory::getMySQLConnection();
                    $result = $mySQLConnection->executeQuery("CALL getUserCommentsDelta
								(									
                                                                     '$userId',
                                                                     '$creationDate'
								)");	
                    
                      $mySQLConnection->close();
                      return $result;
                }catch(IGCAppException $IGCExce)
                {
                    throw $IGCExce;
                }catch(Exception $exec)
                {
                    throw $exec;
                }
         }
         
         
    
}

?>
