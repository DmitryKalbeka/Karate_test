@ignore
Feature: email steps

Background:
        * def newEmailButton = "//div[@role='button'][text()='Написать']"
        * def emailVidget = "//div[@role='dialog']"
        * def emailVidgetTitle = emailVidget + "//h2//span"
        * def closeEmailVidgetButton = emailVidget + "//*[@aria-label='Сохранить и закрыть']"
        * def toField = emailVidget + "//textarea[@name='to']"
        * def enteredRecipients = emailVidget + "//span[@email]/div[1]"
        * def subjectField = emailVidget + "//input[@name='subjectbox']"
        * def emailContetntTextArea = emailVidget + "//div[@role='textbox']"

    @createDraftEmail
    Scenario: create draft email
        When click(newEmailButton)
        * waitFor(emailVidget)
        * input(toField, reciepient)
        * input(subjectField, subject)
        * input(emailContetntTextArea, emailText)
        * waitForText(emailVidgetTitle, "Черновик сохранен")
        * mouse().move(closeEmailVidgetButton).click()
        Then waitForElementDisappear(emailVidget)

        @verifyEmail
    Scenario: verify email recipient, subject and text
        When waitFor(emailVidget)
        Then assert text(enteredRecipients) == reciepient
        * assert text(emailVidgetTitle) == subject
        * assert text(emailContetntTextArea) == emailText
