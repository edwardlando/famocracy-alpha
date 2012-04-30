class MyDevise::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(params[:user])
    @user.save
    if (params[:type].eql?("artist"))
      @artist = Artist.new({:user => @user, :money => 0, :level => 0})
      @artist.save
      @user.update_attributes({:agent => nil, :artist => @artist})
      @user.save
    else
      @agent = Agent.new({:user => @user, :money => 0, :level => 0})
      @agent.save
      @user.update_attributes({:agent => @agent, :artist => nil})
      @user.save
    end

    respond_to do |format|
        sign_in(resource_name, resource)
        format.html { redirect_to "/home/registered"}
    end
  end
end