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
    @pet = Pet.create(name: params[:pet_name])
    if params[:owner_name].length > 0 
      new_owner = Owner.create(name: params[:owner_name])
      new_owner.pets << @pet 
    else 
      Owner.find_by_id(params[:owner_id]).pets << @pet 
    end 
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all 
    erb :'/pets/edit'
  end

 patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet_name]
    if params[:owner][:name].length > 0 
      new_owner = Owner.create(name: params[:owner][:name])
      new_owner.pets << @pet 
    else 
      owner = Owner.find(params[:owner_id])
      owner.pets << @pet 
    end 
    redirect to "pets/#{@pet.id}"
  end
end