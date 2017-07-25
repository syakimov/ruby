class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
  end

  def create
    @article = Article.new(articles_params)

    @article.save
    redirect_to @article
  end

  private

  # Rails `strong parameters`
  # http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  def articles_params
    params.require(:article).permit(:title, :text)
  end
end
