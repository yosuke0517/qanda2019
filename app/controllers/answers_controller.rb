class AnswersController < ApplicationController
  before_action :login_requered ,only: [:edit, :update, :destroy, :create]


  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    if @answer.save
      #該当のQuestionのupdated_atを更新する
      @question.touch
      flash[:success] = '回答を投稿しました。'
    else
      flash[:danger] = '回答の投稿に失敗しました。'
    end
    redirect_to question_path(@question)
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    if @answer.update(answer_params)
      #該当のQuestionのupdated_atを更新する
      @question.touch
      flash[:success] = '回答の編集をしました。'
      redirect_to question_path(@question)
    else
      flash[:danger] = '回答の編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    flash[:info] = '回答を削除しました。'
    redirect_to question_path(@question)
  end

  private
  def answer_params
    params.require(:answer).permit(:content, :name, :question_id, :user_id, :author)
  end

  def login_requered
    unless current_user
      flash[:info] = 'ログインまたはサインアップをしてください。'
      redirect_to login_path
    end

  end
end
