//= require jquery_ujs

window['CKEDITOR_BASEPATH']='/ckeditor/';

$(document).ready(function(){
$('.modal_link').click(function(event){
  event.preventDefault();
  $('#myModal').removeData("modal");
  $('#myModal').modal({'remote':$(this).attr('href')+'?no_layout=true'});
});

    $(".btn_minimize").click(function(){
        var i=$(this).parent().find('i:first');
        if(i.hasClass('glyphicon-chevron-down')) {
            i.removeAttr('class').addClass('glyphicon').addClass('glyphicon-chevron-up');
            $(this).parent().parent().parent().find('.box_content').slideDown();
        } else {
            i.removeAttr('class').addClass('glyphicon').addClass('glyphicon-chevron-down');
            $(this).parent().parent().parent().find('.box_content').slideUp();
        }
        return false;
        });
    
    $(".btn_close").click(function(){
        $(this).parent().parent().parent().remove();
        return false;
        });

	
	$('.template_img').mouseover(template_mouseover).mouseout(template_mouseout).mousemove(template_mousemove);
});

function template_mouseover() {
	var tcId=$(this).find('input').val();
	var previewSrc=$(this).find('input:first').val();	
	if(tcId==10 || tcId==12)
		return false;
	
	$('#template_preview').css('width','430px');
	$('#loading').css('left','180px');	
	
	var tId=$(this).find('a').attr('href').split('/templates/')[1];
	$('#template_preview h1 span').text(tId);		
	$("#template_preview p").html('<img src="'+previewSrc+'" />');		
	$('#template_preview,#loading').show();				
	setTimeout('$("#loading").fadeOut()',1000);
}

function template_mouseout() {
	$('#template_preview').hide();
}

function template_mousemove(e) {
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
}
