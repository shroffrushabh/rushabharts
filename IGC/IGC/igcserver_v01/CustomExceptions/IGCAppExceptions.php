<?php
/**
 * 
 * @author sachin
 * @date 
 * @copyright Mobiuso LLC.
 */
class IGCAppException extends Exception
{
	public function __construct($message,$code)
	{
		$this->message = $message;
		$this->code = $code;
	}
}
?>