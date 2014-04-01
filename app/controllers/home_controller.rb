# encoding: utf-8

class HomeController < ApplicationController
  def index
    @template_categories=TemplateCategory.find(:all,:conditions=>{:enable=>true})
    @template_sliders=Template.order('id desc').page(params[:page]).per(50)    
    @template_lastests=Template.order('id desc').page(params[:page]).per(60)    
    @products=Product.all
    @projects=Project.order('id desc').page(params[:page]).per(10)
    @questions = Question.order('id desc').page(params[:page]).per(10)
    @notices=Notice.order('id desc').page(params[:page]).per(10)
    @guest_books=GuestBook.order('id desc').page(params[:page]).per(10)
    @maintains=Maintain.order('id desc').page(params[:page]).per(10)        
  end
end