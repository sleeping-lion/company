# encoding: utf-8

class CompanyController < ApplicationController
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.company')
  end

  def index
    @histories = History.order('id desc').page(params[:page]).per(15)
  end
end