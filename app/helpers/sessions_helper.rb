module SessionsHelper
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end

    # Returns the current logged-in user (if any).
    def current_user
        # ====== Define current_user ======
        # if @current_user.nil?
        #     @current_user = User.find_by(id: session[:user_id])
        # else
        #     @current_user
        # end

        # ====== Shorter ======
        # @current_user = @current_user || User.find_by(id: session[:user_id])

        # ====== Proper idiomatic way to write Ruby ======

        @current_user ||= User.find_by(id: session[:user_id])
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end

    # Logs out the current user.
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
