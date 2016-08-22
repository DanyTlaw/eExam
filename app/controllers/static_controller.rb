class StaticController < ApplicationController
    include ApplicationHelper
    def home
      @student = Student.find(4)
      decrypt_file(@student)

    end
end
