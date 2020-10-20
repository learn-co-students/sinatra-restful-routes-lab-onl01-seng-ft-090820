class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do 
    @recipes = Recipe.all 
    erb :index
  end 

  get '/recipes/new' do 
    erb :new 
  end 

  post '/recipes' do 
    @recipe = Recipe.create(params)
      redirect "/recipes/#{Recipe.last.id}"
  end 

  get '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    erb :show
  end 

  get '/recipes/:id/edit' do 
    # binding.pry
    @recipe = Recipe.find(params[:id])
    erb :edit
  end 

  patch '/recipes/:id' do 
    @r = Recipe.find(params[:id])
    @r.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@r.id}"
    erb :show
  end 

  delete '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to "/recipes"
    erb :index
  end 

end
