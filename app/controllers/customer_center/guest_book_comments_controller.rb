# encoding: utf-8

class CustomerCenter::GuestBookCommentsController < AnonCommentController
  before_action :set_guest_book_comment, only: [:show, :edit, :update, :destroy]  
  
  def show   
    @parent=@guest_book_comment.guest_book
    return @guest_book_comment
  end
  
  def edit
    @guest_book = @guest_book_comment.guest_book
    return @guest_book_comment
  end
  
  def create
    @guest_book = GuestBook.find(params[:guest_book_id])
    if current_user
      params[:guest_book_comment][:user_id]=current_user.id
    end
    
    respond_to do |format|
      if Rails.env.production? 
        if current_user
          @guest_book_comment=@guest_book.guest_book_comment.create(guest_book_comment_params)
        else
          @guest_book_comment=verify_recaptcha(:model => @guest_book_comment, :message => "Oh! It's error with reCAPTCHA!") && @guest_book_comment.guest_book_comment.create(guest_book_comment_params)
        end
      else
        @guest_book_comment=@guest_book.guest_book_comment.create(guest_book_comment_params)
      end
      
      if @guest_book_comment
        format.html { redirect_to @guest_book, :notice=> @controller_name +t(:message_success_create)}
        format.json { render :json => @guest_book, :status => :created, :location => @guest_book }
      else
        format.html { render :action => "new" }
        format.json { render :json => @guest_book.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update    
    respond_to do |format|
      if @guest_book_comment.update_attributes(guest_book_comment_params)
        format.html { redirect_to @guest_book_comment.guest_book, :notice=> @controller_name +t(:message_success_update) }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @guest_book_comment.errors, :status => :unprocessable_entity }
      end
    end
  end  
 
  def destroy
    @guest_book_comment.destroy
    redirect_to guest_book_path(@guest_book_comment.guest_book)
  end
  
  protected
  
  def get_gg 
    return set_guest_book_comment
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_guest_book_comment
    @guest_book_comment=GuestBookComment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def guest_book_comment_params
    params.require(:guest_book_comment).permit(:id,:user_id,:guest_book_id,:name,:salt,:password,:content)
  end  
end
