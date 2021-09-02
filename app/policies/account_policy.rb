class AccountPolicy < ApplicationPolicy

    # def index?
    #   current_user.id== account.user_id
    # end
    def show?
      user.present? && user==record.user
    end
    def edit?
      user.present? && user==record.user
    end
    def destroy?
      user.present? && user==record.user
    end
    # def create?
    #   user.present?
    # end



    
     
end
