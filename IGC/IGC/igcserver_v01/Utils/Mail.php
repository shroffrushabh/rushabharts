<?php

class Mail
{
	/*
 	* Utility function to send email
 	* 
 	* @param from
 	* @param to
 	* @param subject
 	* @param message
 	* 
 	* @return <p>retruns true if mail was successfully accepted 
 	* 			for delivery, false otherwise.</p>
 	* 
 	*/
	public static function  sendMail($from,
						$to,
						$cc,
						$bcc,
						$subject,
						$message)
	{
		$headers = "From:" . $from;
	
		if($cc)
		{
			$headers = $headers."\r\n"."cc:".$cc;
		}
	
		if($bcc)
		{
			$headers = $headers."\r\n"."bcc:".$bcc;
		}
		return mail($to,$subject,$message,$headers);
	}
}
?>