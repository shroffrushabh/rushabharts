<?php

/**
 * This class encapsulates subscription details.
 *
 * @author Ashutosh D
 * @date 29-05-2012
 * @copyright Mobiuso LLC
 */
class Subscription {

       private $_previousSubscriptionId;
       private $_productId;
       private $_startDate;
       private $_endDate;
       private $_type;
       private $_status;
       
       public function setPreviousSubscriptionId($previousSubscriptionId)
       {
           $this->_previousSubscriptionId = $previousSubscriptionId;
       }
       public function getPreviousSubscriptionId()
       {
           return $this->_previousSubscriptionId;
       }
       public function setProductId($productId)
       {
           $this->_productId = $productId;
       }
       public function getProductId()
       {
           return $this->_productId;
       }
       public function setStartDate($startDate)
       {
           $this->_startDate = $startDate ;
       }
       public function getStartDate()
       {
           return $this->_productId;
       }
       public function setEndDate($endDate)
       {
           $this->_endDate = $endDate;
       }
       public function getEndDate()
       {
           return $this->_endDate;
       }
       public function setType($type)
       {
           $this->_type = $type;
       }
       public function getType()
       {
           return $this->_type;
       }
       public function setStatus($status)
       {
           $this->_status;
       }
       public function getStatus()
       {
           return $this->_status;
       }
       
}

?>
