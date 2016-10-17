class ArticlesController < ApplicationController
  before_filter :deny__access, :except => [:all]

  def all
    if signed_in?
      @user = current_user
    end
    @articles = Article.order('created_at DESC').page(params[:page]).per_page(10)

  end

  def index
    @user = User.find(params[:user_id])
    @articles = Article.where('user_id = ?',  @user.id).order('created_at DESC').page(params[:page]).per_page(10)
    @article = @user.articles.build
    render :action => 'index'
  end

  def show
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    render :action => 'show'
  end

  def new
  end

  def edit
    @user = User.find(params[:user_id])
    @articles = Article.where('user_id = ?',  @user.id).order('created_at DESC').page(params[:page]).per_page(10)
    @article = @user.articles.find(params[:id])
    render :action => 'index'
  end

  def update
    @user = User.find(params[:user_id])
    @article = Article.find(params[:id])
    if  @article.update_attributes(article_params)
      redirect_to user_articles_path(@user)
    else
      render :action => 'index'
    end
  end

  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.create(article_params)
    if @article.errors.any?
      render :action => 'index'
    else
      redirect_to user_articles_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    @article.destroy
    redirect_to user_articles_path(@user)
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
