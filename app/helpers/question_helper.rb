# encoding: utf-8

module QuestionHelper
  def checkPrivLink(obj)
    if obj.secret?
      if checkPriv(obj)
        return link_to(obj.title,['customer_center',obj])
      else
        return link_to(obj.title,{:action=>'read_password',:id=>obj.id},{:rel=>'#overlay'})
      end
    else
      return link_to(obj.title,['customer_center',obj])
    end  
  end
end
