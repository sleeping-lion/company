//=require application
//=require plugin/jquery.easing.pack
//=require plugin/jquery.cycle.all.min
//=require plugin/jquery.prettyPhoto
//=require mediaplayer-5.7-viral/jwplayer

$(document).ready(function() {
	//Default Action
	$("#main_tab_container .tab_content:first").show(); //Show first tab content
	
	$('#product_category_tabmenu a').click(function(){		
		if(!complete)
			return false;
		
		complete=false;
		
		$(this).blur();
		
		
		if($('#product_category_tabmenu a').index($(this))) {
			productGroupId=$(this).attr('href').split('product_group_id=')[1];
			if(productGroupId==undefined) {
				main='';
				productGroupId='';
				productCategoryId=$(this).attr('href').split('product_category_id=')[1];
			} else {
				main='';			
				productCategoryId='';
			}
		} else {
			productGroupId='';			
			productCategoryId='';
			main=1;
		}
		
		getList2();
		
		var iId=$("#product_category_tabmenu a").index($(this));
		var leftPosition=0;
		var backWidth=0;
		$("#product_category_tabmenu a").each(function(index){
			if(index<iId)
			leftPosition+=$(this).width()+28;
			
			if(index==iId) {		
				$('#shit_move').css('width',$(this).width()+34);
				$('#shit_move_center').css('width',$(this).width());		
			}
		});
		
		$('#shit_move').animate({'left':leftPosition+15},300);		
		return false;	
	});
	
	var noMore=false;
	//On Click Event
	$("#main_tab_container ul li a").click(function() {				
		if(noMore)
			return false;
		
		noMore=true;		
		
		$("#main_tab_container ul li").removeClass("active"); //Remove any "active" class
		$(this).parent().addClass("active"); //Add "active" class to selected tab
		var tIndex=$("#main_tab_container ul li a").index($(this));		
		$(".tab_content").css('top','300px'); //Hide all tab content
		$("#main_tab_container .tab_content:eq("+tIndex+")").animate({'top':'10px'}, 350, 'easeOutQuad',function(){noMore=false;});   //Fade in the active content
		return false;
	});
	
	
	function getList() {
		if(productCategoryId==1 || productCategoryId==2 || productCategoryId==3) {
			var recommend=1;
		} else {
			var recommend=0;
		}
		
		$.getJSON('/template/json/index.php',{'main':main,'product_category_id':productCategoryId,'recommend':recommend,'limit':50,'json':true,'chunk':5}, function(data) {
			if(data.result=='success') {
				viewList(data.list);
			} else {
				alert(data.error_message);
			}
		});	
	}
	
	function getList2() {
		if(productGroupId==1 || productGroupId==2) {
			var recommend=1;
		} else {
			var recommend=0;	
		}
		
		$.getJSON('/template/json/index.php',{'main':main,'product_group_id':productGroupId,'product_category_id':productCategoryId,'recommend':recommend,'limit':60,'json':true,'chunk':12}, function(data) {
			if(data.result=='success') {
				viewList2(data.list);
			} else {
				alert(data.error_message);
			}
		});	
	}	
	
	function viewList(data) {
		var indexMain=$("#slider-div .scrollable .items");
		indexMain.find('li').remove();
		indexMain.find('.nonData').remove();
		if(!data.count) {
			//$("#total_count").text(0);
			indexMain.append('<p class="nonData">해당 상품이 없습니다.</p>');
			return false;
		}
		
		var clone=$("#design_slider .template:first").clone();
		
		$.each(data.list, function(index, value){
			var li=$('<li>');
		$.each(value, function(index2, value2){
			var div=clone.clone();
			div.addClass('template');			
			if((index2+1)%5==0) {
				div.addClass('nm');
			}
			
			if((index2+1)%4==1) {
				div.addClass('cls');
			}
			
			div.find('a').attr('href','show.php?id='+value2.id);			
			var productId=$('input[name="product_id"]');
			if(productId.length) {
				div.find('a').attr('href',div.find('a').attr('href')+'&product_id='+productId.val());		
			}

			
			div.find('img').attr('src',value2.uri);
			div.find('a').attr('href','/template/show.php?id='+value2.id);							
			div.find('p:last').text(value2.package_name.replace('Html5',''));
			div.find('.template_img').mouseover(function(e){
				var tcId=$(this).find('input').val();
				var previewSrc=$(this).find('input:eq(1)').val();				
				
				if(tcId==10 || tcId==12)
					return false;	

				$('#template_preview').css('width','430px');
				$('#loading').css('left','180px');
				jwplayer("container").remove();				
				
				var tId=$(this).find('a').attr('href').split('id=')[1];		
				var src=$(this).find('img').attr('src').split('-m.jpg')[0];
				$('#template_preview h1 span').text(tId);
				//alert(src+'-b-1.jpg');
				if(tcId==9 || tcId==11) {
					var base=src.split(value.id)[0];
					var flvFile=src+'-small.flv';
					jwplayer("container").setup({autostart: true,controlbar: "none",flashplayer: "/javascripts/mediaplayer-5.7-viral/player.swf",file:flvFile,height: 270,width:430});	
				} else {
					if(tcId==8) {
						$('#template_preview').css('width','210px');
						$('#loading').css('left','50px');
						}				
					$("#template_preview p").html('<img src="'+previewSrc+'" />');		
				}
				$('#template_preview,#loading').show();				
				setTimeout('$("#loading").fadeOut()',1000);
			}).mouseout(function(){
				jwplayer("container").stop();		
				$('#template_preview').hide();
			}).mousemove(function(e){
				var tcId=$(this).find('input:first').val();							
				if($(this).parent().hasClass('nm')) {
					if(tcId==8) {
						$('#template_preview').css({'top':e.pageY-200,'left':e.pageX-250});
					} else {
						$('#template_preview').css({'top':e.pageY-200,'left':e.pageX-470});
					}
				} else {
					$('#template_preview').css({'top':e.pageY-200,'left':e.pageX+20});
				}
			}).find('input').val(value2.product_category_id);
			div.find('.template_img').find('input:eq(1)').val(value2.preview);			
			li.append(div);
		});
		indexMain.append(li);
		});
		
		indexMain.find('.template').fadeIn(function(){$(this).removeClass('none')});
		$('#slider-div .scrollable .items').css('left',0);
		clone=null;
		indexMain=null;
		complete=true;
	}
	
	function viewList2(data) {
		var indexMain=$("#design_slider .scrollable .items");
		indexMain.find('li').remove();
		indexMain.find('.nonData').remove();
		if(!data.count) {
			//$("#total_count").text(0);
			indexMain.append('<p class="nonData">해당 상품이 없습니다.</p>');
			return false;
		}
				
		var clone=$("#design_slider .template:first").clone();
		
		$.each(data.list, function(index, value){
			var li=$('<li>');
		$.each(value, function(index2, value2){
			var div=clone.clone();
			div.addClass('template');			
			if((index2+1)%4==0) {
				div.addClass('nm');
			}
			
			if((index2+1)%4==1) {
				div.addClass('cls');
			}
			
			div.find('a').attr('href','show.php?id='+value2.id);			
			var productId=$('input[name="product_id"]');
			if(productId.length) {
				div.find('a').attr('href',div.find('a').attr('href')+'&product_id='+productId.val());		
			}

			
			div.find('img').attr('src',value2.uri);
			div.find('a').attr('href','/template/show.php?id='+value2.id);							
			div.find('p:last').text(value2.package_name.replace('Html5',''));
			div.find('.template_img').mouseover(function(e){
				var tcId=$(this).find('input').val();
				var previewSrc=$(this).find('input:eq(1)').val();				
				
				if(tcId==10 || tcId==12)
					return false;	

				$('#template_preview').css('width','430px');
				$('#loading').css('left','180px');
				jwplayer("container").remove();				
				
				var tId=$(this).find('a').attr('href').split('id=')[1];		
				var src=$(this).find('img').attr('src').split('-m.jpg')[0];
				$('#template_preview h1 span').text(tId);
				//alert(src+'-b-1.jpg');
				if(tcId==9 || tcId==11) {
					var base=src.split(value.id)[0];
					var flvFile=src+'-small.flv';
					jwplayer("container").setup({autostart: true,controlbar: "none",flashplayer: "/javascripts/mediaplayer-5.7-viral/player.swf",file:flvFile,height: 270,width:430});	
				} else {
					if(tcId==8) {
						$('#template_preview').css('width','210px');
						$('#loading').css('left','50px');
						}				
					$("#template_preview p").html('<img src="'+previewSrc+'" />');		
				}
				$('#template_preview,#loading').show();				
				setTimeout('$("#loading").fadeOut()',1000);
			}).mouseout(function(){
				jwplayer("container").stop();				
				$('#template_preview').hide();
			}).mousemove(function(e){
				var tcId=$(this).find('input:first').val();							
				if($(this).parent().hasClass('nm')) {
					if(tcId==8) {
						$('#template_preview').css({'top':e.pageY-200,'left':e.pageX-250});
					} else {
						$('#template_preview').css({'top':e.pageY-200,'left':e.pageX-470});
					}
				} else {
					$('#template_preview').css({'top':e.pageY-200,'left':e.pageX+20});
				}
			}).find('input').val(value2.product_category_id);
			div.find('.template_img').find('input:eq(1)').val(value2.preview);			
			li.append(div);
		});
		indexMain.append(li);
		});
		

		indexMain.find('.template').fadeIn(function(){$(this).removeClass('none')});
		$('#design_slider .scrollable .items').css('left',0);
		clone=null;
		indexMain=null;
		complete=true;
	}	
});