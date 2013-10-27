<?php
include_once '../AppLog/LogRecord.php';
include_once '../AppLog/ExceptionLogManager.php';
class GlobalExceptionHandler
{
	public static function handleException($exec)
	{
            //print 'The exception is:'.var_dump($exec);
			$JSONPHPObject = $_SESSION['JSONRequestPHPObject'];
            $exceptionManager = new ExceptionLogManager;
            $logRecord = new LogRecord;
            $trace = $exec->getTrace();
            $logRecord->setSource($trace[0]['file']);
            $logRecord->setCreatedBy($JSONPHPObject->userName);
            $logRecord->setMessage($exec->getMessage());
            $logRecord->setStackTrace($exec->getTraceAsString());
            $logRecord->setErrorCode($exec->getCode());
            $logRecord->setAppId($JSONPHPObject->applicationId);
            $logRecord->setJSONRequest(json_encode($JSONPHPObject));
            //$logRecord->setCreatedBy($trace[0]['args'][0]);
            //$logRecord->setAppId($trace[0]['args'][1]);
            //$logRecord->setJSONRequest($trace[0]['args']);
            $exceptionManager->createExceptionLog($logRecord);
            unset($_SESSION['JSONRequestPHPObject']);
	}	
}
?>