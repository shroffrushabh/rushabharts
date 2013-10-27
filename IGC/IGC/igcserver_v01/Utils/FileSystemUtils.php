<?php
include_once "Configuration.php";

 class FileSystemUtils
 {
 	public static function createUserSandbox($userId,$appId)
 	{
 		$sandboxroot = Configuration::SANDBOX_ROOT;
 		$userFolderName = $userId."_".$appId;
 		$userDirPath = addslashes("../".$sandboxroot."/".$userFolderName);
 		//echo "dir path " .$userDirPath;
 		return mkdir($userDirPath);
 	}
 }