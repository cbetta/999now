class AlarmsController < ApplicationController
  # GET /alarms
  # GET /alarms.json
  def index
   redirect_to new_alarm_path
  end

  # GET /alarms/1
  # GET /alarms/1.json
  def show
    @alarm = Alarm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alarm }
    end
  end

  # GET /alarms/new
  # GET /alarms/new.json
  def new
    @alarm = Alarm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alarm }
    end
  end

  # POST /alarms
  # POST /alarms.json
  def create
    @alarm = Alarm.new(params[:alarm])

    respond_to do |format|
      if @alarm.save
        format.html { redirect_to @alarm, notice: 'Alarm was successfully created. Responders have been notified and will call you soon. Also make sure someone actually called 999. This site is not a replacement for professional emergence services.' }
        format.json { render json: @alarm, status: :created, location: @alarm }
      else
        format.html { render action: "new" }
        format.json { render json: @alarm.errors, status: :unprocessable_entity }
      end
    end
  end
end
