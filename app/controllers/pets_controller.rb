
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if !params[:owner][:name].empty?
      @pet = Pet.new(params[:pet])
      @owner = Owner.create(params[:owner])
      @owner.pets << @pet
    else
      @pet = Pet.create(params[:pet])
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets' do 
    @pet = Pet.find(params[:pet][:id]) 
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner])
      @owner.pets << @pet
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end
end