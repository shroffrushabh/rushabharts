<?php

/**
 * 
 * NoteManager class used to handle process related to notes.
 *
 * @author Ashutosh D
 * @date 19-05-2012
 */
include_once '../Utils/CryptoClass.php';
include_once '../Utils/MySQLConnection.php';
include_once '../Utils/ConnectionFactory.php';
include_once '../Utils/Configuration.php';
include_once '../UGC/Note.php';


class NoteManager {
 
    public function __construct() {
        
    }
    
    /**
	 * Create new note and return noteId.
	 * @param $email
	 * @param $password
	 * @param $applicationId
	 * @param $notes (a object of a note class with all the 
	 * 					necessary datails set.)
	 *  */
    
        function createNote($email,$password,$appId,$notes)
         {
             $userId;
             try{
                    //Validate User 
                    $userMangr = new UserManager;
                    $validateResult = $userMangr->validateUser($appId,$email,$password);
                    $userId = $validateResult[0]['userId'];
                    
                    $mySQLConnection= ConnectionFactory::getMySQLConnection();
                    for($i=0;$i<count($notes);$i++)
                    {
                            //echo 'The resultnote is :'.var_dump($notes);
                            $productId = $notes[$i]->getProductId();
                            $noteText = $notes[$i]->getNoteText();
                            $pageId = $notes[$i]->getPageId();
                            $deviceId = $notes[$i]->getDeviceId();
                            $result = $mySQLConnection->executeQuery("call createNote
										(
                                                                                '$userId',
										'$productId',
                                                                                '$noteText',
										'$pageId',
                                                                                '$deviceId'
										 
										)");
                        
                    }
                    if($result)
                    {
                        // Comment created successfully.
                        $mySQLConnection->close();
                        return $result;
                        
                    }else
                    {
                        // Note creation failed.
                        $objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(109),109);
                        throw $objIGCAppExec;
                    }
                    
                }catch(IGCAppException $IGCExec)
                {
                    throw $IGCExec;
                }
                catch(Exception $exec){
                    throw $exec;
                }
         }
         
         /**
	 * Fetches all the notes created by the user.
	 * @param $email
	 * @param $password
	 * @param $applicationId
	 *
	 *  */
         
         function getUserNotes($email,$password,$appId)
         {
             try{
                    $userManager = new UserManager;
                    $validateResult = $userManager->validateUser($appId,$email,$password);
                    $userId = $validateResult[0]['userId'];
                    
                    //echo 'The user is valid';
                    $mySQLConnection = ConnectionFactory::getMySQLConnection();
                    $result = $mySQLConnection->executeQuery("Call getUserNotes(
                                                                          '$userId'  
                                                                          )");
                    $mySQLConnection->close();        
                    return $result;
                
                }catch(IGCAppException $IGCExec)
                {
                    throw $IGCExec;
                }
                catch(Exception $exec)
                {
                    throw $exec;
                }
         }
         
         /**
	 * Fetches all the notes by last Syncronize date.
	 * @param $email
	 * @param $password
	 * @param $applicationId
	 * @param $lastSyncDate
	 *  */
         public function getUserNotesDelta($email,$password,$appId,$lastSyncDate)
         {
             try{
                    $userManager = new UserManager;
                    $validateResult = $userManager->validateUser($appId,$email,$password);
                    $userId = $validateResult[0]['userId'];
                   
                    $mySQLConnection = ConnectionFactory::getMySQLConnection();
                    $result = $mySQLConnection->executeQuery("Call getUserNotesDelta(
                                                                          '$userId',  
                                                                          '$lastSyncDate')");
                    $mySQLConnection->close();
                    return $result;
                 
                }catch(IGCAppException $IGCExec)
                {
                    throw $IGCExec;
                }
                catch(Exception $exec)
                {
                    throw $exec;
                }
         }
    
}

?>
