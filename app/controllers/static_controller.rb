class StaticController < ApplicationController
    include ApplicationHelper
    def home
      decrypt_file

    end
end
