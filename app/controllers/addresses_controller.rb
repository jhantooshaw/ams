class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_contact
   
  def new
    @address = @addressable.addresses.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address }
    end
  end
  
  def create
    @address = @addressable.addresses.build(address_params)    
    respond_to do |format|
      if @address.save
        if params[:user_id]
          format.html { redirect_to user_address_path(@addressable,@address), notice: 'Address was successfully created.' }
        elsif params[:contact_id]
          format.html { redirect_to contact_address_path(@addressable,@address), notice: 'Address was successfully created.' }
        end
        
        format.json { render json: @address, status: :created, location: @address }
      else
        format.html { render action: "new" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @address = @addressable.addresses.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @address }
    end
  end  
  
  def edit
    @address = @addressable.addresses.find(params[:id])
  end
  
  def update
    @address = @addressable.addresses.find(params[:id])

    respond_to do |format|
      if @address.update_attributes(address_params)
        if params[:user_id]
          format.html { redirect_to user_address_path(@addressable,@address), notice: 'Address was successfully updated.' }
        elsif params[:contact_id]
          format.html { redirect_to contact_address_path(@addressable,@address), notice: 'Address was successfully updated.' }
        end
        
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @addressable.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @address = @addressable.addresses.find(params[:id])
    @address.destroy
    respond_to do |format|
      format.html { redirect_to @addressable, notice: 'Address was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  
  
  private
  def get_contact
    if params[:contact_id]
      @addressable = current_user.contacts.find(params[:contact_id])
    elsif params[:user_id]
      @addressable = User.find(params[:user_id])
    end    
  end
  
  def address_params
    params.require(:address).permit(:address, :city, :state, :country, :pin, :other_info, :is_active)
  end
end
