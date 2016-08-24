class ApiController < ApplicationController

    # Function for set the ready status
    def setReady
      # The JSON file includes course_of_study, course and emailadresse and saves it in a hash
      info = JSON.parse(request.body.read)
      # Gets the informations in the hash
      course_of_study = info[0]["course_of_study"]
      course = info[0]["course"]
      email = info[0]["email"]
      # gets the course entry with the specific course name
      course_entry = Course.where(name: course)
      # gets the student in this course with the correct email adresse
      student = Student.where(course_id: course_entry).where(email: email).first
      # updates the student so that his check value gets true
      student.update_attribute(:check, true)
    end



    # Function to send the encryption code
    def send_enc
      h = Hash.new
      # The password should be stored at a better place then here, best case would be with ENV and .env file
      h = {:key => "meinpassword"}
      render json: h.to_json
    end

    # Function to change the online status of the student
    def is_online
      # The JSON file includes course_of_study, course and emailadresse
      info = JSON.parse(request.body.read)
      # Gets the informations in the hash
      course_of_study = info[0]["course_of_study"]
      course = info[0]["course"]
      email = info[0]["email"]
      # gets the course entry with the specific course name
      course_entry = Course.where(name: course)
      # gets the student in this course with the correct email adresse
      student = Student.where(course_id: course_entry).where(email: email).first
      # Updates the value of online to true when he is online
      student.update_attribute(:online, true)

    end

    # Function to receive the file
    def logfile
      # The JSON file includes course_of_study, course and emailadresse

      puts request.body.read
      puts params[:course]

      # Gets the informations in the hash
      course_of_study = params[:course_of_study]
      puts params[:course_of_study]
      course = params[:course]
      email = params[:email]
      # gets the course entry with the specific course name
      course_entry = Course.where(name: course)
      # gets the student in this course with the correct email adresse
      student = Student.where(course_id: course_entry).where(email: email).first

      student.file = params[:logfile]
      if student.save!
        puts "File is saved"
      else
        puts "file is not send"
      end
    end

    def default_serializer_options
      {root: false}
    end

end
