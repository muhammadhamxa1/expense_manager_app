import { Controller } from 'stimulus'; 
export default class extends Controller {
  static targets=["selectType","selectDate","selectTransferFromTo","transferFromId","transferTransferType","selectTransferTo","transferToId","transferToType","categorySelect","selectTransaction","modal","calender","date","set_date"]
  
  connect()
  {
    this.transferToIdTarget.disabled=true
    this.categorySelectTarget.hidden= true
    this.selectDateTarget.hidden= true
    this.selectTransferToTarget.hidden= true
    this.selectTransactionTarget.hidden= true
    this.selectTransferFromToTarget.hidden= true
  }

  typeSelection()
  {
    console.log(this.selectTypeTarget.value)
    if (this.selectTypeTarget.value == "Expense"){
        this.selectDateTarget.hidden= false
        this.selectTransferToTarget.hidden= true
        this.selectTransactionTarget.hidden= false
        this.selectTransferFromToTarget.hidden= false
        this.categorySelectTarget.hidden= false
    }
    else if (this.selectTypeTarget.value == "Income"){
      this.categorySelectTarget.hidden= true
      this.selectDateTarget.hidden= false
      this.selectTransferToTarget.hidden= true
      this.selectTransactionTarget.hidden= false
      this.selectTransferFromToTarget.hidden= false
    }
    else if (this.selectTypeTarget.value == "Transfer"){
      this.categorySelectTarget.hidden= true
      this.categorySelectTarget.disabled=true
      this.selectDateTarget.hidden= false
      this.selectTransferToTarget.hidden= false
      this.selectTransactionTarget.hidden= false
      this.selectTransferFromToTarget.hidden= false
    }
    else
    {
      this.categorySelectTarget.hidden= true
      this.selectDateTarget.hidden= true
      this.selectTransferFromToTarget.hidden= true
      this.selectTransactionTarget.hidden= true
      this.selectTransferToTarget.hidden= true 
    }

  }

  transferFrom()
  {
    this.transferToIdTarget.disabled=true
    console.log(this.transferFromIdTarget.selectedIndex)
    let var1=this.transferFromIdTarget.length
  
    var1 -= 1
    
    let e= this.transferFromIdTarget.selectedIndex
    
    if(this.selectTypeTarget.value === "Transfer")
    {
      this.transferToIdTarget.disabled=false
      for (var i = 1; i <= var1; i++) {
        this.transferToIdTarget.options[i].disabled=false
        console.log(this.transferToIdTarget.options[i].disabled)
      } 
    }

    if(var1 == e)
    {
      this.transferTransferTypeTarget.value="Wallet"
      if(this.selectTypeTarget.value === "Transfer")
      {
        this.transferToIdTarget.options[e].disabled=true
      }
    }
    else if(e>0 && e<var1)
    {
      this.transferTransferTypeTarget.value="Account"
      if(this.selectTypeTarget.value === "Transfer")
      {
        this.transferToIdTarget.options[e].disabled=true
        // for (var i = 1; i < var1; i++) {
        //   this.transTarget.options[i].disabled=true
        //   console.log(this.transTarget.options[i].disabled)
        // }  
      }     
    }
  }

  transfer() 
  {
    console.log(this.transferToTypeTarget)
    let var1=this.transferToIdTarget.length
  
    var1 -= 1
    
    let er= this.transferToIdTarget.selectedIndex
    
    if(var1 == er)
    {
      this.transferToTypeTarget.value="Wallet"
    }
    else if(er>0 && er<var1)
    {
      this.transferToTypeTarget.value="Account"
    }
  }

  show_me(event)
  {
    this.modalTarget.hidden= false
    this.calenderTarget.hidden= true
    // console.log("hello");
    event.preventDefault()
    // console.log(event.target.dataset.value )
    this.set_dateTarget.value=event.target.dataset.value
    // this.set_dateTarget.value=this.dateTarget.innerHTML

  }
   
}