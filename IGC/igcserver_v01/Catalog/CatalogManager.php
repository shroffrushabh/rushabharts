<?php
/**
 * CatalogManager class used to handle process related to Catalogs.
 *
 * @author Ashutosh D
 * @date 21-05-2012
 * @copyright Mobiuso LLC
 */
include_once '../Utils/CryptoClass.php';
include_once '../Utils/MySQLConnection.php';
include_once '../Utils/ConnectionFactory.php';
include_once '../Catalog/Catalog.php';
include_once '../Utils/Configuration.php';
include_once '../Membership/UserDetails.php';
include_once '../Utils/Response.php';
include_once '../CustomExceptions/IGCAppExceptions.php';
class CatalogManager {
    
    // Constructor
    public function __construct() {
        ;
    }
    /** **
     * function returns catalog list 
     * 
     * @param type $email
     * @param type $password
     * @param type $appId
     * @return type $result
     */
    function getProductCatalog()
    {
            try{
                    //$userManager = new UserManager;
                    //$validateResult = $userManager->validateUser($appId,$email,$password);
                    $mySQLConnection= ConnectionFactory::getMySQLConnection();
                    $result = $mySQLConnection->executeQuery("Call getProductCatalog ()");
                    
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
    /** **
     *  fuction will returns catalogs list by Delta
     * 
     * @param type $email
     * @param type $password
     * @param type $appId
     * @param type $lastSyncDate
     * @return type $result
     */
    function getProductCatalogDelta($lastSyncDate)
    {
        try{
                //$userManager = new UserManager;
                //$validateResult = $userManager->validateUser($appId,$email,$password);
                $mySQLConnection = ConnectionFactory::getMySQLConnection();
                $result = $mySQLConnection->executeQuery("Call getProductCatalogDelta
                                                         ('$lastSyncDate')");
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
    function getProductsByCategory()
    {
        try{
                //$userManager = new UserManager;
                //$validateResult = $userManager->validateUser($appId,$email,$password);
                $mySQLConnection = ConnectionFactory::getMySQLConnection();
                $result = $mySQLConnection->executeQuery("Call getProductsByCategory()");
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
    function getProductsByProfession()
    {
        try{
                //$userManager = new UserManager;
                //$validateResult = $userManager->validateUser($appId,$email,$password);
                $mySQLConnnection = ConnectionFactory::getMySQLConnection();
                $result = $mySQLConnnection->executeQuery("Call getProductsByProfession()");
                $mySQLConnnection->close();
                return $result;
            
           }catch(IGCAppException $IGCExec)
           {
               throw $IGCExec;
           }catch(Exception $exec)
           {
               throw $exec;
           }
    }
    function getProductsBySpecialty()
    {
        try{
                //$userManager = new UserManager;
                //$validateResult = $userManager->validateUser($appId, $email, $password);
                $mySQLConnection = ConnectionFactory::getMySQLConnection();
                $result = $mySQLConnection->executeQuery("Call getProductsBySpecialty()");
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
    
}

?>
