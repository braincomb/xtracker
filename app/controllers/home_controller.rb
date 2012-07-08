class HomeController < ApplicationController
before_filter :check_ref

  def check_ref
    if ( request.headers['referer'] =~ /facebook/ )
      # change this logic
    else
      redirect_to CALLBACK_URL + "/" + request.path_parameters[:controller] + "/" + request.path_parameters[:action] and return
    end
  end

  def index
    @oauth = Koala::Facebook::OAuth.new
    if (session[:access_token].blank?)
      @signed_request = @oauth.parse_signed_request(params[:signed_request])
      if @signed_request["user_id"]  
        @graph = Koala::Facebook::API.new(@signed_request["oauth_token"])
      else
        render :partial => "oauth_redirect" and return
      end 
    end

    userid = @signed_request["user_id"]
    @current_friends = @graph.get_connections(userid, "friends")

    u = User.new(:name => @graph.get_object(userid)['name'], :fbid => userid)
    if u.new_record?
      u.save
    end

    @user = User.where(:fbid => userid).first
    @current_friends.each do |cf|
      if Friend.where(:fbid => cf['id'], :user_id => @user.id).exists? == false
        @friend = @user.friends.create(:name => cf['name'], :fbid => cf['id'])
        if @user.deletions.where(:fbid => cf['id']).first
          unless flash[:notice]
            flash[:notice => rand] = @friend['name'] + " has been reunited with you! Hooray!"
          else
            flash[:notice] << @friend['name'] + " has been reunited with you! Hooray!"
          end
        end
      end
    end 

    @saved_friends = (Friend.where(:user_id => @user.id).all).collect { |i| i[:fbid] }
    @current_friends_t = @current_friends.collect { |i| i['id'].to_i }
    @deleted_friends = @saved_friends - @current_friends_t
    @deleted_friends.each do |df|
      @deletion = @user.deletions.create(:name => Friend.where(:fbid => df).first[:name], :fbid => df)
      @unfriend = @user.friends.destroy(Friend.where(:fbid => df, :user_id => @user.id).first)
    end
    @deletions = Deletion.where(:user_id => @user.id).all

    respond_to do |format|
      format.html { }
    end
  end

end
