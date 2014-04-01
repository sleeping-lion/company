# encoding: utf-8

module ApplicationHelper
  def getFormatDate(date,type=nil)
    date.split(' ')[0];
  end
  
  def link_to_home
    link_to('홈',root_path,:title=>'홈으로')
  end
  
  def current_controller(aa)
    if aa.include?(params[:controller])
      return 'class="active"'
    end
  end
end
