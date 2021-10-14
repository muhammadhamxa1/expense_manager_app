import { Controller } from 'stimulus'; 
export default class extends Controller {
  static targets=["userField"]
  connect()
  {
    console.log("Hello")
    this.userFieldTarget.hidden=true
    // this.expenseFormTarget.hidden=true
  }
  showFields()
  {
    if(this.userFieldTarget.hidden === true)
      this.userFieldTarget.hidden = false
    else
      this.userFieldTarget.hidden = true
  }
  showExpense()
  {
    // this.expenseFormTarget.hidden=false
  }
}