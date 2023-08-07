class HackerMysteryController < ApplicationController
    def index
        render layout: false
    end
    def login
        render layout: false
    end
    def account
        account = {'id' => '112358','password' => 'ソースコードを見てみよう'}
        render :json => account
    end
end
