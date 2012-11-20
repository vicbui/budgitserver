class ApplicationController < ActionController::Base
  protect_from_forgery
   def index

	    @response= Hash.new    


   		@data=JSON.parse(params['myDATA']);
	    @info = Hash.new
	    @info = @data['info'];
	    @info['syncDate']= Time.now.to_i;
	    @client_change=@data['data']


		@user= User.find_by_username_and_email(@data['info']['username'],@data['info']['email']);
		if (@user==nil)
			@user = User.new(:username => @data['info']['username'], :email => @data['info']['email'], :password => @data['info']['password'])
			@user.save
		else
		end

		if (@info['firstSync'])
			@device= Device.new(:name=>"iphone",:uuid=>"",:user_id=>@user.id)
			@device.serverid= SecureRandom.urlsafe_base64
			while !@device.save # if at first it didn't save...
			    @device.serverid = SecureRandom.urlsafe_base64 # try, try again
			end #
		    @response['serverid'] = @device.serverid

		end


		@change = Hash.new
		@cats=Cat.find(:all,:conditions => ["user_id=? AND CAST(strftime('%s',updated_at) as integer) > ? ",@user.id,@info['lastSyncDate']])
	  	@change['cat'] = Array.new
	  	@cats.each do |aCat|
	   		@newCat= aCat.attributes
	   		@newCat.delete('id')
	   		@newCat.delete('user_id')
	   		@change['cat'].push(@newCat)
	   	end
	   if (@client_change==nil)
	   else
	  		@client_cat=@client_change['cat']
	  		@client_cat.each do |aCat|
				if (@info['firstSync'])
					aCat['shared_id']=aCat['shared_id']+"_"+@device.serverid
				end		
	  			@newCat = Cat.find(:first,:conditions => ["user_id =? AND shared_id =?",@user.id,aCat['shared_id']])
	  			@existingCat= Cat.find_by_name_and_user_id(aCat['name'],@user.id);
	  			if (@existingCat==nil)
	  			#.find_by_name_and_user_id_and_upda(aCat['id'],@user.id)
		  			if (@newCat==nil)
		  				 	@newCat= Cat.new(:name => aCat['name'], :user_id => @user.id, :shared_id => aCat['shared_id'], :created_at => Time.at(@info['syncDate']), :updated_at => Time.at(@info['syncDate']))
		  			else	  				
		  				@newCat['name'] = aCat['name']
		  				@newCat['user_id'] = @user.id
		  				@newCat['shared_id'] = aCat['shared_id']
		  				@newCat['updated_at'] = Time.at(@info['syncDate'])
		  			end
					@newCat.save
				end
	  		end

	   end

	    @response['result']="OK"     
	    @response['message']="Data updated successfully in server"
	    @response['data']=@change
	    @response['syncDate']=@info['syncDate']

	    render json:@response 
   end
end
