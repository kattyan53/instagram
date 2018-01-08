class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :page]
  before_action :session_exist, only: [:new, :edit, :show]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    unless params[:cache] == nil
      @blog.image.retrieve_from_cache! params[:cache][:image]
    end
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @user = User.find_by(id: @blog.user_id)
    @comment = Comment.new(comment: params[:comment], blog_id: params[:blog_id], user_id: params[:user_id])
    @comment.save
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
      @blog.destroy
      redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    unless params[:cache] == nil
      @blog.image.retrieve_from_cache! params[:cache][:image]
    end
    render :new if @blog.invalid?
  end

  def session_exist
    if current_user == nil
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end
  private
    def blog_params
    params.require(:blog).permit(:content, :user_id, :image)
    end

    # idをキーとして値を取得するメソッド
    def set_blog
      @blog = Blog.find(params[:id])
    end

end
