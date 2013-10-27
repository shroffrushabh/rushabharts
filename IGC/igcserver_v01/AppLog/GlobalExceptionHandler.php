<?php
include_once '../AppLog/LogRecord.php';
include_once '../AppLog/ExceptionLogManager.php';
class GlobalExceptionHandler
{
	public static function handleException($exec)
	{
	
            //print 'The exception is:'.var_dump($exec);
            $exceptionManager = new ExceptionLogManager;
            $logRecord = new LogRecord;
            $trace = $exec->getTrace();
            $logRecord->setSource($trace[0]['file']);
            
            $logRecord->setCreatedBy($trace[0]['args'][0]);
            $logRecord->setMessage($exec->getMessage());
            $logRecord->setStackTrace($exec->getTraceAsString());
            $logRecord->setErrorCode($exec->getCode());
            $logRecord->setAppId($trace[0]['args'][1]);
            //$logRecord->setJSONRequest($trace[0]['args']);
            $exceptionManager->createExceptionLog($logRecord);
            
	}	
}
?>