class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    #In this case, since I'm getting a listing of ALL articles in the database, I'll call this instance variable plural @articles
    #to indicate a list rather than one article
    #bootstrap paginate gem gives the ability to break whole database listing of articles into paginated sections
    #Take note of the pagination statement below, the params (page: params[:page]) defaults to like 20 or 30 but you can customize
    #   the number of items per page by specifying ..., per_page: 5) to limit it for small databases or for no data in your database
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def create
    #debugger  If need on the fly debugging - un comment debugger and you can utilize the server win like rails console
    #render plain: params[:article].inspect  -- This was a first step to see what happened to the params created in the new form (Not needed, but good to know)
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else            #else means IF the @article.save failed, then our database validations failed and we must now detect what's wrong
      render 'new'
      #render :new  -- :new is also valid, the instructor prefers render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show

  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  def edit

  end

  private
    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
