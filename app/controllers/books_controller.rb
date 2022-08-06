class BooksController < ApplicationController
  def new
    @book = Book.new
  end
   # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
   if @book.save
  		redirect_to books_path(@book.id), notice: "Book was successfully created."
   else
      @books = Book.all
      render :books
   end
  end
   # 投稿データの保存

  def edit
     @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "Book was successfully updated."
   else
      render :edit
   end
  end

  def index
    @books = Book.all
    @book = Book.new(book_params)
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
   if @book.destroy  # データ（レコード）を削除
    redirect_to books_path(:id), notice: "Book was successfully destroyed."# 投稿一覧画面へリダイレクト
   end
  end

   # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
