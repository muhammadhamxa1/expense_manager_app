class WalletPolicy < ApplicationPolicy
    def show?
      user.present? && user==record.user
    end

    def edit?
      user.present? && user==record.user
    end
    
    def destroy?
      user.present? && user==record.user
    end
    
    def new?
      false
    end
    
    def create?
      false
    end
end