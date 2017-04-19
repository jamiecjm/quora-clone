enable :sessions

get '/' do
	erb :"static/index"	
end

get '/login' do
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
		redirect '/login'
	end
end

get '/question/:id' do
	@question=Question.find(params[:id])
	session[:question_id]=params[:id]
	erb :"/static/question"
end

get '/:id/user_question' do
	@user = User.find(params[:id])
	erb :"/user/user_questions"
end

get '/:id/user_answer' do
	@user = User.find(params[:id])
	erb :"/user/user_answers"
end

post '/question' do
	question = Question.create(text: params[:question])
	question.update(user_id: current_user.id) if logged_in?
	redirect '/'
end

post "/edit_profile" do
	current_user.update_columns(name: params[:name],email: params[:email])
	redirect '/profile'
end

post '/answer' do 
	answer=Answer.create(text: params[:answer],question_id: session[:question_id])
	answer.update(user_id: current_user.id) if logged_in?
	redirect "/question/#{answer.question_id}"
end