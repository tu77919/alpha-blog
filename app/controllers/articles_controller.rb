class ArticlesController < ApplicationController
  
  def new
    @article = Article.new
  end
  
  def create
    #render plain: params[:article].inspect  -- This was a first step to see what happened to the params created in the new form (Not needed, but good to know)
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else            #else means IF the @article.save failed, then our database validations failed and we must now detect what's wrong
      render 'new'
      #render :new  -- :new is also valid, the instructor prefers render 'new'
    end
  end
  def show
    @article = Article.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
