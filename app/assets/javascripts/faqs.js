//= require application
//= require jquery_ujs
//= require plugin/jquery.uri.js

$(document).ready(function() {
	
	$("#faqCategoryList a.title").click(getList);
	$("#faqList dt a.title").click(getContent);
	
	function getList() {
		var tt=$(this);
		var parent=$(this).parent();		
		
		$.getJSON($(this).attr('href')+'.json',function(data){
			$("#faqList").empty();
			if(data.faqs.length) {
				$.each(data.faqs,function(index,value){
					var a=$('<a class="title" href="/custmer_center/faqs?id='+value.id+'">'+value.title+'</a>').click(getContent);
					if(data.admin) {
						var div=$('<div class="sl_faq_menu"><a>수정</a> &nbsp; | &nbsp; <a rel="nofollow" data-method="delete" data-confirm="정말로 삭제합니까?">삭제</a></div>');
						div.find('a:first').attr('href','/customer_center/faqs/'+value.id+'/edit');
						div.find('a:eq(1)').attr('href','/customer_center/faqs/'+value.id);
						$('<dt>').appendTo("#faqList").append(a).append(div);
					} else {
						$('<dt>').appendTo("#faqList").append(a);
					}
				});
			} else {
				$('<dt>글이 없습니다.</dt>').appendTo("#faqList");
			}

			$("#faqCategoryList li").removeClass('on');
			parent.addClass('on');
			
			var faqCategoryId=$.uri.setUri(tt.attr('href')).param("faq_category_id");			
			
			if(data.admin) {
				$("#faqCategoryList li .sl_faq_category_menu").remove();
				var dd=$('<div class="sl_faq_category_menu"><a>수정</a><br /><a rel="nofollow" data-method="delete" data-confirm="정말로 삭제합니까?">삭제</a></div>');
				dd.find('a:first').attr('href','/customer_center/faq_categories/'+faqCategoryId+'/edit');
				dd.find('a:eq(1)').attr('href','/customer_center/faq_categories/'+faqCategoryId);
				parent.append(dd);
			}
			
			$('#sl_bottom_menu a:eq(1)').attr('href','/customer_center/faqs/new?faq_category_id='+faqCategoryId);		
		});
		return false;
	}
	
	function getContent(){
		var gid=$.uri.setUri($(this).attr('href')).param("id");
		var parent=$(this).parent();		
		$.getJSON('/customer_center/faqs/'+gid+'.json',function(value){
			if(parent.next().get(0)) {
				if(parent.next().get(0).tagName!='DD') {
					parent.after('<dd>');	
				}
			} else {
				parent.after('<dd>');
			}
			$("#faqList dt").removeClass('on');
			$("#faqList dd").hide();
			parent.addClass('on');
			parent.next().html('<p>'+nl2br(value.content)+'</p>').slideDown();			
		});

		return false;
	}	
});

function nl2br (str, is_xhtml) {
	  var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br ' + '/>' : '<br>';
	  return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
}