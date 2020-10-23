class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/'
    redirect '/recipes' 
  end

  get '/recipes' do 
    @recipes = Recipe.all 
    erb :index
  end 

  get '/recipes/new' do 
    erb :new
  end 
  
  post '/recipes' do 
    @recipes = Recipe.create(name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]).tap do |recipe|
        recipe.save
        redirect to "/recipes/#{@recipe.id}"
      end
  end

  get 'recipes/:id' do 
    @recipe = Recipe.find_by(id: params[:id])
    erb :show
  end 

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit
  end 

  patch '/recipes/:id' do
    Recipe.find_by(id: params[:id]).tap do |recipe|
      recipe.update(name: params[:name],
        ingredients: params[:ingredients],
        cook_time: params[:cook_time])
    
      redirect to "/recipes/#{recipe.id}"
    end
  end 

  delete '/recipes/:id/delete' do 
    Recipe.find_by(id: params[:id]).destroy
    redirect '/recipes'
  end 

end 
