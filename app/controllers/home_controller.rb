# encoding: utf-8

class HomeController < ApplicationController
  def index   
    @products=Product.all
    @projects=Project.order('id desc').page(params[:page]).per(10)
    @questions = Question.order('id desc').page(params[:page]).per(10)
    @notices=Notice.order('id desc').page(params[:page]).per(10)
    @guest_books=GuestBook.order('id desc').page(params[:page]).per(10)
    @maintains=Maintain.order('id desc').page(params[:page]).per(10)        
  end
end