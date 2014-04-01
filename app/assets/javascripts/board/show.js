//= require application

$(document).ready(function(){
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
});