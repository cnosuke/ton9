# coding: utf-8
require 'spec_helper'

describe ApplicationController do
  controller do
    def after_sign_in_path_for(resource)
        super resource
    end
  end

  describe :after_sign_in_path_for do
    it "user_pathへのpathを返す" do
      @user = create :user
      controller.after_sign_in_path_for(@user).should
              eq("/users/#{@user.name}")
    end
  end
end
