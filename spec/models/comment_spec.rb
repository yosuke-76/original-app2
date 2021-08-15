require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe "comment作成" do
    context "commentの送信ができる時" do
      it "全ての情報を入力すると送信できる" do
        expect(@comment).to be_valid
      end
    end
    context "commentの送信ができない時" do
      it "textが空だと送信できない" do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Text can't be blank"
      end
      it "commentに紐づくuserがいないと送信できない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "User must exist"
      end
      it "commentに紐づくarticleが無いと送信できない" do
        @comment.article = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Article must exist"
      end
    end
  end
end
