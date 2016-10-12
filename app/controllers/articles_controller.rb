class ArticlesController < ApplicationController

  def all
    # @users = current_user
    if signed_in?
      @user = current_user
    end
    @articles = Article.order(created_at: :desc)
  end

  def index
    if signed_in?
      @user = User.find(params[:user_id])
      @article = @user.articles.build
      render :action => 'index'
    else
      deny__access
    end
  end

  def show
    if signed_in?
      @user = User.find(params[:user_id])
      @article = @user.articles.find(params[:id])
      # @article = Article.find(params[:id])
      render :action => 'show'
    else
      deny__access
    end
  end

  def new
  end

  def edit
    if signed_in?
      @user = User.find(params[:user_id])
      @article = @user.articles.find(params[:id])
      # @article = Article.find(params[:id])
      render :action => 'index'
    else
      deny__access
    end
    # redirect_to user_articles_path(@user, @article)
  end

  def update
    if signed_in?
      @user = User.find(params[:user_id])
      @article = Article.find(params[:id])
      if  @article.update_attributes(article_params)
        redirect_to user_articles_path(@user)
      else
        render :action => 'index'
      end
    else
      deny__access
    end

  end

  def create
    if signed_in?
      @user = User.find(params[:user_id])
      @article = @user.articles.create(article_params)
      if @article.errors.any?
        render :action => 'index'
      else
        redirect_to user_articles_path(@user)
      end
      # render 'users/show'
      #render :action => 'index'
    else
      deny__access
    end
  end

  def destroy
    if signed_in?
      @user = User.find(params[:user_id])
      @article = @user.articles.find(params[:id])
      @article.destroy
      redirect_to user_articles_path(@user)
    else
      deny__access
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
