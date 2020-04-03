class ArticlesController < ApplicationController

  #ログインしていないとアクションを実行できない
  before_action :authenticate_user!
  #記事の投稿者以外の人が編集、更新、削除できないようにフィルタリング
  before_action :validate_user, only:[:update, :destroy, :edit]
  #アクションの共通部分を共通化
  before_action :set_article, only:[:show, :destroy, :edit, :update]



  def index
    @article = Article.all.order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to root_path, notice: "「#{@article.title}」が投稿されました。"
    else
      render :new, alert: "投稿に失敗しました。"
    end
  end

  def show
  end

  def update
    if @article.update(article_params)
      redirect_to root_path, notice: "「#{@article.title}」が更新されました"
    else
      render :edit, alert: "更新に失敗しました。"
    end
  end

  def edit
  end

  def destroy
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

  def validate_user
    @article = Article.find(params[:id])
    unless @article.user == current_user
      redirect_to root_path, alert: "他のユーザーの投稿です"
    end
  end

    def set_article
      @article = Article.find(params[:id])
    end

  end

