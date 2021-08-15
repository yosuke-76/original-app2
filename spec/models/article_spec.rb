require 'rails_helper'
RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end
  describe '新規投稿作成' do
    context '新規投稿が出来る時' do
      it '全ての情報が入力されていれば投稿出来ること' do
        expect(@article).to be_valid
      end
    end
    context '新規投稿が出来ない時' do
      it 'store_nameが空だと投稿できない' do
        @article.store_name = ''
        @article.valid?
        expect(@article.errors.full_messages).to include "Store name can't be blank"
      end
      it 'addressが空だと投稿できない' do
        @article.address = ''
        @article.valid?
        expect(@article.errors.full_messages).to include "Address can't be blank"
      end
      it 'textが空だと投稿できない' do
        @article.text = ''
        @article.valid?
        expect(@article.errors.full_messages).to include "Text can't be blank"
      end
      it '画像が空だと投稿できない' do
        @article.images = nil
        @article.valid?
        expect(@article.errors.full_messages).to include "Images can't be blank"
      end
      it '投稿に紐づくユーザーがいなければ投稿できない' do
        @article.user = nil
        @article.valid?
        expect(@article.errors.full_messages).to include "User must exist"
      end
    end
  end
end
