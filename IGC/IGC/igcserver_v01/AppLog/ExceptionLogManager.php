<?php

/**
 * Description of ExceptionLogManager
 *
 * @author Ashutosh D
 * @date 24-05-2012
 * @copyright Mobiuso LLC
 */
include_once '../Utils/ConnectionFactory.php';
include_once '../AppLog/LogRecord.php';

class ExceptionLogManager {
    function __construct() {
        ;
    }
    
    public function createExceptionLog(LogRecord $logRecord)
    {
        //try{
            $mySQLConnection = ConnectionFactory::getMySQLConnection();
            $applicationId = $logRecord->getAppId();
            $applicationId != 0 ? $applicationId : $applicationId = Configuration::APP_ID;
            $createdBy = $logRecord->getCreatedBy();
            //echo 'The user is:'.$createdBy;
            //echo 'Before sql call';
            //$result = $mySQLConnection->executeQuery("CALL cc_getUserIdByEmail('$createdBy',
            //                                                    '$applicationId')");
            
            //$userId = $result[0]['userId'];
            //echo 'After the sql call'.$userId;
            $userId = $logRecord->getCreatedBy();
            $message = (is_null($logRecord->getMessage())) ? " " : $message = $logRecord->getMessage();
            $stackTrace = (is_null($logRecord->getStaceTrace()))? " " : $stackTrace = addslashes($logRecord->getStaceTrace());
            $errorCode = (is_null($logRecord->getErrorCode()))? " ":$errorCode = $logRecord->getErrorCode();
            $source = (is_null($logRecord->getSource()))?" ":$source = $logRecord->getSource();
            $jsonRequest = (is_null($logRecord->getJSONRequest()))?" ":$jsonRequest = $logRecord->getJSONRequest();
            $referrer = (is_null($logRecord->getReferrer()))?" ":$referrer = $logRecord->getReferrer();
            $referrerData = (is_null($logRecord->getReferrerData())) ? " ":$referrerData = $logRecord->getReferrerData();
            $queryStringData = (is_null($logRecord->getQueryStringData()))?" ":$queryStringData = $logRecord->getQueryStringData();
            $type = (is_null($logRecord->getType()))?" ":$type = $logRecord->getType();
            $exceptionType = (is_null($logRecord->getExceptionType()))?" ":$exceptionType = $logRecord->getExceptionType();
            $appLayer = (is_null($logRecord->getAppLayer()))? " " :$appLayer = $logRecord->getAppLayer();
            $deviceId = (is_null($logRecord->getDeviceId()))? " " :$deviceId = $logRecord->getDeviceId();
            $deviceOs = (is_null($logRecord->getDeviceOs())) ? " " :$deviceOs = $logRecord->getDeviceOs();
            $apiVersion = (is_null($logRecord->getApiVersion()))? " " :$apiVersion = $logRecord->getApiVersion();
           // echo 'The result is '.var_dump($logRecord);
            
            
            $mySQLConnection->executeQuery("CALL cc_createLogRecord(
                                                           '$applicationId',
                                                           '$referrer',
                                                           '$referrerData', 
                                                           '$queryStringData',
                                                           '$type',
                                                           '$source',
                                                           '$message',
                                                           '$stackTrace',
                                                           '$appLayer',
                                                           '$exceptionType',
                                                           '$userId',
                                                           '$deviceId',
                                                           '$deviceOs',
                                                           '$errorCode',
                                                           '$apiVersion',
                                                           '$jsonRequest'
                                                           )");
             $mySQLConnection->close();
        
           /*}catch(Exception $exec)
           {
        
           }*/
     }
}

?>
