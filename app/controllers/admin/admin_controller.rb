# encoding: utf-8

class Admin::AdminController < ApplicationController
  layout 'admin/main'
  before_filter :authenticate_user!,:only => [:index,:new,:create,:show,:edit, :update, :destroy]
  
  def initialize(*params)
    super(*params)
    @style='admin/index'
    @script='admin/index'
  end
end
