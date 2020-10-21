class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    #goes to index
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    #displays a form to create a new recipe
    erb :new
  end

  post '/recipes' do
    #creates one article
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    #displays one recipe based on ID
    @recipe = Recipe.find_by(params)
    erb :show
  end

  get '/recipes/:id/edit' do
    #displays edit form for a recipe based on the ID
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    #modifies an existing recipe then redirects to that recipe
    recipe = Recipe.find_by(id: params[:id])
    recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    #deletes the article
    recipe = Recipe.find_by(id: params[:id])
    recipe.destroy
  end

end
