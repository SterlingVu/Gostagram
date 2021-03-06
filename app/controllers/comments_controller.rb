class CommentsController < ApplicationController
  before_action :set_micropost

  def create
    @comment = @micropost.comments.build(comment_params.merge(user_id: current_user.id))
    @comment.save!

    respond_to do |format|
      format.html { redirect_to @comment }
      format.js { render layout: false }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @micropost, notice: 'Your comment was successfully deleted' }
      format.js { render layout: false }
    end
  end

  def show_menu
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
