class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }
    private
    def logged_in_user
        unless loggedin?
            redirect_to "login"
        end
    end

end
