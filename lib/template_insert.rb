require 'nokogiri'
require File.dirname(__FILE__)+'/../app/models/template.rb'

#  t_info_dir.xml ==== http://www.templatemonster.com/webapi/xml/t_info_dir.zip 
f = File.open('xml/t_info.xml');
doc = Nokogiri::XML(f)

# template_source insert
templates = doc.xpath('//template')

templates.each_with_index do |template,index|
  @template = Template.new(
        :id    => template.at('id').text,
        :state  => template.at('state').text,
        :price => template.at('price').text,
        :exc_price => template.at('exc_price').text,
        :downloads => template.at('downloads').text,
        :is_falsh => template.at('is_flash').text,
        :is_adult => template.at('is_adult').text,
        :is_full_site => template.at('is_full_site').text,
        :is_real_size => template.at('is_real_size').text,
        :inserted_date => template.at('inserted_date').text,
        :update_date => template.at('update_date').text,
              
        )
       puts 'ww'
  puts index
  if index > 100
    break
  end
              
        
  if !@template.save
   puts "template source insert error"
  end
end