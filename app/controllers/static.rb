enable :sessions

get '/' do
	session[:path] = request.fullpath
	erb :"static/index"	
end

get '/login' do
	session[:id]=nil
	if logged_in?
		redirect '/'
	else
		erb :"user/login"
	end
end

get '/signup' do
	erb :"user/signup"
end

get '/profile' do
	if logged_in?
		@user=current_user
		erb :'user/user_profile'
	else
		flash[:message]="Please log in"
		redirect '/login'
	end
end

get '/question/:id' do
	@question=Question.find(params[:id])
	session[:question_id]=params[:id]
	session[:path] = request.fullpath
	erb :"/static/question"
end

get '/:id/user_question' do
	@user = User.find(params[:id])
	session[:path] = request.fullpath
	erb :"/user/user_questions"
end

get '/:id/user_answer' do
	@user = User.find(params[:id])
	session[:path] = request.fullpath
	erb :"/user/user_answers"
end

get '/qupvote/:id' do
	voted = false
	current_user.questionvotes.each do |qv|
		if qv.question.id == params[:id].to_i
			if qv.vote_type == true
				qv.delete
				voted = true
				break;
			end
			break if voted == true
		end
	end
	Questionvote.create(question_id: params[:id],user_id: current_user.id, vote_type: true) if !voted
	redirect session[:path]
end

get '/qdownvote/:id' do
	voted = false
	current_user.questionvotes.each do |qv|
		if qv.question.id == params[:id].to_i
			if qv.vote_type == false
				qv.delete
				voted = true
				break;
			end
			break if voted == true
		end
	end
	Questionvote.create(question_id: params[:id],user_id: current_user.id, vote_type: false) if !voted
	redirect session[:path]
end

get '/aupvote/:id' do
	voted = false
	current_user.answervotes.each do |av|
		if av.answer.id == params[:id].to_i
			if av.vote_type == true
				av.delete
				voted = true
				break;
			end
			break if voted == true
		end
	end
	Answervote.create(answer_id: params[:id],user_id: current_user.id, vote_type: true) if !voted
	redirect session[:path]
end

get '/adownvote/:id' do
	voted = false
	current_user.answervotes.each do |av|
		if av.answer.id == params[:id].to_i
			if av.vote_type == false
				av.delete
				voted = true
				break;
			end
			break if voted == true
		end
	end
	Answervote.create(answer_id: params[:id],user_id: current_user.id, vote_type: false) if !voted
	redirect session[:path]
end

post '/question' do
	question = Question.create(text: params[:question])
	question.update(user_id: current_user.id) if logged_in?
	session[:path] = request.fullpath
	redirect '/'
end

post "/edit_profile" do
	current_user.update_columns(name: params[:name],email: params[:email])
	session[:path] = request.fullpath
	redirect '/profile'
end

post '/answer' do 
	answer=Answer.create(text: params[:answer],question_id: session[:question_id])
	answer.update(user_id: current_user.id) if logged_in?
	session[:path] = request.fullpath
	redirect "/question/#{answer.question_id}"
end