class AccountPolicy < ApplicationPolicy

    def index?
      user.present?
    end
    
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
