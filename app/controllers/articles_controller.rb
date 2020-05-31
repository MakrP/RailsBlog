class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    cate = params[:cate]
    if(!cate.nil?)
      @articles = Article.where(:category_id =>  cate)
    else
      @articles = Article.all
    end
  end

  def new
    @article = Article.new
  end


  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.user_id = current_user.id
    if @article.update(article_params)
      flash[:notice] = "Article was updated"
      redirect_to article_path(@article)
    else
      flash[:notice] = "Article was not updated"
      render 'edit'
    end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was deleted"
    redirect_to articles_path
  end

  def deleteAll
    @article = Article.all
    @article.each do |ar|
      ar.destroy
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, :category_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end