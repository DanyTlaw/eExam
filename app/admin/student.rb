ActiveAdmin.register Student do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


  action_item :add, only: :show do
    link_to 'Download Logfile', download_file_admin_students_path(:id => student.id), method: :post
  end

  collection_action :download_file, method: :post do

  end

  controller do

      def download_file()
        @student = Student.find(params[:id]);
        send_file(@student.file.path,
          :filename => @student.file,
          :type => @student.file.content_type,
          :disposition => 'attachment',
          :url_based_filename => true)
      end
  end

end
