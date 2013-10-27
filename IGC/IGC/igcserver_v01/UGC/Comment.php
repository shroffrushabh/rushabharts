<?php
/**
 * This class encapsulates comment details.
 *
 * @author Ashutosh D
 * @date 19-05-2012
 * @copyright Mobiuso LLC
 */
class Comment {
    
    
    private $_productId;
    private $_creationDate;
    private $_comment;
    private $_deviceId;
    private $_isActive;
    private $_modificationDate;
    
    
    public function setProductId($productId)
    {
        $this->_productId = $productId;
    }
    public function getProductId()
    {
        return $this->_productId;
    }
    public function setCreationDate($creationDate)
    {
        $this->_creationDate = $creationDate;
    }
    public function getCreationDate()
    {
        return $this->_creationDate;
    }
    public function setComment($comment)
    {
        $this->_comment = $comment;
    }
    public function getComment()
    {
        return $this->_comment;
    }
    public function setDeviceId($deviceId)
    {
        $this->_deviceId = $deviceId;
    }
    public function getDeviceId()
    {
        return $this->_deviceId;
    }
    public function setActive($isActive)
    {
        $this->_isActive = $isActive;
    }
    public function getActive()
    {
        return $this->_isActive;
    }
    public function setModificationDate($modificationDate)
    {
        $this->_modificationDate = $modificationDate;
    }
    public function getModificationDate()
    {
        return $this->_modificationDate;
    }
}

?>
