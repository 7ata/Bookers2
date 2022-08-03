class BooksController < ApplicationController
  def new
    @book = Book.new
  end
   # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path
  end
  
  def edit
  end
  
  def index
  end

  def show
    @book = Book.find(params[:id])  
  end

  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
   if @book.destroy  # データ（レコード）を削除
    redirect_to books_path, notice: "Book was successfully destroyed."# 投稿一覧画面へリダイレクト  
   end
  end
  
   # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:book).permit(:title, :body)
  end
end
