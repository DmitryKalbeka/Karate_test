@ignore
Feature: log in steps

Background:
        * def emailField = "//input[@name='identifier']"
        * def selectedUserDropDown = "//div[@role='link']"
        * def passwordField = "//input[@name='password']"
        * def nextButton = "//button[@type='button']//span[text()='Далее']"

    @logInAs
    Scenario: log in as
        When waitFor(emailField).input(email)
        * click(nextButton)
        * waitFor(selectedUserDropDown)
        * input(passwordField, password)
        * click(nextButton)
        Then waitForUrl("https://mail.google.com/mail/u/0/#inbox")