class ApplicationController < ActionController::Base
    helper_method :current_user
    #before_action :set_search
    private

    def current_user
        #セッションidからログインしているユーザを求める。
        #変数@current_userの値がnilなら代入するが、nilでなければ代入しない (@current_userの値を変えない)
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def set_search
        # viewの検索窓からの入力値（今回はタイトル（後述））をキーに検索オブジェクトを作成
        @search = Question.ransack(params[:q])
        # resultメソッドで結果を得られる（ページングを指定している）
        @questions_count = @search.result(distinct: true).page(params[:page]).per(Settings.service.PER).order('updated_at DESC')
    end

end
