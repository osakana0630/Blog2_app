class ArticlesController < ApplicationController

  def index
    @article = Article.all.order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    #@article.user_id = current_user.id
    if @article.save
      redirect_to root_path, notice: "「#{@article.title}」が投稿されました。"
    else
      render :new, alert: "投稿に失敗しました。"
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to root_path, notice: "「#{@article.title}」が更新されました"
    else
      render :edit, alert: "更新に失敗しました。"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to root_path, notice: '削除しました。'
    else
      render :root_path, alert: '削除に失敗しました。'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :image)
  end

  end

