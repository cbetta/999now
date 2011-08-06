class AuthorisationsController < ApplicationController

  def index 
    redirect_to root_url
  end

  # GET /authorisations/new
  # GET /authorisations/new.json
  def new
    @authorisation = Authorisation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authorisation }
    end
  end  
  
  # GET /authorisations/1/edit
  def edit
    @authorisation = Authorisation.find(params[:id])
  end
  
  def test
    redirect_to root_url, :notice => "This is a warning"
  end

  # POST /authorisations
  # POST /authorisations.json
  def create
    @authorisation = Authorisation.new(params[:authorisation])

    respond_to do |format|
      if @authorisation.save
        format.html { redirect_to edit_authorisation_path(@authorisation) }
        format.json { render json: @authorisation, status: :created, location: @authorisation }
      else
        format.html { render action: "new" }
        format.json { render json: @authorisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /authorisations/1
  # PUT /authorisations/1.json
  def update
    @authorisation = Authorisation.find(params[:id])
    respond_to do |format|
      if @authorisation.confirmation_code == params[:authorisation][:code].upcase
        @authorisation.confirmed = true
        @authorisation.save
        Messenger.send(self.phone_number, "You are now setup as a 999now responder. Text STOP at any time to unsubscribe.", true)
        
        format.html { redirect_to root_url, notice: 'You are now setup as a <strong>999now</strong> responder.' }
        format.json { head :ok }
      else
        @authorisation.errors['code'] =  "is not valid."
        format.html { render action: "edit" }
        format.json { render json: @authorisation.errors, status: :unprocessable_entity }
      end
    end
  end
    # 
    # # DELETE /authorisations/1
    # # DELETE /authorisations/1.json
    # def destroy
    #   @authorisation = Authorisation.find(params[:id])
    #   @authorisation.destroy
    # 
    #   respond_to do |format|
    #     format.html { redirect_to authorisations_url }
    #     format.json { head :ok }
    #   end
    # end
end
