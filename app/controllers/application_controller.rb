class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/'
    erb :index 
  end

  get '/recipes/new' do 
    erb :new
  end 
  
  post '/recipes' do 
    @recipes = Recipe.create(:name => params[:name])
    redirect to "/recipes/#{@recipe.id}"
  end

end
