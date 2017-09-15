class ContactsController < ApplicationController  
  def index
    @contacts = current_user.contacts.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cotacts }
    end
  end
  
  def new
    @contact = Contact.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end
  
  def create
    @contact = current_user.contacts.build(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @contact = current_user.contacts.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end
  
  def edit
    @contact = current_user.contacts.find(params[:id])
  end
  
  def update
    @contact = current_user.contacts.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  def search
    serchd_data = Contact.where("name like ?", "%#{params[:q].downcase}%")
		render json: serchd_data.as_json(only: [:name, :id])
  end
  
  
  private
  def contact_params
    params.require(:contact).permit(:user_id, :name, :email, :mobile_number_1, :mobile_number_2, :mobile_number_3)
  end
  
end
