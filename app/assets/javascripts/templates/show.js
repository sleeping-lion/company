//=require application

$(document).ready(function() {
	$("a[rel^='prettyPhoto']").mouseover(function(e) {
	    $(this).children('img').animate({'opacity':0.4},300);
	}).mouseout(function(e) {
    $(this).children('img').animate({'opacity':1},300);
  }).prettyPhoto({animation_speed:'normal',theme:'light_rounded',slideshow:3000, autoplay_slideshow: true}).prettyPhoto({animation_speed:'normal',theme:'light_rounded',slideshow:3000, autoplay_slideshow: true});	
	
	
	$('#product_change_tab a').click(function(){
		$('#product_change_tab a').removeClass('active');
		$(this).addClass('active');
		
		var val=$(this).parent().find('input:first').val();
		$('select[name="product_id"]').val(val);		
		$('#fake_selector h5 span.text').text($(this).find('span').text());
		
		changeProduct();		
		return false;
	});
	
	$('select[name="product_id"]').change(changeProduct);
	
	$('#product_notice').toggle(function(){
		$(this).find('.shit_plus').removeClass('shit_plus').addClass('shit_minus');
		$(this).find('.request_alert_content').slideDown();
	},function(){
		$(this).find('.shit_minus').removeClass('shit_minus').addClass('shit_plus');		
		$(this).find('.request_alert_content').slideUp();
	});
	
	$('#addition_cost').toggle(function(){
		$(this).find('.shit_minus').removeClass('shit_minus').addClass('shit_plus');		
		$(this).find('.request_alert_content').slideUp();	
	},function(){
		$(this).find('.shit_plus').removeClass('shit_plus').addClass('shit_minus');
		$(this).find('.request_alert_content').slideDown();
	});
	
	$("#product_bottom_button input").mouseover(function(){
		switch($(this).attr('src')) {
			case '/images/homepage/submit.png':
				$(this).attr('src','/images/homepage/submit_on.png');
				break;
			case '/images/homepage/submit2.png':
				$(this).attr('src','/images/homepage/submit2_on.png');				
				break;
			default :
				$(this).attr('src','/images/homepage/submit1_on.png');				
			}
	}).mouseout(function(){
		switch($(this).attr('src')) {
		case '/images/homepage/submit_on.png':
			$(this).attr('src','/images/homepage/submit.png');
			break;
		case '/images/homepage/submit2_on.png':
			$(this).attr('src','/images/homepage/submit2.png');			
			break;
		default :
			$(this).attr('src','/images/homepage/submit1.png');			
		}		
	});
	
	
	

	$('a.index_popup,a.sub_popup').mouseover(function(e) {
    $(this).children('img').animate({'opacity':0.4},300);
	}).mouseout(function(e) {
    $(this).children('img').animate({'opacity':1},300);
   });
	
	$("#product_category_list a").click(function(){
		categoryId=$(this).attr('href').split('category_id=')[1];
		getList();
		$(this).blur();
		return false;	
	});
		
	var allCount=$("#allCount").text();
	if(Number(allCount)>Number($("#perpage").val()))
		initPagination(allCount,$("#perpage").val());

	
	function changeTotalPrice(totalPrice,totalPriceMax) {
		var totalPrice=addCommas(totalPrice.substr(0,totalPrice.length-4));
		
		if(totalPriceMax)
			var totalPriceMax=addCommas(totalPriceMax.substr(0,totalPriceMax.length-4));
			
		var totalLength=totalPrice.length;	
		var result='';
		for(var j = 0; j < totalLength; j++) {
			if(totalPrice.charAt(j) == ',') {
					result += '<span class="total_p now_comma">&nbsp;</span>';
			} else {
					result += '<span class="total_p">'+totalPrice.charAt(j)+'</span>';
			}
		}
		
		$("p.price:eq(0)").html(result);			
		
		if(totalPriceMax) {
			var totalLength=totalPriceMax.length;	
			var result2='';
			for(var j = 0; j < totalLength; j++) {
				if(totalPriceMax.charAt(j) == ',') {
						result2 += '<span class="total_p now_comma">&nbsp;</span>';
				} else {
						result2 += '<span class="total_p">'+totalPriceMax.charAt(j)+'</span>';
				}
			}
			$("p.price:eq(1)").html(result2);			
		}
	}		
	
	function changeProduct(){
		var pId=$('select[name="product_id"]').val();
		$.getJSON('/homepage/product/json/show.php',{'id':pId,'json':true},function(data){
			if(data.result=='success') {
				if(Number(data.content.sub_page)) {
					var pageText='총 <strong class="arial">'+Number(1+Number(data.content.sub_page));
					if(Number(data.content.sub_page_max)) {
						pageText+='~'+Number(Number(data.content.sub_page_max)+1);
					}
					pageText+='</strong>페이지';
					
					$("#product_info dl dd:eq(0)").html(pageText);
				} else {
					$("#product_info dl dd:eq(0)").html('협의후 결정');		
				}
				$("#product_info dl dd:eq(1)").html(data.content.page);
				$("#product_info dl dd:eq(2)").html(data.content.program);
				$("#product_info dl dd:eq(4)").html('<span class="arial">'+data.content.skill+'</span>');
				if(Number(data.content.make_day)) {
					var makeDay='<span class="arial">'+data.content.make_day;
					if(Number(data.content.make_day_max)) {
						makeDay+=' ~ '+data.content.make_day_max;
					}					
					$("#product_info dl dd:eq(5)").html(makeDay+'</span>영업일');
				} else {
					$("#product_info dl dd:eq(5)").html('협의후 결정');
				}
				changeTotalPrice(data.content.price,data.content.price_max);
				
				if(Number(data.content.price)) {
					if($("#customer_link").length)
						$("#customer_link").remove();
					$("#product_bottom_button input:first").show();
				} else {
					$("#product_bottom_button input:first").hide().before('<a id="customer_link" href="/customer_center/question/new.php?id='+data.content.id+'"><img src="/images/homepage/template/submit.png"></a>');
				}
				
				if(data.content.skill.count) {
					$("#product_info dl dd:eq(4)").empty();
					var Skilltext='';
					$.each(data.content.skill.list,function(index,value){
						if(index)
							Skilltext+=', ';
						Skilltext+='<span class="arial">'+value.name+'</span>';
						
					});
					$("#product_info dl dd:eq(4)").html(Skilltext);					
				} else {
					$("#product_info dl dd:eq(4)").empty();				
					$("#product_info dl dd:eq(4)").append('<p>없음</p>');
				}
				
				if(data.content.mobile_web)
					$("#mobile_web").html(data.content.mobile_web);				
				
				if(data.content.freeService.count) {
					$("#free_service").empty();
					$.each(data.content.freeService.list,function(index,value){
						var p=$('<p class="product_service">');
						p.html(value.name);
						$("#free_service").append(p);
					});
				} else {
					$("#free_service").empty();					
					$("#free_service").append('<p>없음</p>');
				}
				
				if(data.content.option.count) {
					$("#price_service").empty();
					$.each(data.content.option.list,function(index,value){
						var p=$('<p class="product_service">');
						p.html(value.name);
						$("#price_service").append(p);
					});
				} else {
					$("#price_service").empty();					
					$("#price_service").append('<p>없음</p>');
				}				
			} else {
				alert(data.error_message);
			}
		});
	}	
	
	
	function addCommas(nStr)
	{
		nStr += '';
		var x = nStr.split('.');
		var x1 = x[0];
		var x2 = x.length > 1 ? '.' + x[1] : '';
		var rgx = /(\d+)(\d{3})/;
		while (rgx.test(x1)) {
			x1 = x1.replace(rgx, '$1' + ',' + '$2');
		}
		return x1 + x2;
	}		
});