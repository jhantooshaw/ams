class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_contact
   
  def new
    @address = @contact.addresses.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address }
    end
  end
  
  def create
    @address = @contact.addresses.build(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to contact_address_path(@contact,@address), notice: 'Address was successfully created.' }
        format.json { render json: @address, status: :created, location: @address }
      else
        format.html { render action: "new" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @address = @contact.addresses.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @address }
    end
  end  
  
  def edit
    @address = @contact.addresses.find(params[:id])
  end
  
  def update
    @address = @contact.addresses.find(params[:id])

    respond_to do |format|
      if @address.update_attributes(address_params)
        format.html { redirect_to contact_address_path(@contact,@address), notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @address = @contact.addresses.find(params[:id])
    @address.destroy
    respond_to do |format|
      format.html { redirect_to @contact, notice: 'Address was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  
  
  private
  def get_contact
    @contact = current_user.contacts.find(params[:contact_id])
  end
  
  def address_params
    params.require(:address).permit(:address, :city, :state, :country, :pin, :other_info, :is_active)
  end
end
