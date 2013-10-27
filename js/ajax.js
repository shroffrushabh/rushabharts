$(document).ready(function () {

hoverImg();

   $("a.links , a.glinks ").live('click', function (event) {
		var link = $(this).attr("href") + " #content";
		$('#pageloading').css("visibilty","visible");
	   event.preventDefault();
       var target_div = $(this).hasClass('glinks') ? 	"#content2" : "#content";

       $(target_div).load(link, function () {
				$('#pageloading').css("visibilty","hidden");
		 hoverImg();
		   if(link== "inq.html #content") {	
				$('.prod').bind('change',function()
				{
				url="";
				var prod=$('#prod').val();
				url="inquiry.php";
					$.post(    
    				url, 
					{prod:prod},
					function(data){
					$('#swap').replaceWith('<select id="swap">'+data+'</select>');
    				});					
				});
				$('.submit').bind('click',function(event){
					event.preventDefault();
					if(validateForm()==false)
					return false;
					else if(verifyEmail()==false)
					{	
						alert("Please enter a correct email address.");
						document.frm.email.value="";
						document.frm.email.focus();
						return false;
					}
					else
							if(!checkcode(document.getElementById("code").value))
							return false;
							
					});
				
	
			}
			
		
		
		
		$(".ilinks").bind('click',function(event){
		
		event.preventDefault();
		var alternative=$(this).attr("id");
		
		$('#content').load("inq.html #content",function(){
			
			document.getElementById("prod").value = "diary";			
			document.getElementById("prod").disabled="true";
			$('#swap').replaceWith('<input type="text" id="txt" disabled="true" value="'+alternative+'">');
			
			
			$('.submit').bind('click',function(event){
				//if(validateForm()==false || verifyEmail()==false)
				//{
				//}else if(verifyEmail()==false)
					//return false;
					
					validateForm();
					
					if(verifyEmail()==false)
					{
						alert("Incorrect Email id, please re-enter the id.");
						return false;
					}
					event.preventDefault();
							
							if(!checkcode(document.getElementById("code").value))
							return false;
							
			});
			
			});
		
		});		   
		
		
			
		   	$(this).find('#carousel').featureCarousel();
		   

		   
		   
       });
   });
});

function setInq()
{	
	
document.getElementById("prod").value = "diary";//document.getElementById("sel").style.visibility='hidden';
//document.getElementById("swap").value="dr1";
var create=document.createElement("input");
create.setAttribute("text");
create.setAttribute("id","txt");
frm.replaceChild(create,frm['swap']);
document.getElementById("txt").value="dr1";
document.getElementById("txt").disabled="true";
document.getElementById("prod").disabled="true";
}




function getCode()
{
	var xmlhttp;
	try{
		xmlhttp=new XMLHttpRequest();
	}catch(e){
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTPS");
	}
	
	if(xmlhttp)
	{
		var prod=document.frm.prod.value;
		
		xmlhttp.open("GET","nquiry.php?prod="+prod,true);
		alert("Chrome");
		xmlhttp.onreadystatechange=function()
		{
			if(xmlhttp.readyState==4 || xmlhttp.status==200)
			{
			  		
			var resp=document.createElement("select");
			resp.id="code";
			resp.name="code";
			resp.innerHTML=xmlhttp.responseText;
			alert("This is the response text:"+this.responseText);
			
			if(frm['code'])
			{	alert("code");
				frm.replaceChild(resp, frm['code']);
			}
			else {
				alert("swap");
				frm.replaceChild(resp,frm['swap']);
				 }
			}
		}
	xmlhttp.send(null);
	}
	
}

function hoverImg()
{
	$("ul.thumb li").hover(function() {
	$(this).css({'z-index' : '1'}); 
	$(this).find('img').addClass("hover").stop() 
			.animate({
			marginTop: '-210px',
			marginLeft: '-210px',
			top: '50%',
			left: '50%',
			width: '320px', 
			height: '320px', 
			padding: '20px'
		}, 200); 
		
	} , function() {
	$(this).css({'z-index' : '0'}); 
	$(this).find('img').removeClass("hover").stop()  
		.animate({
			marginTop: '0', 
			marginLeft: '0',
			top: '0',
			left: '0',
			width: '200px', 
			height: '200px', 
			padding: '5px'
		}, 400);
});
}

function validateForm()
{
	
	var x=document.getElementById("prod").selectedIndex;
	var y=document.getElementById("prod").options;
	var name,email,number,qty;
	name=document.frm.name.value;
	email=document.frm.email.value;
	number=document.frm.number.value;
	qty=document.frm.qty.value;
	var addr=document.frm.addr.value;
	//alert(y[x].value);
	if( y[x].index == 0)
	{
		
	alert("Please select a product");
	return false;
	}else
	 if(name=="")
    { 
      alert("Name should not be left blank");
      document.frm.name.focus();
      return false;
    }
    else if(email=="")
    {
      alert("Email should not be left blank");
      document.frm.email.focus();
      return false; 
	  
    }
    else if(number=="")
    {
      alert("Phone number should not be left blank");
      document.frm.number.focus();
      return false;
    }
    else if(isNaN(number))
    {
      alert("Phone number should be valid");
      document.frm.number.focus();
      return false;
    }
	  else if(qty=="")
    {
      alert("Quantity should not be left blank");
      document.frm.qty.focus();
      return false;
    }
    else if(isNaN(qty))
    {
      alert("Quantity is invalid");
      document.frm.qty.focus();
      return false;
    }
	  else if(addr=="")
    {
      alert("Address should not be left blank");
      document.frm.addr.focus();
      return false;
	} else if(document.getElementById("code").value=='') {
          alert('Please enter the string from the displayed image');
          document.getElementById("code").focus();
          return false;
          }



}

function verifyEmail()
{
var email = document.frm.email.value;
var AtPos = email.indexOf("@");
var StopPos = email.lastIndexOf(".");
var Message = true;


if (AtPos == -1 || StopPos == -1) {
Message = false;
}

if (StopPos < AtPos) {
Message = false;
}

if (StopPos - AtPos == 1) {
Message = false;
}

return Message;

}


function submitAjax()
{	
	
	var x,y;
	var a;
	
	if(document.getElementById("swap"))
	{
		x=document.getElementById("swap").selectedIndex;
		y=document.getElementById("swap").options;
		a=y[x].value;
	}
	else a=document.getElementById("txt").value;

	
	
	var details=new Array();
	details[0]=document.frm.name.value;
	details[1]=document.frm.email.value;
	details[2]=document.frm.number.value
	details[3]=document.frm.qty.value;
	details[4]=document.frm.addr.value;
	details[5]=a;
	details[6]=document.frm.commenttxt.value;
	
	var jsonStr = JSON.stringify(details);
	document.getElementById("target").style.visibility='hidden';
	document.getElementById("loading").style.visibility='visible';
	//alert(jsonStr);
	var xmlhttp;
	try{
		xmlhttp=new XMLHttpRequest();
	}catch(e){
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTPS");
	}
	
	if(xmlhttp)
	{
		xmlhttp.onreadystatechange=function()
		{	
			
			if(xmlhttp.readyState==4 || xmlhttp.status==200)
			{
				document.getElementById("loading").style.visibility='hidden';
				document.getElementById("target").style.visibility='visible';
				//alert(xmlhttp.responseText);
			document.getElementById("target").innerHTML=xmlhttp.responseText;
			}
		}
		
				xmlhttp.open("GET","db.php?json="+jsonStr,true);
		
		xmlhttp.send(null);	
	}
}

	 
	 
	 
function checkcode(thecode) {
		 var url = 'captcheck.php?code=';
        var captchaOK = 2;  // 2 - not yet checked, 1 - correct, 0 - failed
	
       function getHTTPObject()
        {
        try {
        req = new XMLHttpRequest();
          } catch (err1)
          {
          try {
          req = new ActiveXObject("Msxml12.XMLHTTP");
          } catch (err2)
          {
          try {
            req = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (err3)
            {
	req = false;
            }
          }
	}
        return req;
	}
        
        var http = getHTTPObject(); 
        
        function handleHttpResponse() {
        if (http.readyState == 4) {
            captchaOK = http.responseText;
			//alert(captchaOK)
            if(captchaOK != 1) {
              alert('The entered code was not correct. Please try again');
			  
			   $('#img').replaceWith('<img src="image.php" id="img" name="img" border="0">');
			  
              document.myform.code.value='';
              document.myform.code.focus();
              return false;
              }
			  else{
				  submitAjax();
				   return true;
				   }
				   
           }
        }	 
			 
        http.open("GET", url + (thecode), true);//escape(thecode)
        http.onreadystatechange = handleHttpResponse;
        http.send(null);
		
		
        }
        
