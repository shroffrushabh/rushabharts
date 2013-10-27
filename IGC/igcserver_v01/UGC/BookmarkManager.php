<?php
/**
 * Bookmark class used to handle process related to bookmarks .
 * @author Ashutosh D
 * @date 19-05-2012
 * @copyright Mobiuso LLC
 */
include_once '../Utils/CryptoClass.php';
include_once '../Utils/MySQLConnection.php';
include_once '../Utils/ConnectionFactory.php';
include_once './Bookmark.php';
include_once '../Utils/Configuration.php';
include_once '../Membership/UserDetails.php';
include_once '../Utils/Response.php';
include_once '../CustomExceptions/IGCAppExceptions.php';

class BookmarkManager
{
	/** Constructor */
	public function __construct()
	{
		
	}

	/**
	 * Create new bookmark and return bookmark Id.
	 * @param $email
	 * @param $password
	 * @param $applicationId
	 * @param bookmarks (a object of a Bookmark class with all the 
	 * 					necessary datails set.)
	 * 
	 *  */
	function createBookmark($email,$password,$applicationId,$bookmarks)
	{
                $userId;
                $mySQLConnection = 0;
		try
		{
                      // Validate user function validateUser
                      $userMangr = new UserManager;
                      $validateResult = $userMangr->validateUser($applicationId,$email,$password);
                      $userId = $validateResult[0]['userId'];
                      $mySQLConnection= ConnectionFactory::getMySQLConnection();
                      for($i=0;$i<count($bookmarks);$i++)
                      {
                            // echo 'The bookmarks are:'.var_dump($bookmarks);
                            $productId = $bookmarks[$i]->getProductId();
                            $pageId = $bookmarks[$i]->getPageId();
                            $fileName = $bookmarks[$i]->getFileName();
                            $description = $bookmarks[$i]->getDescription();
                            $deviceId = $bookmarks[$i]->getDeviceId();
                            $result = $mySQLConnection->executeQuery("call createBookmark
                                                                        ('$userId',
                                                                         '$productId',
									 '$pageId',
									 '$fileName',
									 '$description',
									 '$deviceId'
									)");
                                     
                     }
                     
                     //return $result[0]['bookmarkId'];
                     if($result)
                     {
                         /* Bookmark creation successful,return userId*/
                         $mySQLConnection->close();
                         return $result;
                     }
                     else{
                            //Bookmark creation failed.
                            $objIGCAppExce = new IGCAppException(ErrorMessageCollection::getMessage(107),107);
                            throw $objIGCAppExce;
                         }
          
		}
                catch(IGCAppExceptions $IGCExec)
                {
                    //$mySQLConnection->close();
                    throw $IGCExec;
                }
		catch (Exception $exec) 
		{
                    //$mySQLConnection->close();
                    throw $exec;
		}		
	}
	
	/** 
	 * Fetches all the bookmarks created by the user.
	 * @param $email 
	 * @param $password
	 * @param $applicationId
	 */
	function getUserBookmarks($email,$password,$applicationId)
	{
		try
		{
			$userMangr = new UserManager;
                        $validateResult = $userMangr->validateUser($applicationId,$email,$password);
                        $userId = $validateResult[0]['userId'];
                        $mySQLConnection= ConnectionFactory::getMySQLConnection();
                        $result = $mySQLConnection->executeQuery("CALL getUserBookmarks
										(									
										'$userId'
										)");			
                                 
                         //echo 'The result is:'.var_dump($result);
                         //Return Bookmark Details to user
                        $mySQLConnection->close();
                        return $result;
                          					
		}
                catch(IGCAppExceptions $IGCExec)
                {
                    //$mySQLConnection->close();
                    throw $IGCExec;
                }
		catch (Exception $exec) 
		{
                    //$mySQLConnection->close();
                    throw $exec;
		}		
	}
	
	/**
	 * Fetches user bookmarks created after last synchronizatoin date.
	 * @param $email
	 * @param $password
	 * @param $applicationId
	 * @param $lastSyncDate
	 * */
	function getUserBookmarksDelta($email,$password,$applicationId,$lastSyncDate)
	{
		try
		{
                        $userMangr = new UserManager;
                        $validateResult = $userMangr->validateUser($applicationId,$email,$password);
                        $userId = $validateResult[0]['userId'];
                        // echo 'The user is valid';
                        $mySQLConnection= ConnectionFactory::getMySQLConnection();
                        $result = $mySQLConnection->executeQuery("CALL getUserBookmarksDelta
                                                                                (									
										'$userId',
										'$lastSyncDate'
                                						)");
                      //  $mySQLConnection->close();
                      //  return $result;
                        if($result)
                     {
                            $mySQLConnection->close();
                            return $result;
                     }
                     else{
                            echo 'its not exception';
                        }
                            
		}
                catch(IGCAppExceptions $IGCExce)
                {
                    //$mySQLConnection->close();
                    echo 'its exceptions';
                    throw $IGCExce;
                }
		catch (Exception $exec) 
		{
                    //$mySQLConnection->close();
                    echo'its exceptions1';
                    throw $exec;
		}		
	}
}

?>