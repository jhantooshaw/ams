class FundTransfersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @fts = current_user.fund_transfers.paginate(:page => params[:page])    
    @tot_cr, @tot_dr, @tot_dp, @tot_ln = current_user.monthly_transactions    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fts }
    end
  end
  
  def new
    @ft = FundTransfer.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ft }
    end
  end
  
  def create
    @ft = current_user.fund_transfers.build(fund_transfer_params)
    respond_to do |format|
      if @ft.save
        format.html { redirect_to @ft, notice: 'Trasfer was successfully made.' }
        format.json { render json: @ft, status: :created, location: @ft }
      else
        puts @ft.errors.messages
        format.html { render action: "new" }
        format.json { render json: @ft.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @ft = current_user.fund_transfers.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ft }
    end
  end
  
  def edit
    @ft = current_user.fund_transfers.find(params[:id])
  end
  
  def update
    @ft = current_user.fund_transfers.find(params[:id])
    respond_to do |format|
      if @ft.update_attributes(fund_transfer_params)
        format.html { redirect_to @ft, notice: 'Fund transfer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ft.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def destroy
    @ft = current_user.fund_transfers.find(params[:id])
    @ft.destroy
    respond_to do |format|
      format.html { redirect_to fund_transfers_path, notice: 'Fund was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  
  private
  def fund_transfer_params
    params.require(:fund_transfer).permit(:contact_id, :to_other, :asset_type, :amount, :transaction_number, :transaction_date)
  end
  
  
end
