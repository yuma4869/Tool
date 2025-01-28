class IndexController < ApplicationController
    def base
    end

    def mascot
        $left_key = params[:left_key]
        $right_key = params[:right_key]
        $left_click = params[:left_click]
        $right_click = params[:right_click]
        $others = params[:others]
        redirect_to "/"
    end
    
    def about
    end

    def me
    end

    def wait
        render layout: false
    end

    def security
    end
    
end