# encoding: utf-8

class Admin::GuestBooksController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='방명록'
  end
  
  # GET /admin/guest_books
  # GET /admin/guest_books.json
  def index
    @admin_guest_books = GuestBook.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @guest_books }
    end
  end
  
  # GET /admin/guest_books/1
  # GET /admin/guest_books/1.json
  def show
    @admin_guest_book = GuestBook.find(params[:id])
    @admin_guest_book_comment=@admin_guest_book.guest_book_comment.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @guest_book }
    end
  end
  
  # GET /admin/guest_books/new
  # GET /admin/guest_books/new.json
  def new
    @admin_guest_book = GuestBook.new
    @admin_guest_book.build_guest_book_content
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @guest_book }
    end
  end

  # GET /admin/guest_books/1/edit
  def edit
    @admin_guest_book = GuestBook.find(params[:id])
  end
  
  # POST /admin/guest_books
  # POST /admin/guest_books.json
  def create
    @admin_guest_book = GuestBook.new(params[:guest_book])
    
    if current_user
      @admin_guest_book.user_id=current_user.id
    end
    
    respond_to do |format|
      if @admin_guest_book.save
        format.html { redirect_to admin_guest_books_url, :notice => '방명록이 작성되었습니다.' }
        format.json { render :json => @admin_guest_book, :status => :created, :location => @admin_guest_book }
      else
        format.html { render :action => "new" }
        format.json { render :json => @admin_guest_book.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /admin/guest_books/1
  # PUT /admin/guest_books/1.json
  def update
    @admin_guest_book = GuestBook.find(params[:id])
    
    respond_to do |format|
      if @admin_guest_book.update_attributes(params[:guest_book])
        format.html { redirect_to admin_guest_books_url, :notice => '방명록이 수정되었습니다.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @admin_guest_book.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /admin/guest_books/1
  # DELETE /admin/guest_books/1.json
  def destroy
    @admin_guest_book = GuestBook.find(params[:id])
    @admin_guest_book.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_guest_books_url }
      format.json { head :ok }
    end
  end
end
