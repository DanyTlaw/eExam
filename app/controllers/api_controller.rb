
  class ApiController < ApplicationController


    def apitest
      h = JSON.parse(request.body.read)
      # Gets the email adress in the hash
      puts h[0]["email"]
      sEmail = h[0]["email"]
      @student = Student.where(email: sEmail).first
      @student.update_attribute(:check, true)

      # Here it has to make a database event

      render text: "thanks for the post request: #{h}"
    end

    # Function to change the online status of the student
    def is_online
      studentInfo = JSON.parse(request.body.read)
      puts studentInfo[0]["email"]
      sEmail = studentInfo[0]["email"]
      student = Student.where(email: sEmail).first
      student.update_attribute(:online, true)
      render text: "The student is Online"
    end

    # Function to receive the file
    def logfile
      @student = Student.find(4);

      @student.file = params[:logfile]
      if @student.save!
        puts "SAAAAAAAAAAAAAAAAVE"
      else
        puts "NOOOOOOOOOOOO"
      end
      puts request
    end

    def apigettest
      render json: Student.all
    end

    def online
      studentInfo = Student.all
      response.headers['Content-Type'] = 'text/event-stream'
      sse = SSE.new(response.stream)
      begin
      sse.write(studentInfo)
      rescue IOError
      ensure
        sse.close
      end

    end

    def default_serializer_options
      {root: false}
    end

    def actiontest
    end

  end
