require 'rails_helper'

describe 'QandA管理機能', type: :system do
  # ユーザA,Bを定義
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a0@email.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b0@email.com') }
  let!(:question_a) { FactoryBot.create(:question, name: 'name',title: 'test question A',content: 'test Aだよ',author: 'ユーザA',user: user_a) }

    before do

      # 共通化したログイン処理
      ### ログイン画面へのアクセス
      visit login_path
      ### メールアドレスを入力
      fill_in 'メールアドレス', with: login_user.email
      ### パスワードの入力
      fill_in 'パスワード', with: login_user.password
      ### 「ログインするボタンを押す」
      click_button 'ログインする'

    end
    # 共通処理〜ユーザAの質問が表示されること〜
    shared_examples_for 'ユーザAの投稿した質問が表示される' do
      it { expect(page).to have_content 'test question A' }
    end

  describe '質問一覧表示機能' do

    context 'ユーザAがログインしているとき' do
      # letでlogin_user(ログインユーザ)を定義（user_aを使用）
      let(:login_user) { user_a }

      it_behaves_like 'ユーザAの投稿した質問が表示される'

      # it '質問が表示される' do
      #   # ユーザAが作成した質問のみ編集・削除ボタンが表示されている
      #   expect(page).to have_content('test question A')
      # end

      it '編集ボタンが表示される' do
        expect(page).to have_content('編集')
      end

    end

    context 'ユーザBでログインしているとき（ユーザBの作成した質問がない場合）' do
      # letでlogin_user(ログインユーザ)を定義（user_bを使用）
      let(:login_user) { user_b }

      it '編集・削除ボタンは表示されない' do
        #質問一覧は表示されるが、作成者がユーザBの質問はないので編集・削除ボタンが表示されないことを確認する。
        expect(page).to have_no_content('編集')
      end

    end
  end

  describe '質問詳細表示機能' do
    context 'ユーザAがログインしている時' do
      let(:login_user) { user_a }

      before do
        visit question_path(question_a)
      end
      it 'ユーザAが作成した質問の詳細画面が表示されること' do
        expect(page).to have_content('test question A')
      end
      #it_behaves_like 'ユーザAの投稿した質問が表示される'

    end
  end

  # describe '質問新規投稿機能' do
  #   #ユーザAでログイン
  #   let(:login_user) { user_a }
  #
  #   before do
  #     visit new_question_path
  #     fill_in 'question[title]', with: question_title
  #     fill_in 'question[content]', with: question_content
  #     #fill_in_ckeditor( 'ck-blurred', :with => 'This is my message!')
  #     click_button 'Save'
  #
  #   end
  #   context '質問新規作成画面で質問を投稿する' do
  #     let(:question_title) { 'test question title' }
  #     let(:question_content) { 'test question content' }
  #
  #     it '投稿が成功する' do
  #       expect(page).to have_selector '.alert-success', text: '質問を投稿しました。。'
  #     end
  #
  #
  #   end
  #
  # end

end
