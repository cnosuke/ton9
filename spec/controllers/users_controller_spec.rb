# coding: utf-8
require 'spec_helper'

describe UsersController do
  context "Userとしてsign_inしている" do
    describe :show do
      it "??として???が返されている"
      it 'users/indexをレンダリングする'
    end
    describe :all do
      pending "保留"
    end
  end

  context "Userとしてsign_inしていない" do
    describe :show do
      it "sign_inページにリダイレクトされる"
    end
    describe :all do
      pending "保留"
    end
  end
end
