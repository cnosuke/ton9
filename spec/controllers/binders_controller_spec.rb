# coding: utf-8
require 'spec_helper'
require 'pp'

describe BindersController do
  share_examples_for '(TT)jsonリクエストになる' do
    describe "TT" do
      let(:binder_attributes) {{:binder => attributes_for(:binder)}}
      define_dummy_controller :create

      it "jsonリクエストになっている" do
        post :create
        response.content_type.should eq("application/json")
      end
    end  
  end

  share_examples_for '(TT)htmlリクエストになる' do
    describe "TT" do
      let(:binder_attributes) {{:binder => attributes_for(:binder)}}
      define_dummy_controller :create

      it "htmlリクエストになっている" do
        post :create
        response.content_type.should eq("text/html")
      end
    end  
  end

  describe :create do
    let(:binder_attributes) {{:binder => attributes_for(:binder)}}
    let(:user) { create :user }
    before { sign_in user }
    before {request.env["HTTP_ACCEPT"] = "application/json"}

    context "正当である時" do
      describe "Test" do
        it %Q{(TT)sign_inしている} do
          controller.user_signed_in?.should eq(true)
          controller.current_user.should eq(user)
        end # TT sign_in

        it_should_behave_like '(TT)jsonリクエストになる'

        it "(TT)binder_attributesは正当なBinderのアトリビュート" do
          Binder.new(binder_attributes[:binder]).should be_valid
        end
      end

      it "status = 200" do
        post :create, binder_attributes
        response.status.should eq(200)
      end

      it "Binderが作成される" do
         expect {
            post :create, binder_attributes
           }.to change{ Binder.count }.by(1)
      end

      it "新しいBinderは現在のユーザに権限がある" do
        post :create, binder_attributes
        Binder.last.users.should include(user)
      end

      describe "jsonデータ" do
        before { post :create, binder_attributes }
        subject { JSON.parse(response.body) }

        it ":result => 1" do
          should include("result" => 1)
        end

        it ":data => Binderデータ" do
          should include("data" => JSON.parse(Binder.last.to_json))
        end
      end # jsonデータ
    end # 正当である時


    context "sign_inしていない時" do
      before { sign_out user }

      describe "Test" do
        it %Q{(TT)sign_inしていない} do
          controller.user_signed_in?.should eq(false)
        end # TT sign_in
      end

      it "status = 200" do
        post :create, binder_attributes
        response.status.should eq(200)
      end

      it "Binderが作成されない" do
        expect {
          post :create, binder_attributes
        }.to_not change{ Binder.count }
      end

      describe "jsonデータ" do
        before do
          post :create, binder_attributes
        end
        subject {JSON.parse(response.body)}

        it ":result => 0" do
          should include("result" => 0)
        end
        it ":message => 'Please sign_in.'" do
          should include("message" => 'Please sign_in.')
        end
      end # jsonデータ
    end # sign_inしていない時

    context %Q(htmlリクエスト時) do
      before { request.env["HTTP_ACCEPT"] = "text/html" }
      describe %Q{Test} do
        define_dummy_controller :create

        it "(TT)htmlリクエストになる" do
          post :create
          response.content_type.should eq("text/html")
        end
      end # Test
        
      it "status = 406" do
        post :create, binder_attributes
        response.status.should eq(406)
      end

      it "Binderが作成されない" do
        expect {
          post :create, binder_attributes
        }.to_not change{ Binder.count }
      end
    end # htmlリクエスト

    context %Q(バリデーションが通らなかった時) do
      before { Binder.any_instance.stub(:save).and_return(false) }

      it "(TT)強制的にvalidation error" do
        Binder.new(binder_attributes[:binder]).save.should be_false
      end
      
      it "status = 200" do
        post :create, binder_attributes
        response.status.should eq(200)
      end

      it "Binderが作成されない" do
        expect {
          post :create, binder_attributes
          }.to_not change{ Binder.count }
      end

      describe "jsonデータ" do
        before do
          post :create, binder_attributes
        end
        subject {JSON.parse(response.body)}

        it ":result => 0" do
          should include("result" => 0)
        end

        it ":message => 'Binder save faild.'" do
          should include("message" => 'Binder save faild.')
        end
      end # jsonデータ
    end # バリデーションが通らなかった時
  end # create

  describe :add_documents do
    let(:user) { create :user }
    let(:document) { create :document, :user_id => user.id }
    let(:binder) { create :binder }
    let(:valid_hash) do
      {:user_id => user.name, :document_id => document.id, :binder_id => binder.id }
    end
    before { request.env["HTTP_ACCEPT"] = "application/json" }
    before { sign_in user }
    before { binder.users << user }

    context "正当である時" do
      describe "Test" do
        it %Q{(TT)sign_inしている} do
          controller.user_signed_in?.should eq(true)
          controller.current_user.should eq(user)
        end # TT sign_in

        it_should_behave_like '(TT)jsonリクエストになる'

        it "(TT)documentはuserの所有物" do
          user.documents.should include(document)
        end

        it "(TT)binderはuserに権限がある" do
          user.binders.should include(binder)
        end
        it "(TT)バリデーションが通る" do
          binder.documents << document
          binder.should be_valid
        end
      end # Test

      it "BinderにDocumentが追加される" do
        expect {
          post :add_documents, valid_hash
        }.to change{ binder.documents.count }.by(1)
      end

      describe "jsonデータ" do
        before do
          post :add_documents, valid_hash
        end
        subject {JSON.parse(response.body)}

        it ":result => 1" do
          should include("result" => 1)
        end

        it ":data => Binderデータ" do
          should include("data" => JSON.parse(binder.to_json))
        end
      end # jsonデータ
    end # 正当である時

    context "sign_inしていない時" do
      before {sign_out user}

      describe "Test" do
        it "(TT)sign_inしていない" do
          controller.user_signed_in?.should eq(false)
        end # TT sign_inしていない
      end

      it "BinderにDocumentが追加されない" do
        expect {
          post :add_documents, valid_hash
        }.to_not change{ binder.documents.count }
      end

      describe "jsonデータ" do
        before do
          post :add_documents, valid_hash
        end
        subject {JSON.parse(response.body)}

        it ":result => 0" do
          should include("result" => 0)
        end

        it ":message => 'Please sign_in.'" do
          should include("message" => 'Please sign_in.')
        end
      end # jsonデータ
    end

    context "documentがuserの所有物でない時" do
      before do
        document.user = create(:user)
        document.save
      end

      describe "Test" do
        it "(TT)documentがuserの所有物でない" do
          user.documents.should_not include(document)
        end
      end

      it "BinderにDocumentが追加されない" do
        expect {
          post :add_documents, valid_hash
        }.to_not change{ binder.documents.count }
      end

      describe "jsonデータ" do
        before do
          post :add_documents, valid_hash
        end
        subject {JSON.parse(response.body)}

        it ":result => 0" do
          should include("result" => 0)
        end

        it ":message => 'You don't have this document.'" do
          should include("message" => "You don't have this document.")
        end
      end # jsonデータ
    end

    context "binderを操作する権限がuserにない時" do
      before do
        Holder.where(:binder_id => binder.id)
              .where(:user_id => user.id)
              .delete_all
        user.reload
        binder.reload
      end

      describe "Test" do
        it "(TT)binderを操作する権限がuserにない" do
          user.binders.should_not include(binder)
          binder.users.should_not include(user)
        end
      end

      it "BinderにDocumentが追加されない" do
        expect {
          post :add_documents, valid_hash
        }.to_not change{ binder.documents.count }
      end

      describe "jsonデータ" do
        before do
          post :add_documents, valid_hash
        end
        subject {JSON.parse(response.body)}

        it ":result => 0" do
          should include("result" => 0)
        end

        it ":message => 'permission denied.'" do
          should include("message" => "Permission denied.")
        end
      end # jsonデータ
    end

    context "バリデーションが通らない時" do
      before { Binder.any_instance.stub(:save).and_return(false) }

      describe "Test" do
        it "(TT)バリデーションが通らない" do
          binder.documents << document
          binder.save.should be_false
        end
      end

      it "BinderにDocumentが追加されない" do
        expect {
          post :add_documents, valid_hash
        }.to_not change{ binder.documents.count }
      end

      describe "jsonデータ" do
        before do
          post :add_documents, valid_hash
        end
        subject {JSON.parse(response.body)}

        it ":result => 0" do
          should include("result" => 0)
        end

        it ":message => 'permission denied.'" do
          should include("message" => "Binder save faild.")
        end
      end # jsonデータ
    end
  end # add_documents


end

=begin

  describe :index do
    pending "保留"
  end
end
=end

