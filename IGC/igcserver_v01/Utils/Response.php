<?php
/*
 * @author : Sachin R K
 * @date :18-05-2012
 * @copyright: Mobiuso LLC
 */

/*
 * Generic class for response.
 */
class Response
{
	/*
	 * Call Status
	 * In case of success the status will be '1'.
	 * In case of failure the status will be "0".
	 */ 
	public $status;
	public function getStatus()
	{
		return $this->status;
	}
	
	public function setStatus($status)
	{
		$this->status = $status;
	}
	
	
	/*
	 * Instance of Error Class
	 * It will have some values if the status is "0".
	 * It will be a empty structure if the status is "1".
	 */
	public $error;
	public function getError()
	{
		return $this->error;
	}
	
	public function setError(Error $error)
	{
		$this->error = $error;
	}
	
	/*
	 * result returned by "*Manager" methods.
	 * It will be array with some values if the status is "1".
	 * It will be empty array if the status is "0".
	 */
	public $result;
	public function getResult()
	{
		return $this->result;
	}
	
	public function setResult(array $result)
	{
		$this->result = $result;
	}
}

/*
 * 
 */
class Error
{
	public $errorCode;
	public $errorMessage;
	public $trace;
	
	public function getErrorCode()
	{
		return $this->errorCode;
	}
	
	public function setErrorCode($errorCode)
	{
		$this->errorCode = $errorCode;
	}
	
	public function getErrorMessage()
	{
		return $this->errorMessage;
	}
	
	public function setErrorMessage($errorMessage)
	{
		$this->errorMessage = $errorMessage;
	}
	
	public function getTrace()
	{
		return $this->trace;
	}
	
	public function setTrace($trace)
	{
		$this->trace = $trace;
	}
}

?>