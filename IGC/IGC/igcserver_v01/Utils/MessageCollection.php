<?php

class ErrorMessageCollection
{
	public static function getMessage($messageCode)
	{
		switch($messageCode)
		{
			case 100:
				return "User with email Id already exists.";
				break;
			case 101:
				return "Failed to create user.";
				break;
			case 102:
				return "Registration incomplete.Confirmation from user is pending.";
				break;
			case 103:
				return "Invalid user name or password.";
				break;
			case 104:
				return "Invalid email Id.";
				break;
			case 105:
				return "Invalid Request.";
				break;
			case 106:
				return "Operation failed, please try again later.";
				break;
			case 107:
				return "Bookmark creation failed.";
				break;
			case 108:
				return "Comment creation failed.";
				break;
			case 109:
				return "Note creation failed.";
				break;
			case 110:
				return "Subscription creation failed.";
				break;
			default:
				return "";
				break;
		}
	}
}

class SuccessMessageCollection
{
	public static function getMessage($messageCode)
	{
		switch($messageCode)
		{
			case 200:
				return "Thanks! Your membership is activated now.";
				break;
			default:
				return "";
				break;
		}
	}
}
?>