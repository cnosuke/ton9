# coding: utf-8
require 'spec_helper'

describe BindersController do
  
  context "userとしてログインしているとき" do
    describe :create do
      context "成功した時" do
        describe "データベース操作" do
          it "Binderが作成されている"
          it "作成されたBinderは作成者からアクセス権がある"
        end
        describe "Jsonデータ" do
          it "resultとして1が返される"
          it "dataとしてbinderデータが返される"
        end
      end
      context "失敗した時" do
        describe "データベース操作関係" do
          it "Binderが作成されていない"
        end
        describe "Jsonデータ" do
          it "resultとして0が返される"
          it "messageとして'Binder save faild.'が返される"
          it "dataはない"
        end
      end
    end

    describe :add_documents do
      context "(Binder)bに入っていない∧(User)current_userが管理している(Document)dのとき" do
        describe "データベース操作" do
          it "DocumentがBinderに追加される"
        end
        describe "Jsonデータ" do
          it "resultとして1が返される"
          it "dataとしてbinderデータが返される"
        end
      end

      context "(Binder)bに入っている∧(User)current_userが管理している(Docment)dのとき" do
        describe "データベース操作" do
          it "DocumentがBinderに追加されない"
        end
        describe "Jsonデータ" do
          it "resultとして0が返される"
          it "messageとして'Document already included in Binder.'が返される"
          it "dataとしてbinderデータが返される"
        end
      end

      context "(User)current_userが管理していない(Docment)dのとき" do
        describe "データベース操作" do
          it "DocumentがBinderに追加されない"
        end
        describe "Jsonデータ" do
          it "resultとして0が返される"
          it "messageとして'The Document is not managed by CurrentUser.'が返される"
          it "dataとしてbinderデータが返される"
        end
      end

      context "Binderのvalidation error時" do
        describe "データベース操作" do
          it "DocumentがBinderに追加されない"
        end
        describe "Jsonデータ" do
          it "resultとして0が返される"
          it "messageとして'Binder save faild.'が返される"
          it "dataはない"
        end
      end
    end
  end

  context "userとしてログインしていないとき" do
    describe :create do
      describe "データベース操作関係" do
        it "Binderが作成されていない"
      end
      describe "Jsonデータ" do
        it "resultとして0が返される"
        it "messageとして'Please sign_in.'が返される"
        it "dataはない"
      end
    end
    describe :add_documents do
      describe "データベース操作" do
        it "DocumentがBinderに追加されない"
      end
      describe "Jsonデータ" do
        it "resultとして0が返される"
        it "messageとして'Please sign_in.'が返される"
        it "dataはない"
      end
    end
  end
end
