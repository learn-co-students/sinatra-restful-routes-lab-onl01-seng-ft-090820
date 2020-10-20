class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # index
  get '/recipes' do
    @recipes = Recipe.all
    erb :'recipes/index'
  end

  # create
  get '/recipes/new' do
    erb :'recipes/new'
  end
  
  post '/recipes' do
    # binding.pry
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to("/recipes/#{recipe.id}")
  end

  # show
  get '/recipes/:id' do
    find_recipe
    erb :'recipes/show'
  end

  # edit
  get '/recipes/:id/edit' do
    find_recipe
    erb :'recipes/edit'
  end

  patch '/recipes/:id' do
    find_recipe
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to("/recipes/#{@recipe.id}")
  end

  # delete
  delete '/recipes/:id' do
    find_recipe
    @recipe.delete
    redirect to("/recipes")
  end

  private
  def find_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

end
