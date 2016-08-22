ActiveAdmin.register Student do

  # Include the Application helper to get acces to the decrypt funtion
  #include ApplicationHelper

  action_item :add, only: :show do
    link_to 'Download Logfile', download_file_admin_students_path(:id => student.id), method: :post
  end

  collection_action :download_file, method: :post do

  end

  controller do

    # Function that takes a student and decrypt file and returns it
    def decrypt_file(student)
        # Rails public path
        p_path = Rails.public_path.to_s
        # Path where the files are uploaded
        u_path = "/uploads/student/file"
        # Recreate all the parts to do the filename
        email = student.email
        # Splits the email for example daniel.herzog@students.fhnw.ch at the @ and returns two strings
        name_email = email.split("@")
        # the first part of the string is now daniel.herzog witch we want to acces
        name = name_email[0]
        # we want to create a final name that has 3 parts (name/course_of_study/course.txt) -> daniel.herzogSWE2WI.txt
        file_name = name + student.course.name + student.course.course_of_study.name +  ".txt"
        puts file_name
        # creates a new file for the decrypted text
        dec_file = File.new("dec_file.txt", "w+")
        # cipher for decrypt each line of the txt file with the same password used for encryption
        cipher = Gibberish::AES::CBC.new('meinpassword')
        # the received file only has one encrypted sentence per line (This is important!)
        # Open the logfile of the specific student
        File.open(p_path + u_path +"/" + student.id.to_s + "/" + file_name) do |f|
          # For each line in the encrypted file decrypt it and add it in the new file
          f.each_line do |line|
            # Open then new file and add the line
            File.open(dec_file, "a+") do |file|
              file << cipher.decrypt(line) + "\n"
              puts cipher.decrypt(line)
            end
          end
        end
        # return the new file
        return dec_file
    end

      def download_file()
        @student = Student.find(params[:id]);
        # Here we wanna decrypt the file
        send_file(decrypt_file(@student),
          :filename => @student.file,
          :type => @student.file.content_type,
          :disposition => 'attachment',
          :url_based_filename => true)
      end
  end

end
