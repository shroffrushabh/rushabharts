<?php

/**
 * SubscriptionManager class used to handle process related to subscriptions.
 *
 * @author Ashutosh D
 * @date 29-05-2012
 * @copyright Mobiuso LLC
 */

include_once '../Subscription/Subscription.php';
include_once '../Utils/MySQLConnection.php';
include_once '../Utils/ConnectionFactory.php';
include_once '../Utils/Configuration.php';
include_once '../Utils/Response.php';
include_once '../CustomExceptions/IGCAppExceptions.php';
include_once '../Membership/UserManager.php';

class SubscriptionManager {
    public function __construct() {
        ;
    }
    /**
     * Create new subscription and return subscription Id.
     * @param type $userName
     * @param type $password
     * @param type $appId
     * @param Subscription $subscriptions 
     */
    
    public function createSubscription($userName,$password,$appId,$subscriptions)
    {
        $userId;
        $mySQLConnection = 0;
        try{
                $userManager = new UserManager;
                $validateResult = $userManager->validateUser($appId,$userName,$password);
                $userId = $validateResult[0]['userId'];
                $mySQLConnection= ConnectionFactory::getMySQLConnection();
                for($i=0;$i<count($subscriptions);$i++)
                {
                    //$previousSubscriptionId = $subscriptions->getPreviousSubscriptionId();
                    $preSubscriptionId = is_null($subscriptions[$i]->getPreviousSubscriptionId()) ? "" 
                                : $preSubscriptionId = $subscriptions[$i]->getPreviousSubscriptionId(); 
                    $productId = $subscriptions[$i]->getProductId();
                    $startDate = $subscriptions[$i]->getStartDate();
                    $endDate = $subscriptions[$i]->getEndDate();
                    $type = $subscriptions[$i]->getType();
                    $status = $subscriptions[$i]->getStatus();
                    $result = $mySQLConnection->executeQuery("CALL createSubscription(
                                                            '$userId',
                                                            '$preSubscriptionId',
                                                            '$productId',
                                                            '$startDate',
                                                            '$endDate',
                                                            '$type',
                                                            '$status'
                                                            )");
                }
                if($result){
                    $mySQLConnection->close();
                    return $result;
                }else{
                    $mySQLConnection->close();
                    $objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(110),110);
                    throw $objIGCAppExec;
                }
                
           }catch(IGCAppException $IGCExec)
           {
               throw $IGCExec;
           
           }catch(Exception $Exec)
           {
               throw $Exec;
           
           }
    }
    /**
     * The function will return All User Subscriptions
     * @param type $email
     * @param type $password
     * @param type $appId
     * @return type $result
     */
    public function getUserSubscriptions($email,$password,$appId)
    {
        $userId;
        try{
                $userManager = new UserManager;
                $validateResult = $userManager->validateUser($appId, $email, $password);
                $userId = $validateResult[0]['userId'];
                $mySQLConnection = ConnectionFactory::getMySQLConnection();
                $result = $mySQLConnection->executeQuery("Call getUserSubscriptions(
                                                                          '$userId'  
                                                                          )");
                $mySQLConnection->close();
                return $result;
            
           }catch(IGCAppException $IGCExec)
           {
               throw $IGCExec;
           }catch(Exception $exec)
           {
               throw $exec;
           }
    }
    /**
     * The function will return All User Subscriptions by given Date 
     * @param type $email
     * @param type $password
     * @param type $appId
     * @param type $lastSyncDate
     * @return type $result
     */
    public function getUserSubscriptionsDelta($email,$password,$appId,$lastSyncDate)
    {
        $userId;
        try{
                $userManager = new UserManager;
                $validateResult = $userManager->validateUser($appId, $email, $password);
                $userId = $validateResult[0]['userId'];
                $mySQLConnection = ConnectionFactory::getMySQLConnection();
                $result = $mySQLConnection->executeQuery("Call getUserSubscriptionsDelta(
                                                                          '$userId',
                                                                          '$lastSyncDate'
                                                                          )");
                $mySQLConnection->close();
                return $result;
            
           }catch(IGCAppException $IGCExec)
           {
               throw $IGCExec;
           }catch(Exception $exec)
           {
               throw $exec;
           }
    }
    /**
     * The function will return All Subscriptions Information.
     * @param type $email
     * @param type $password
     * @param type $appId
     * @return type $result
     */
     /*
    public function getAllSubscriptions($email,$password,$appId)
    {
        $userId;
        try{
                $userManager = new UserManager;
                $validateResult = $userManager->validateUser($appId, $email, $password);
                $userId = $validateResult[0]['userId'];
                if($userId)
                {
                    $mySQLConnection = ConnectionFactory::getMySQLConnection();
                    $result = $mySQLConnection->executeQuery("Call getAllProductSubscriptions()");
                    
                    $mySQLConnection->close();
                    return $result;
                }
            
           }catch(IGCAppException $IGCExec)
           {
               throw $IGCExec;
           }catch(Exception $exec)
           {
               throw $exec;
           }
    }*/
     
    /**
     * The function will returns All Subscription Information By date
     * @param type $email
     * @param type $password
     * @param type $appId
     * @param type $lastSyncDate
     * @return type $result
     */
    /*
    public function getAllSubscriptionsDelta($email,$password,$appId,$lastSyncDate)
    {
        $userId;
        try{
                $userManager = new UserManager;
                $validateResult = $userManager->validateUser($appId, $email, $password);
                $userId = $validateResult[0]['userId'];
                if($userId)
                {
                    $mySQLConnection = ConnectionFactory::getMySQLConnection();
                    $result = $mySQLConnection->executeQuery("Call getAllProductSubscriptionsDelta('$lastSyncDate')");
                    $mySQLConnection->close();
                    return $result;
                }
            
           }catch(IGCAppException $IGCExec)
           {
               throw $IGCExec;
           }catch(Exception $exec)
           {
               throw $exec;
           }
        
    }*/
}

?>
