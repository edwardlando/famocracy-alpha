class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(params[:job])

    respond_to do |format|
      @employer = User.find(@job.employer_id)
      if @employer.artist?
        @employer = @employer.artist
      else
        @employer = @employer.agent
      end
      if @employer.money < @job.pay
        format.html { redirect_to '/jobs/new', notice: 'You do not have enough money to make that job.' }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      elsif @job.save
        @employer.update_attributes(:money => @employer.money - @job.pay)
        format.html { redirect_to jobs_url, notice: 'Job was successfully created.' }
        format.json { render json: jobs_url, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /jobs/1
  # PUT /jobs/1.json
  def accept
    if current_user.nil?
      respond_to do |format|
        format.html { redirect_to jobs_url, notice: 'You must be signed in to accept a job.' } # index.html.erb
        format.json { render json: Jobs.all }
      end
    end
    
    @job = Job.find(params[:id])
    if current_user.id.eql?(@job.employer_id)
      respond_to do |format|
        format.html { redirect_to jobs_url, notice: 'You cannot accept your own job' } # index.html.erb
        format.json { render json: Jobs.all }
      end
    else
      respond_to do |format|
        @job.update_attributes(:employee_id => current_user.id)
        @notification = Notification.new({:subject => "Your job has been accepted!", 
          :description => "FILL IN LATER", :read => false, 
          :user_id => @job.employer_id})
        @notification.save
        format.html { redirect_to jobs_url, notice: 'Successfully accepted this job. '} # index.html.erb
        format.json { render json: Jobs.all }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully accepted.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /jobs/1/
  # PUT /jobs/1.json
  def completed
    @job = Job.find(params[:id])
    if @job.employer_id.eql?(current_user.id)
      # pay the user the money for completing the job
      @employee = User.find(@job.employee_id)
      @employee = @employee.specific
      @employee.update_attributes(:money => @employee.money + @job.pay)
      
      # notify the employee that he got paid
      @notification = Notification.new({:subject => "Congratulations on completing a job!", 
        :description => "You have completed a job and have been paid for it.", 
        :read => false, :user_id => @job.employee_id})
      @notification.save
      
      @job.destroy
      respond_to do |format|
        format.html { redirect_to jobs_url}
        format.json { head :no_content }
      end
      
    else
      respond_to do |format|
        format.html { redirect_to jobs_url, notice: 'You cannot edit this job.'}
        format.json { head :no_content }
      end
    end
  end
  
  # PUT /jobs/1/
  # PUT /jobs/1.json
  def incompleted
    @job = Job.find(params[:id])
    # refund the employer his money if he deletes the job
    @employer = User.find(@job.employer_id)
    @employer = @employer.specific
    @employer.update_attributes(:money => @employer.money + @job.pay)
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
  
  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    # refund the employer his money if he deletes the job
    @employer = User.find(@job.employer_id)
    @employer = @employer.specific
    @employer.update_attributes(:money => @employer.money + @job.pay)
    @job.destroy
    
    # do something about sending a notification of a jury trial, 
    # plus actually doing the trial
    
    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
end
