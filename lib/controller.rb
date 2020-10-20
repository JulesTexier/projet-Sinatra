
require 'bundler'
require 'gossip'
Bundler.require

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

#envoie vers la route de la page de création de Gossipe
  get '/gossips/new/' do
    erb :new_gossip
  end
  
#envoie vers la route de la page du Gossipe N°...
  get '/gossips/:id' do
      erb :show, locals: {gossips: Gossip.find(params['id'])}
  end

#récupère les infos du formulaire de création de Gossip
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

#envoie vers la route de la page d'edition du gossip...
  get '/gossips/:id/edit/' do
    erb :edit
  end

#récupère les infos du formulaire d'édition du Gossip
  post '/gossips/:id/edit/' do
    Gossip.update(params['id'], params["edit_author"], params["edit_content"])
    redirect '/'
  end


end