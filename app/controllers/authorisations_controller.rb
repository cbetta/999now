class AuthorisationsController < ApplicationController

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

  # POST /authorisations
  # POST /authorisations.json
  def create
    @authorisation = Authorisation.new(params[:authorisation])

    respond_to do |format|
      if @authorisation.save
        format.html { redirect_to edit_authorisation_path(@authorisation), notice: 'Authorisation was successfully created.' }
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
      if @authorisation.update_attributes(params[:authorisation])
        format.html { redirect_to @authorisation, notice: 'Authorisation was successfully updated.' }
        format.json { head :ok }
      else
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
