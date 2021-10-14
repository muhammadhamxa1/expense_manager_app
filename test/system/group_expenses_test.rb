require "application_system_test_case"

class GroupExpensesTest < ApplicationSystemTestCase
  setup do
    @group_expense = group_expenses(:one)
  end

  test "visiting the index" do
    visit group_expenses_url
    assert_selector "h1", text: "Group Expenses"
  end

  test "creating a Group expense" do
    visit group_expenses_url
    click_on "New Group Expense"

    fill_in "Group name", with: @group_expense.group_name
    click_on "Create Group expense"

    assert_text "Group expense was successfully created"
    click_on "Back"
  end

  test "updating a Group expense" do
    visit group_expenses_url
    click_on "Edit", match: :first

    fill_in "Group name", with: @group_expense.group_name
    click_on "Update Group expense"

    assert_text "Group expense was successfully updated"
    click_on "Back"
  end

  test "destroying a Group expense" do
    visit group_expenses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group expense was successfully destroyed"
  end
end
