collection @courseitems
attributes :provider, :name, :description, :organisation, :image, :url, :status, :id
node(:cloned) { |courseitem| courseitem.cloned_by_current_user?(@user) }
