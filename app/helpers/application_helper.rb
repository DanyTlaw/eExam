module ApplicationHelper



  # Function for decrypting File
  def decrypt_file
      # creates a new file for the decrypted text
      

      # cipher for decrypt each line of the txt file with the same password used for encryption
      cipher = Gibberish::AES::CBC.new('meinpassword')
      # the received file only has one encrypted sentence per line (This is important!)
      # Open the logfile of the specific student
      File.open(Rails.public_path.to_s + "/uploads/student/file/4/qww.txt") do |f|
        f.each_line do |line|

            puts cipher.decrypt(line)
        end
      end
  end

end
