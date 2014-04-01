# encoding: utf-8
User.create!(:email => 'fome234@nate.com', :name=>'예쁜-수정', :password => 'wjdwhdgh486', :password_confirmation => 'wjdwhdgh486', :admin=>1)
User.create!(:email => 'toughjjh@gmail.com', :name=>'잠자는-사자', :password => 'jjh123456', :password_confirmation => 'jjh123456', :admin=>1)

GalleryCategory.create!(:title=>'수정이')
GalleryCategory.create!(:title=>'종호')
GalleryCategory.create!(:title=>'멍멍이')
GalleryCategory.create!(:title=>'풍경')        
    
Notice.create!(:id=>1,:user_id=>1,:title=>'예쁘고 귀여운 수정이의 집이 다시 개장했습니다.')
NoticeContent.create!(:id=>1,:content=>'그동안 수많은 방문자에 비해서 준비되지 못하였는데 이제 보다 업그레이드된 모습으로 다시 찾아뵙게되었습니다.
    수정이와 소통하는 공간으로 계속 많은 이용바랍니다.')
    
FaqCategory.create!(:title=>'수정이 미모')
FaqCategory.create!(:title=>'수정이 애교')
FaqCategory.create!(:title=>'잘생긴 남친')
FaqCategory.create!(:title=>'멍멍이')

Faq.create!(:faq_category_id=>1,:id=>1,:title=>'수정이는 어떻게 이렇게 이쁜가요?')
Faq.create!(:faq_category_id=>1,:id=>2,:title=>'수정이는  목이 어떻게 그리 긴가요?')
Faq.create!(:faq_category_id=>1,:id=>3,:title=>'키가 약간 아쉽내요?')     
Faq.create!(:faq_category_id=>2,:id=>4,:title=>'수정이 애교를 배우고 싶어요')
Faq.create!(:faq_category_id=>2,:id=>5,:title=>'나이를 생각해서 애교를 삼가야 되지 않을까요?')
Faq.create!(:faq_category_id=>3,:id=>6,:title=>'남자친구는 누구이고 어떻게 저렇게 잘생겼나요?')
Faq.create!(:faq_category_id=>3,:id=>7,:title=>'생긴만큼 얼굴값을 하겠네요?')
Faq.create!(:faq_category_id=>4,:id=>8,:title=>'짬순이? 멍군이?')
Faq.create!(:faq_category_id=>4,:id=>9,:title=>'너무나 귀엽네요, 다들 잘 있나요?') 

FaqContent.create!(:id=>1,:content=>'원래 태어날때부터 예뻤습니다.')
FaqContent.create!(:id=>2,:content=>'사슴처럼 긴목 또한 태어날때부터 길었습니다.')
FaqContent.create!(:id=>3,:content=>'대신 빵빵한 가슴과 배로 커버하고 있습니다.')    
FaqContent.create!(:id=>4,:content=>'애교의 기본은 혀짮은 소리입니다.  앙앙, 귀엽게 앙!~ 하세요')    
FaqContent.create!(:id=>5,:content=>'나이는 숫자일뿐, 귀여운 수정이의 애교는 계속 됩니다.')
FaqContent.create!(:id=>6,:content=>'별명은 잠자는-사자이며 잘생긴 얼굴로 모든 여자들의 마음을 뺏어버리는 남자입니다') 
FaqContent.create!(:id=>7,:content=>'아닙니다. 선입견으로 그렇게 생각하기 쉬운데 성격은 얼굴보다 더 멋집니다.')
FaqContent.create!(:id=>8,:content=>'귀여운 짬순이는 말티즈 암컷으로 귀여운 멍군이를 낳았습니다')
FaqContent.create!(:id=>9,:content=>'종호의 사랑을 받으며 개팔자가 상팔자란 말 처럼 잘먹고 잘살고 있습니다.') 


Product.create!(:id=>1,:title=>'상품1', :description=>'좋은 상품1')
Product.create!(:id=>2,:title=>'상품2', :description=>'좋은 상품2')
Product.create!(:id=>3,:title=>'상품3', :description=>'좋은 상품3')
Product.create!(:id=>4,:title=>'상품4', :description=>'좋은 상품4')
Product.create!(:id=>5,:title=>'상품5', :description=>'좋은 상품5')
Product.create!(:id=>6,:title=>'상품6', :description=>'좋은 상품6')
Product.create!(:id=>7,:title=>'상품7', :description=>'좋은 상품7')
Product.create!(:id=>8,:title=>'상품8', :description=>'좋은 상품8')
ProductContent.create!(:id=>1,:content=>'원래 태어날때부터 예뻤습니다.')
ProductContent.create!(:id=>2,:content=>'사슴처럼 긴목 또한 태어날때부터 길었습니다.')
ProductContent.create!(:id=>3,:content=>'대신 빵빵한 가슴과 배로 커버하고 있습니다.')    
ProductContent.create!(:id=>4,:content=>'애교의 기본은 혀짮은 소리입니다.  앙앙, 귀엽게 앙!~ 하세요')    
ProductContent.create!(:id=>5,:content=>'나이는 숫자일뿐, 귀여운 수정이의 애교는 계속 됩니다.')
ProductContent.create!(:id=>6,:content=>'별명은 잠자는-사자이며 잘생긴 얼굴로 모든 여자들의 마음을 뺏어버리는 남자입니다') 
ProductContent.create!(:id=>7,:content=>'아닙니다. 선입견으로 그렇게 생각하기 쉬운데 성격은 얼굴보다 더 멋집니다.')
ProductContent.create!(:id=>8,:content=>'귀여운 짬순이는 말티즈 암컷으로 귀여운 멍군이를 낳았습니다')

require 'nokogiri'

#  t_info_dir.xml ==== http://www.templatemonster.com/webapi/xml/t_info_dir.zip 
f = File.open(File.dirname(__FILE__)+'/../lib/xml/t_info_dir.xml');
doc = Nokogiri::XML(f)

# template_source insert
sources = doc.xpath('//source')

sources.each do |source|
  @source = TemplateSource.new(
        :id    => source.at('id').text,
        :name  => source.at('name').text)
  if !@source.save
   puts "template source insert error"
  end
end

# template_software insert
softwares = doc.xpath('//software')

softwares.each do |software|
  @software = TemplateSoftware.new(
        :id    => software.at('id').text,
        :name  => software.at('name').text)
  if !@software.save
   puts "template software insert error"
  end
end

# template_category insert
categories = doc.xpath('//category')

categories.each do |category|
  @category = TemplateCategory.new(
        :id    => category.at('id').text,
        :name  => category.at('name').text)
  if !@category.save
   puts "template category insert error"
  end
end

# template_author insert
authors = doc.xpath('//author')

authors.each do |author|
  @author = TemplateAuthor.new(
        :id    => author.at('id').text,
        :name  => author.at('name').text)
  if !@author.save
   puts "template author insert error"
  end
end

# template_package insert
types = doc.xpath('//type')

types.each do |type|
  @type = TemplateType.new(
        :id    => type.at('id').text,
        :name  => type.at('name').text)
  if !@type.save
   puts "template type insert error"
  end
end

# template_package insert
packages = doc.xpath('//package')

packages.each do |package|
  @package = TemplatePackage.new(
        :id    => package.at('id').text,
        :name  => package.at('name').text)
  if !@package.save
   puts "template package insert error"
  end
end

#  t_info_dir.xml ==== http://www.templatemonster.com/webapi/xml/t_info_DIR.zip 
f = File.open(File.dirname(__FILE__)+'/../test.xml')
doc = Nokogiri::XML(f)

# template_source insert
templates = doc.css('template')

templates.each_with_index do |template,index|
  @template = Template.new(
        :id    => template.css('id').text,
        :template_type_id => template.css('type_id').text,
        :template_author_id=> template.css('author_id').text,
        :template_package_id=> template.css('package_id').text,        
        :state  => template.css('state').text,
        :price => template.css('price').text,
        :exc_price => template.css('exc_price').text,
        :downloads => template.css('downloads').text,
        :is_flash => template.css('is_flash').text,
        :is_adult => template.css('is_adult').text,
        :is_full_site => template.css('is_full_site').text,
        :is_real_size => template.css('is_real_size').text,
        :keywords => template.css('keywords').text,        
        :inserted_date => template.css('inserted_date').text,
        :update_date => template.css('update_date').text,              
        ) 

  if index > 100
    break
  end
              
        
  if @template.save
    template.css('screenshot').each do |screenshot|
      if screenshot.css('main_preview').length>0
        main_preview=true
        @template.update_attribute(:main_screenshot,screenshot.css('uri').text)
      else
        main_preview=false
      end
      
      if screenshot.css('small_preview').length>0
        small_preview=true
        @template.update_attribute(:small_screenshot,screenshot.css('uri').text)        
      else
        small_preview=false
      end      
      
      @template_screeshot=TemplateScreenshot.new(
        :template_id => @template.id,
        :uri  => screenshot.css('uri').text,
        :main_preview => main_preview,
        :small_preview => small_preview
      ) 
      
    if !@template_screeshot.save
        puts 'template screenshot insert error'
    end
    
    
    template.css('category_id').each do |category_id|
      @templates_template_categories=TemplateCategoriesTemplates.new(
        :template_id => @template.id,
        :template_category_id => category_id.text
          ) 
          
      if !@templates_template_categories.save
        puts 'templates categories insert error'
      end
    end    
    
    template.css('source_id').each do |source_id|
      @templates_template_sources=TemplateSourcesTemplates.new(
        :template_id => @template.id,
        :template_source_id => source_id.text
          ) 
          
      if !@templates_template_sources.save
        puts 'templates sources insert error'
      end
    end
    
    template.css('software_id').each do |software_id|
      @templates_template_softwares=TemplateSoftwaresTemplates.new(
        :template_id => @template.id,
        :template_software_id => software_id.text
          )       
      
      if !@templates_template_softwares.save
        puts 'templates sources insert error'
      end
    end
    
    
   end        
  else
   puts 'template source insert error'
  end
end