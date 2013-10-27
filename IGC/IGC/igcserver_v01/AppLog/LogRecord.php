<?php

/**
 * Description of AppLogs
 *
 * @author Ashutosh D
 * @date 24-05-2012
 * @copyright Mobiuso LLC
 */
class LogRecord{
    
    private $_appId;
    private $_referrer;
    private $_referrerData;
    private $_queryStringData;
    private $_source;
    private $_exceptionType;
    private $_appLayer;
    private $_createdBy;
    private $_deviceId;
    private $_deviceOs;
    private $_apiVersion;
    private $_jsonRequest;
    private $_message;
    private $_stackTrace;
    private $_errorCode;
    private $_type;
    
    
    
    public function setAppId($appId)
    {
        $this->_appId = $appId;
    }
    public function getAppId()
    {
        return $this->_appId;
    }
    public function setReferrer($referrer)
    {
        $this->_referrer = $referrer;
    }
    public function getReferrer()
    {
        return $this->_referrer;
    }
    public function setReferrerData($referrerDara)
    {
        $this->_referrerData = $referrerDara;
    }
    public function getReferrerData()
    {
        return $this->_referrerData;
    }
    public function setQueryStringData($queryStringData)
    {
        $this->_queryStringData = $queryStringData;
    }
    public function getQueryStringData()
    {
        return $this->_queryStringData;
    }
    public function setSource($source)
    {
        $this->_source = $source;
    }
    public function getSource()
    {
        return $this->_source;
    }
    public function setExceptionType($exceptionType)
    {
        $this->_exceptionType = $exceptionType;
    }
    public function getExceptionType()
    {
        return $this->_exceptionType;
    }
    public function setAppLayer($appLayer)
    {
        $this->_appLayer = $appLayer;
    }
    public function getAppLayer()
    {
        return $this->_appLayer;
    }
    public function setCreatedBy($createdBy)
    {
        $this->_createdBy = $createdBy;
    }
    public function getCreatedBy()
    {
        return $this->_createdBy;
    }
    public function setDeviceId($deviceId)
    {
        $this->_deviceId = $deviceid;
    }
    public function getDeviceId()
    {
        return $this->_deviceId;
    }
    public function setDeviceOs($deviceOs)
    {
        $this->_deviceOs = $deviceOs;
    }
    public function getDeviceOs()
    {
        return $this->_deviceOs;
    }
    public function setApiVersion($apiVersion)
    {
        $this->_apiVersion = $apiVersion;
    }
    public function getApiVersion()
    {
        return $this->_apiVersion;
    }
    public function setJSONRequest($jsonRequest)
    {
        $this->_jsonRequest = $jsonRequest;
    }
    public function getJSONRequest()
    {
        return $this->_jsonRequest;
    }
    public function setMessage($message)
    {
        $this->_message = $message;
    }
    public function getMessage()
    {
        return $this->_message; 
    }
    public function setStackTrace($stackTrace)
    {
        $this->_stackTrace = $stackTrace;
    }
    public function getStaceTrace()
    {
        return $this->_stackTrace;
    }
    public function setErrorCode($errorCode)
    {
        $this->_errorCode = $errorCode;
    }
    public function getErrorCode()
    {
        return $this->_errorCode;
    }
    public function setType($type)
    {
        $this->_type = $type;
    }
    public function getType()
    {
        return $this->_type;
    }
    
}

?>
