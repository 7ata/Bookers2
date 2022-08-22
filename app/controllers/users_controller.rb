class UsersController < ApplicationController

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def create
    @user = User.new(user_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
   if @user.save
  		redirect_to users_path(@user.id), notice: "User was successfully created."
   else
      @users = User.all
      render :users
   end

   @book = Book.new(book_params)
   @book.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
   if @book.save
  		redirect_to book_path(@book.id), notice: "Book was successfully created."
   else
      @books = Book.all
      render :index
   end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "User was successfully updated."
   else
      render :edit
   end
  end


  def destroy
    @user = User.find(params[:id])  # データ（レコード）を1件取得
   if @user.destroy  # データ（レコード）を削除
    redirect_to users_path, notice: "User was successfully destroyed."# 投稿一覧画面へリダイレクト
   end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :profile_image, :introduction)
  end
end
