
$(function () { 
	//admin login button click
	$("#adminLoginBtn").click(function(){
		ajaxSubmit("adminLoginForm",contextPath +'/admin/login?actionType=login',null);
		
	});
	//header logout button click
	$("#adminLogoutBtn").click(function(){
		layer.confirm('Confirm logout?', {
			  title:'Tips',
			  btn: ['Yes','No'],
			  icon: 3
			}, 
			function(){
				window.location.href= contextPath +'/admin/login?actionType=logout';
			});
		
	});
	

	/**
	 * ajax upload file
	 * need
	 * class: ajaxUpload 
	 * id: input name (Unique)
	 * uploadPath:under webContent
	 */
	$(".ajaxUpload").each(function(index){
	var divId = $(this).attr("id");
	var uploadPath = $(this).attr("uploadPath");
	$(this).dmUploader({
	  url: contextPath +'/ajaxImgUpload?uploadPath='+uploadPath,
	  dataType: 'json',
	  allowedTypes: 'image/*',
	  maxFileSize:'1024000',
	  
	  onBeforeUpload: function(id){
	  	 $("#"+divId+"_msgDiv").find('span.demo-file-status').html('Uploading...').addClass('demo-file-status-' + 'default');
	  },
	  onNewFile: function(i, file){
	  	var template = '<div id="'+divId+'_msgDiv" class="col-xs-6">' +
	      '<img id="'+divId+'_prvImgId" src="http://placehold.it/48.png" class="demo-image-preview" style="width: 80px" />' +
	      '<input id="'+divId+'_input" type="hidden" name="'+divId+'" value=""> '+
	      cutstr(file.name,20) + ' <span class="demo-file-size">(' + humanizeSize(file.size) + ')</span><br />Status: <span class="demo-file-status">Waiting to upload</span>'+
	      '<div class="progress progress-striped active">'+
	          '<div class="progress-bar" role="progressbar" style="width: 0%;">'+
	              '<span class="sr-only">0% Complete</span>'+
	          '</div>'+
	      '</div>'+
	  '</div>';
		$("#"+divId+"_msgDiv").remove();              
		$("#"+divId).after(template);
	  },
	  onUploadProgress: function(id, percent){
	  	
	  	var percentStr = percent + '%';
	  	$("#"+divId+"_msgDiv").find('div.progress-bar').width(percentStr);
			$("#"+divId+"_msgDiv").find('span.sr-only').html(percentStr + ' Complete');
			
	 	},
	  onUploadSuccess: function(id, data){
	  	
	  	$("#"+divId+"_msgDiv").find('span.demo-file-status').html('Upload Complete').addClass('demo-file-status-' + 'success');
	  	//$("#"+divId+"_msgDiv").find('div.progress-bar').width('100%');
			//$("#"+divId+"_msgDiv").find('span.sr-only').html('100%' + ' Complete');
			$("#"+divId+"_msgDiv").find('div.progress').hide();
			
	      $("#"+divId+"_prvImgId").attr("src",contextPath +"/readAjaxImage?fileName="+uploadPath+data.fileName);
	      $("#"+divId+"_input").val(data.fileName);
	      $("#"+divId+"_view").hide();
	       
	 	},
	 	onUploadError: function(id, message){
	 		$("#"+divId+"_msgDiv").find('span.demo-file-status').html(message).addClass('demo-file-status-' + 'error');
	 	},
	 	onFileTypeError: function(file){
	 		layer.alert('File type of ' + file.name + ' is not allowed: ' + file.type, {
	 			title:'Tips',
	 			btn: ['Confirm'],
	 			icon: 2
	 		})
	 		
	 	},
	 	onFileSizeError: function(file){
	 		layer.alert('File size of ' + file.name + ' exceeds the limit', {
	 			title:'Tips',
	 			btn: ['Confirm'],
	 			icon: 2
	 		})
	 	}
	  
	});
	});
 })

/**
 * 
 * @param formId  submit form id
 * @param dataStr data like 'name1=value1&name2=value2'
 * @param confirmDesc if not null ,then alert info
 */
function submitForm(formId,dataStr,confirmDesc)
{
	//disable hidden input validate
	$("input.easyui-validatebox:hidden").each(function(){
	    $(this).validatebox('disableValidation');
	  });
	
	// jquery easyui validate form
	if( $('#'+formId).form('validate'))
	{
		if(confirmDesc != null && '' != confirmDesc)
		 {
			 layer.confirm(confirmDesc, {
				  title:'Tips',
				  btn: ['Yes','No'],
				  icon: 3
				}, function(){
					submitForm(formId,dataStr,'');
				});
		 }
		 else
		 {

			 var postForm = document.getElementById(formId);//表单对象
			 postForm.method="post" ;
			 
			 var datas = dataStr.split("&"); 

			 var elements=new Array();
			 for(var i=0;i<datas.length;i++)
			 {
				 var input = document.createElement("input") ; //email input
				 input.setAttribute("name", datas[i].split("=")[0]) ;
				 input.setAttribute("value", datas[i].split("=")[1]);
				 input.setAttribute("type", "hidden");
				 postForm.appendChild(input) ;
				 elements.push(input);
			 }  
			 postForm.submit() ;
			 
			 for(var j=0;j<elements.length;j++)
			 {
				 document.body.removeChild(elements[j]) ;
			 }
			
		 }
	}
	
}
/**
 * 
 * @param action submit action
 * @param dataStr submit data like 'name1=value1&name2=value2'
 * @param confirmDesc if not null ,then alert info
 */
 function submitAction(action,dataStr,confirmDesc)
 {
	 if(confirmDesc != null && '' != confirmDesc)
	 {
		 layer.confirm(confirmDesc, {
			  title:'Tips',
			  btn: ['Yes','No'],
			  icon: 3
			}, function(){
				submitAction(action,dataStr,'');
			});
	 }
	 else
	 {
		 var postForm = document.createElement("form");//表单对象
		 postForm.method="post" ;
		 postForm.action = action ; 
		 
		 if(dataStr != null && "" != dataStr)
		 {
			 var datas = dataStr.split("&"); 

			 for(var i=0;i<datas.length;i++)
			 {
				 var input = document.createElement("input") ; //email input
				 input.setAttribute("name", datas[i].split("=")[0]) ;
				 input.setAttribute("value", datas[i].split("=")[1]);
				 input.setAttribute("type", "hidden");
				 postForm.appendChild(input) ;
				
			 } 
		 }
		  
		 document.body.appendChild(postForm) ;
		 
		 postForm.submit() ;
		 document.body.removeChild(postForm) ;
	 }
	 
 }
/**
 * 
 * @param formId 表单Id
 * @param action 处理Ajax 的 action 地址，
 * 1.formId 和 action 都不为空，action会覆盖form 中的 action
 * 2.formId非空，action 为空，提交form
 * 3.formId为空，action不为空，提交action
 * @param confirmDesc 非空时，弹出确认信息
 */
function ajaxSubmit(formId,action,confirmDesc)
{
	//disable hidden input validate
	$("input.easyui-validatebox:hidden").each(function(){
	    $(this).validatebox('disableValidation');
	  });
	
	// jquery easyui validate form
	if( $('#'+formId).form('validate'))
	{
		if(confirmDesc == null || '' == confirmDesc)
		{
			ajaxSubmitAction(formId,action);
		}
		else
		{
			layer.confirm(confirmDesc, {
				  title:'Tips',
				  btn: ['Yes','No'],
				  icon: 3
				}, function(){
					ajaxSubmitAction(formId,action);
				});
		}
	}
	
}
function ajaxSubmitAction(formId,action)
{
	var loadingIcon = layer.load(0, {shade: [0.5,'#fff']}); //0代表加载的风格，支持0-2
	var ajaxAction =$.ajax({
		type:"post",
		url:(action==null || '' == action)?$('#'+formId).attr("action"):action,//发送请求地址
		dataType:"json",
		//data:(action==null || '' == action)?$('#'+formId).serialize():'',
		data:$('#'+formId).serialize(),
		
		//请求成功后的回调函数
		success:function(respObj,textStatus)
		{
			ajaxSubmitSuccess(formId,respObj,textStatus);
		},
		//请求错误后的回调函数
		error:function()
		{
			ajaxSubmitError();
		},
		//请求完成后最终执行函数
		complete:function(XMLHttpRequest,status)
		{
			ajaxSubmitComplete(XMLHttpRequest,status,loadingIcon,ajaxAction);
		}
		
	})
}

function ajaxSubmitSuccess(formId,respObj,textStatus)
{
	// icon图标样式
	var icon = 5;
	if(respObj.respCode =="1")
	{
		icon = 6;
	}
	//输出信息
	if(respObj.defaultMsg!=null && "" != respObj.defaultMsg)
	{
		layer.alert(respObj.defaultMsg, {
			closeBtn: 0,
    		title:'Tips',
    		btn: ['Confirm'],
    		icon: icon
    	},function(index){
    		//跳转
    		if(respObj.redirectUrl!=null && "" != respObj.redirectUrl)
			{
    			var redirectUrl = respObj.redirectUrl;
    			if(redirectUrl.indexOf(contextPath) == -1)
    			{
    				redirectUrl = contextPath + respObj.redirectUrl;
    			}
    			var datas = redirectUrl.split("?"); 
    			submitAction(datas[0],datas[1],'');
				//window.location.href= contextPath +respObj.redirectUrl;
			}
    		else if(respObj.rePostForm)
    		{
    			submitForm(formId, null, null);
    		}
    		else
    		{
    			reloadDg();
    		}
    		layer.close(index);
    	});
	}
	else if(respObj.detailMsg!=null)
	{
		
	}
	
	else if(respObj.redirectUrl!=null && "" != respObj.redirectUrl)
	{
		var redirectUrl = respObj.redirectUrl;
		if(redirectUrl.indexOf(contextPath) == -1)
		{
			redirectUrl = contextPath + respObj.redirectUrl;
		}
		var datas = redirectUrl.split("?"); 
		submitAction(datas[0],datas[1],'');
		//window.location.href= contextPath +respObj.redirectUrl;
	}
	else if(respObj.rePostForm)
	{
		submitForm(formId, '', '');
	}
}

function ajaxSubmitError()
{
	layer.alert('Request error.', {
		title:'Tips',
		btn: ['Confirm'],
		icon: 2
	})
}
function ajaxSubmitComplete(XMLHttpRequest,status,loadingIcon,ajaxAction)
{ 
	if(status!='success')
	{
		ajaxAction.abort();
	}
	layer.close(loadingIcon);
	var sessionStatus=XMLHttpRequest.getResponseHeader("sessionStatus"); 
	var errorMsg=XMLHttpRequest.getResponseHeader("errorMsg"); 
    if(sessionStatus=="timeout")
    {
    	layer.alert('Your session has expired due to inactivity or an incorrect page request.', {
    		title:'Tips',
    		btn: ['Confirm'],
    		icon: 5
    	},function(index){
    		window.location.href= contextPath +'/admin/login';
    	});
    	
    }
    else if(errorMsg != null)
    {
    	layer.alert('Request error：'+errorMsg, {
    		title:'Tips',
    		btn: ['Confirm'],
    		icon: 5
    	});
    }
}



/** 
 * js截取字符串，中英文都能用 
 * @param str：需要截取的字符串 
 * @param len: 需要截取的长度 
 */
function cutstr(str, len) {
    var str_length = 0;
    var str_len = 0;
    str_cut = new String();
    str_len = str.length;
    for (var i = 0; i < str_len; i++) {
        a = str.charAt(i);
        str_length++;
        if (escape(a).length > 4) {
            //中文字符的长度经编码之后大于4  
            str_length++;
        }
        str_cut = str_cut.concat(a);
        if (str_length >= len) {
            str_cut = str_cut.concat("...");
            return str_cut;
        }
    }
    //如果给定字符串小于指定长度，则返回源字符串；  
    if (str_length < len) {
        return str;
    }
}
//计算文件大小
function humanizeSize(size) {
    var i = Math.floor( Math.log(size) / Math.log(1024) );
    return ( size / Math.pow(1024, i) ).toFixed(2) * 1 + ' ' + ['B', 'kB', 'MB', 'GB', 'TB'][i];
 }
//  Jquery 将表单序列化为Json对象 
(function($){  
    $.fn.serializeJson=function(){  
        var serializeObj={};  
        var array=this.serializeArray();  
        var str=this.serialize();  
        $(array).each(function(){  
            if(serializeObj[this.name]){  
                if($.isArray(serializeObj[this.name])){  
                    serializeObj[this.name].push(this.value);  
                }else{  
                    serializeObj[this.name]=[serializeObj[this.name],this.value];  
                }  
            }else{  
                serializeObj[this.name]=this.value;   
            }  
        });  
        return serializeObj;  
    };  
})(jQuery); 

/**
 * 根据搜索条件 加载 easyui dataGrid 数据
 */
function reloadDg()
{
	$('#dg').datagrid(
		'reload',
		$('#searchForm').serializeJson()
	);
}
/**
 * 
 * @param pageSize 分页大小
 * @param pageIdx 当前页码
 * @param sortName 排序字段
 * @param sortOrder 排序方法
 * @param actionName 加载数据action
 */
function loadDg(pageSize,pageIdx,sortName,sortOrder,actionName)
{
	$('#dg').datagrid({
    	pageSize:parseInt(pageSize),
		pageNumber:parseInt(pageIdx),
		sortName: sortName,
		sortOrder:sortOrder,
		emptyMsg:'no records found',
		fitColumns:true,
		striped:true,
		rownumbers:true,
		pagination:true,
		singleSelect:true,
		url: contextPath+'/admin/'+actionName+'?actionType=loadData',
		queryParams:$('#searchForm').serializeJson(),
		method:'post',
		onDblClickRow: function(rowIndex,rowData){
			$('#viewBtn'+rowIndex).click();
		},
		onLoadSuccess:function(data){
			if(data.total>0)
			{
				$(".exportBtn").show();
			}
		}
		
    });
}
/**
 * 
 * @param actionName dataGrid 行数据操作 url
 * @param val 行数据id
 * @param row 行数据
 * @param index 行排序数
 * @param level 权限
 * @returns {String}
 */
function formatOperAction(actionName,val,row,index,level)
{ 
	var viewBtn = '';
	var updateBtn ='';
	var delBtn = '';
	if(parseInt(level)>0)
	{
		viewBtn = " <a id='viewBtn"+index+"'onclick=\"submitAction('"+actionName+"','actionType=view&beanId="+val+"','')\" class=\"btn btn-sm btn-cancel\" href=\"javascript:void(0)\"><span class=\"fa fa-eye\"></span> View</a>";
	}
	if(parseInt(level)>2)
	{
		updateBtn = " <a onclick=\"submitAction('"+actionName+"','actionType=updateSetup&beanId="+val+"','')\" class=\"btn btn-sm btn-primary\" href=\"javascript:void(0)\"><span class=\"fa fa-edit\"></span> Edit</a> ";
	}
	if(parseInt(level)>3)
	{
		delBtn = " <a onclick=\"ajaxSubmit('','"+actionName+"?actionType=delete&beanId="+val+"','Confirm Delete?')\" class=\"btn btn-sm btn-danger\" href=\"javascript:void(0)\"><span class=\"fa fa-remove\"></span> Delete</a>" ;
	
	}
	return viewBtn + updateBtn + delBtn ;
 
} 
/**
 * easyUi validatebox datebox 日期格式化 带分隔符 -
 */
function dateFormatter(date){
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    return (d<10?('0'+d):d)+'-'+(m<10?('0'+m):m)+'-'+y;
}
/**
 * easyUi validatebox datebox 日期格式化 带分隔符 -
 */
function dateParser(s){
    if (!s) return new Date();
    var ss = (s.split('-'));
    var y = parseInt(ss[2],10);
    var m = parseInt(ss[1],10);
    var d = parseInt(ss[0],10);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
        return new Date(y,m-1,d);
    } else {
        return new Date();
    }
}
/**
 * easyUi validatebox datebox 日期格式化 不带分隔符
 */
function dateFormatter2(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return (d<10?('0'+d):d)+''+(m<10?('0'+m):m)+''+y;
}
/**
 * easyUi validatebox datebox 日期格式化 不带分隔符
 */
function dateParser2(s){
	if (!s) return new Date();
	var y = s.substring(4,8);
	var m = s.substring(2,4);
	var d = s.substring(0,2);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
		return new Date(y,m-1,d);
	} else {
		return new Date();
	}
}
/**
 * easyUi validatebox 校验规则拓展
 */
$.extend($.fn.validatebox.defaults.rules, {
    date: {
        validator: function(value, param){
        	var _reDateReg1 = /^(?:(?:[0-2][1-9])|(?:[1-3][0-1]))-(?:(?:0[1-9])|(?:1[0-2]))-(?:19|20)[0-9][0-9]$/;
        	var _reDateReg2 = /^(?:(?:[0-2][1-9])|(?:[1-3][0-1]))(?:(?:0[1-9])|(?:1[0-2]))(?:19|20)[0-9][0-9]$/;
            return ((_reDateReg1.test(value)) || (_reDateReg2.test(value)));
        },
        message: 'Please enter a valid date.'
    },
    year:{
        validator: function(value, param){
        	var _reYear = /^(?:19|20)[0-9][0-9]$/;
            return (_reYear.test(value));
        },
        message: 'Please enter a valid year.'
    },
    positiveIntegers:{
    	 validator: function(value, param){
         	var _reDateReg =  /^[0-9]*[1-9][0-9]*$/;
             return _reDateReg.test(value);
         },
         message: 'Please enter a positive integer.'
    },
    bigger:{
        validator: function(value,param){
        	if($(param[0]).val()=='')
        		return true;
        	if((parseInt(value)-999999) >= parseInt($(param[0]).val()))
        		return false;
            return parseInt(value) >= parseInt($(param[0]).val());
        },
        message: 'Number range invalid.'
   },
   noSpaces:{
       validator: function(value,param){
    	   var reg = /\s/;
    	   return !reg.test(value)
       },
       message: 'No spaces are permitted.'
  },
   after:{
       validator: function(value,param){
    	var paramVal = $(param[0]).datebox('getValue'); 
       	if(paramVal=='')
       		return true;
       	var y_value = value.substring(4,8);
    	var m_value = value.substring(2,4);
    	var d_value = value.substring(0,2);
    	var y_param = paramVal.substring(4,8);
    	var m_param = paramVal.substring(2,4);
    	var d_param = paramVal.substring(0,2);
    	
    	var date_value = new Date(y_value,m_value,d_value);
    	var date_param = new Date(y_param,m_param,d_param);
    	
    	return date_value.getTime()>=date_param.getTime();
          
       },
       message: 'Date range invalid.'
  }
    

});